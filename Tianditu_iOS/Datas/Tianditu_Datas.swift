//
//  Datas.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/11.
//  Copyright © 2018年 JT. All rights reserved.
//
import CoreData
import JTFramework

class Tianditu_Datas {
    
    internal static let shareInstance = Tianditu_Datas()
    private init() {}
    
    private let persistentContainerName = "Tianditu_iOS"
    private let coreDataSqliteName = "CoreData.sqlite"
    
    func saveContext() {
        if #available(iOS 10.0, *) {
            saveContext10()
        } else {
            // Fallback on earlier versions
        }
    }
    
    private lazy var manageObjectContext: NSManagedObjectContext = {
        if #available(iOS 10.0, *) {
            return persistentContainer.viewContext
        } else {
            return managedObjectContext
        }
    }()

    @available(iOS 10.0 , *)
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        })
        return container
    }()
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        guard let docUrl = JTFile.shareInstance.documentURL else { abort() }
        let url = docUrl.appendingPathComponent(coreDataSqliteName)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        }
        catch { abort() }
        return coordinator
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: persistentContainerName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    @available(iOS 10.0, *)
    private func saveContext10 () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }

}
