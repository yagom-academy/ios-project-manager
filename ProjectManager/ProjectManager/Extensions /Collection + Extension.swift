import Foundation

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return Indices.contains(Index) ? self[Index] : nil
    }
}
