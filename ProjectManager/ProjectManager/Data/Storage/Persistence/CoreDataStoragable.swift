//
//  CoreDataStoragable.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/24.
//

import CoreData

protocol CoreDataStoragable {
  func saveContext() -> Bool
  func createObject(for entityName: String) -> NSManagedObject?
  func fetchObject(for entityName: String, id: String) -> NSManagedObject?
  func fetchObjects(for entityName: String) -> [NSManagedObject]?
  func deleteObjectWithSave(for entityName: String, id: String) -> Bool
  func deleteObjects(for entityName: String) -> Bool
}
