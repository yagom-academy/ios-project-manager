import UIKit

extension UIView {
    func dropShadow(cornerRadius: CGFloat, backgroundColor: CGColor, borderColor: CGColor, shadowColor: CGColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}

