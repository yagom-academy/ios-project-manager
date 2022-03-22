import Foundation

enum ViewControllerError: Error {
    case invalidViewController
    case initializerNotImplemented
    
    var description: String {
        switch self {
        case .invalidViewController:
            return "유효한 ViewController가 존재하지 않습니다."
        case .initializerNotImplemented:
            return "init(code:)가 비정상 작동합니다."
        }
    }
}
