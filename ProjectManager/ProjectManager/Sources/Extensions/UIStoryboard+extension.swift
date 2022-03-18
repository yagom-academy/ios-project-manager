import UIKit

/// case에 해당하는 스토리보드를 반환하는 열거형 타입
enum Storyboard: String {
    case main = "Main"
    case detail = "Detail"
    
    func storyboard() -> UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
}


/// Storyboard 타입의 프로퍼티와 associatedtype 타입의 ViewModel을  정의하고 있는 프로토콜
protocol StoryboardCreatable {
    associatedtype ViewModel
    static var storyboard: Storyboard { get }
    var viewModel: ViewModel { get set }
}

extension StoryboardCreatable {
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    /// ViewController 내부에 ViewModel을 할당해주는 메소드
    mutating func configureWithViewModel(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

extension StoryboardCreatable where Self: UIViewController {
    /// 스토리보드에서 ViewController를 가져와서 ViewModel을 주입해주는 메소드
    /// - Parameter viewModel: ViewController에 주입할 ViewModel
    /// - Returns: ViewModel이 할당된 ViewController를 반환한다.
    static func createFromStoryboard(viewModel: ViewModel) -> Self {
        var viewController: Self = UIStoryboard.createViewController()
        viewController.configureWithViewModel(viewModel: viewModel)
        return viewController
    }
}

extension UIStoryboard {
    /// 스토리보드에서 ViewController를 인스턴스화 시켜주는 메소드
    /// - Returns: ViewController를 반환한다.
    static func createViewController<T: StoryboardCreatable>() -> T {
        let storyboard = UIStoryboard(name: T.storyboard.rawValue, bundle: nil)
        let createViewController = storyboard.instantiateViewController(withIdentifier: T.storyboardIdentifier)
        guard let viewController =  createViewController as? T else {
            fatalError("Expected view controller with identifier \(T.storyboardIdentifier)")
        }
        return viewController
    }
}
