import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func localized(with arguments: CVarArg...) -> String {
        let localizedValue = self.localized()
        return String(format: localizedValue, arguments: arguments)
    }
}
