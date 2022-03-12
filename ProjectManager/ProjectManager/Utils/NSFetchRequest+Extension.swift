import CoreData

extension NSFetchRequest {
    @objc func isNotInclude(input: Any) -> Bool {
        guard let predicate = self.predicate else { return true }
        return !predicate.evaluate(with: input)
    }
}
