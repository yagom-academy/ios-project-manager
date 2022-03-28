import Foundation


protocol ViewModelDescribing {
    
    associatedtype Input
    associatedtype Output
    
    // MARK: - Method
    func transform(_ input: Input) -> Output
    
}
