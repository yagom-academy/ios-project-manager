import Foundation


protocol ViewModelDescribing {
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
    
}
