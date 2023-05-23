//
//  UIContorl+Combine.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/22.
//

import UIKit
import Combine
//
//final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
//    private var subscriber: SubscriberType?
//    private let control: Control
//
//    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
//        self.subscriber = subscriber
//        self.control = control
//        control.addTarget(self, action: #selector(eventHandler), for: event)
//    }
//
//    func request(_ demand: Subscribers.Demand) { }
//
//    func cancel() {
//        subscriber = nil
//    }
//
//    @objc
//    private func eventHandler() {
//        _ = subscriber?.receive(control)
//    }
//}
//
//struct UIControlPublisher: Publisher {
//
//    typealias Output = UIControl
//    typealias Failure = Never
//
//    let control: UIControl
//    let controlEvents: UIControl.Event
//
//    init(control: UIControl, events: UIControl.Event) {
//        self.control = control
//        self.controlEvents = events
//    }
//
//    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
//        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
//        subscriber.receive(subscription: subscription)
//    }
//}

extension UIControl {
    struct EventPublisher: Publisher {
        typealias Output = Void
        typealias Failure = Never
        
        fileprivate var control: UIControl
        fileprivate var event: Event
        
        func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
            let subscription = EventSubscription<S>()
            subscription.target = subscriber
            
            subscriber.receive(subscription: subscription)
            
            control.addTarget(
                subscription,
                action: #selector(subscription.trigger),
                for: event
            )
        }
    }
}

private extension UIControl {
    class EventSubscription<Target: Subscriber>: Subscription where Target.Input == Void {
        
        var target: Target?
        
        func request(_ demand: Subscribers.Demand) { }
        
        func cancel() {
            target = nil
        }
        
        @objc
        func trigger() {
            target?.receive(())
        }
    }
}

extension UIControl {
    func publisher(for event: Event) -> EventPublisher {
        EventPublisher(
            control: self,
            event: event
        )
    }
}

//protocol CombineCompatible { }
//extension UIControl: CombineCompatible { }
//extension CombineCompatible where Self: UIControl {
//    func publisher(for events: UIControl.Event) -> UIControlPublisher {
//        return UIControlPublisher(control: self, events: events)
//    }
//}
