import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func localized(with arguments: [CVarArg] = [], comment: String = "") -> String {
        return String(format: self.localized(comment: comment), arguments: arguments)
    }
}
