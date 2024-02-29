//
//  CacheManager.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 19/08/1445 AH.
//

import CoreData
import UIKit

class CacheManager {

    static let shared = CacheManager()

    private init() {}

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MiniApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveEntity<T: NSManagedObject>(entity: T.Type, withValues values: [String: Any]) {
        guard let entityName = NSStringFromClass(T.self).components(separatedBy: ".").last,
              let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            fatalError("Invalid entity name: \(T.self)")
        }

        let newEntity = T(entity: entityDescription, insertInto: context)
        values.forEach { key, value in
            newEntity.setValue(value, forUndefinedKey: key)
        }
        saveContext()
    }

    
    func retrieveEntities<T: NSManagedObject>(entity: T.Type) -> [T] {
        let fetchRequest = T.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest) as! [T]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteEntity<T: NSManagedObject>(_ entity: T) {
           context.delete(entity)
           saveContext()
    }
    
    func clearStorage<T: NSManagedObject>(for entityType: T.Type) {
        let entityName = String(describing: entityType)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            saveContext() // Make sure you have a method to save the context after changes
        } catch let error as NSError {
            print("Error clearing \(entityName) storage: \(error), \(error.userInfo)")
        }
    }

    
}
