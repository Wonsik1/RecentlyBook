//
//  CoreDataManager.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookModel")
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("CoreData Load Error: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}

