//
//  CardToastLabel.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/25.
//

import UIKit

final class CardToastLabel: UILabel {
  struct ToastConfiguration {
    let duration: TimeInterval = 0.8
    let delay: TimeInterval = 0.2
    let damping: CGFloat = 1.0
    let velocity: CGFloat = 1.0
  }
  
  private let duration: TimeInterval
  private let delay: TimeInterval
  private let damping: CGFloat
  private let velocity: CGFloat
  
  init(
    configuration: ToastConfiguration,
    text: String
  ) {
    self.duration = configuration.duration
    self.delay = configuration.delay
    self.damping = configuration.damping
    self.velocity = configuration.velocity
    
    let frame: CGRect = CGRect(
      x: UIScreen.main.bounds.width / 2 - 100,
      y: UIScreen.main.bounds.height,
      width: 200,
      height: 50
    )
    
    super.init(frame: frame)
    self.text = text
    configureLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func show() {
    UIView.animate(
      withDuration: duration,
      delay: delay,
      usingSpringWithDamping: damping,
      initialSpringVelocity: velocity,
      options: .autoreverse
    ) { [weak self] in
      self?.transform = CGAffineTransform(translationX: .zero, y: -100)
    } completion: { [weak self] _ in
      self?.removeFromSuperview()
    }
  }
}

// MARK: - UI Configuration

extension CardToastLabel {
  private func configureLayouts() {
    backgroundColor = .systemGreen.withAlphaComponent(0.8)
    font = .preferredFont(forTextStyle: .headline)
    textAlignment = .center
    textColor = .white
    layer.cornerRadius = 25
    clipsToBounds = true
  }
}
