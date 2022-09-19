//
//  List.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/15.
//

import UIKit

extension ListCollectionView: UIGestureRecognizerDelegate {
    
    func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(gestureRecognizer:))
        )
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        addGestureRecognizer(longPressedGesture)
    }
    
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: self)
        let state = gestureRecognizer.state
        switch state {
        case .began:
            animateLongPressBegin(at: location)
        case .ended:
            animateLongPressEnd(at: location)
        default:
            return
        }
    }
    
    private func animateLongPressBegin(at location: CGPoint) {
        guard let indexPath = indexPathForItem(at: location) else { return }
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            guard let cell = self.cellForItem(at: indexPath) as? ListCell else { return }
            self.currentLongPressedCell = cell
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    private func animateLongPressEnd(at location: CGPoint) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            guard let cell = self.currentLongPressedCell else { return }
            cell.transform = .init(scaleX: 1, y: 1)
            guard let indexPath = self.indexPathForItem(at: location) else { return }
            guard cell == self.cellForItem(at: indexPath) as? ListCell else { return }
            self.transitionDelegate?.cellDidLongPressed(
                in: self,
                location: (Double(location.x), Double(location.y)),
                item: self.viewModel.list[indexPath.row]
            )
        }
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension ListCollectionView: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
