//
//  Data_RouteHistoryOperate.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import CoreData

class Data_RouteHistoryOperate {
    internal static let shareInstance = Data_RouteHistoryOperate()
    private init() {}
    private let entityName = "Data_RouteHistory"
}
extension Data_RouteHistoryOperate {
    
    func insert(
        startType: RouteType,
        startName: String? = nil,
        startX: Double,
        startY: Double,
        stopType: RouteType,
        stopName: String? = nil,
        stopX: Double,
        stopY: Double) -> Bool {
        let m = NSEntityDescription.insertNewObject(forEntityName: entityName, into: Tianditu_Datas.shareInstance.managedObjectContext) as? Data_RouteHistory
        guard let d = m else { return false }
        d.startType = startType.rawValue
        d.startName = startName
        d.startX = startX
        d.startY = startY
        d.stopType = stopType.rawValue
        d.stopName = stopName
        d.stopX = stopX
        d.stopY = stopY
        d.uuid = UUID().uuidString
        do {
            try Tianditu_Datas.shareInstance.managedObjectContext.save()
            return true
        }
        catch { return false }
    }
    
    func clear() -> Bool {
        let fetchRequest = NSFetchRequest<Data_RouteHistory>(entityName: entityName)
        guard let sr = try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest) else { return false }
        guard sr.count > 0 else { return true }
        for x in sr {
            Tianditu_Datas.shareInstance.managedObjectContext.delete(x as NSManagedObject)
        }
        do {
            try Tianditu_Datas.shareInstance.managedObjectContext.save()
            return true
        }
        catch { return false }
    }

    func getByUUID(uuid: String) -> [Data_RouteHistory]? {
        let fetchRequest = NSFetchRequest<Data_RouteHistory>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", uuid)
        return try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest)
    }
    func getAll() -> [Data_RouteHistory]? {
        let fetchRequest = NSFetchRequest<Data_RouteHistory>(entityName: entityName)
        return try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest)
    }

    func deleteByUUID(uuid: String) -> Bool {
        guard let ds = getByUUID(uuid: uuid), ds.count > 0 else { return true }
        for d in ds {
            Tianditu_Datas.shareInstance.managedObjectContext.delete(d as NSManagedObject)
        }
        do {
            try Tianditu_Datas.shareInstance.managedObjectContext.save()
            return true
        }
        catch { return false }
    }
}
