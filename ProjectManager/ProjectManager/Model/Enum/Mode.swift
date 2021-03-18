import Foundation

enum Mode {
    case editable
    case readOnly
    
    var barButtonTitle: String {
        switch self {
        case .editable:
            return "Cancel"
        case .readOnly:
            return "Edit"
        }
    }
}
