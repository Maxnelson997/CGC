//
//  CoreDataManager.swift
//  CGC
//
//  Created by Max Nelson on 1/29/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CGC")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("loading of store failed: \(err)")
            }
        }
        return container
    }()
    

    func fetchSemesters() -> [Semester] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Semester>(entityName: "Semester")
        
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
        } catch let error {
            print("failed to fetch companies from core data:",error)
            return []
        }
    }
}