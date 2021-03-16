import Foundation

enum Mode {
    case editable
    case uneditable
    
    var barButtonTitle: String {
        switch self {
        case .editable:
            return "Cancel"
        case .uneditable:
            return "Edit"
        }
    }
}
