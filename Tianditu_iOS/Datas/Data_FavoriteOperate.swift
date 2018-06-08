//
//  Data_FavoritesOperate.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import CoreData

class Data_FavoriteOperate {
    
    internal static let shareInstance = Data_FavoriteOperate()
    private init() {}
    
    private let entityName = "Data_Favorite"
    
}
extension Data_FavoriteOperate {
    func insert(
        address: String? = nil,
        county: String? = nil,
        datafrom: Int16? = nil,
        id: Int64? = nil,
        imageAddress: String? = nil,
        name: String,
        phone: String? = nil,
        region: String? = nil,
        typeStr: String? = nil,
        x: Double? = nil,
        y: Double? = nil) -> Bool {
        var xid: Int64 = 0
        if let iidd = id { xid = iidd }
        if exist(id: xid, name: name) { _ = deleteByIDAndName(id: xid, name: name) }
        guard let d = NSEntityDescription.insertNewObject(forEntityName: entityName, into: Tianditu_Datas.shareInstance.managedObjectContext) as? Data_Favorite else { return false }
        d.address = address
        d.county = county
        if let df = datafrom { d.datafrom = df }
        d.id = xid
        d.imageAddress = imageAddress
        d.name = name
        d.phone = phone
        d.region = region
        d.typeStr = typeStr
        d.index = Data_FavoriteIndexOperate.shareInstance.get()
        if let xx = x { d.x = xx }
        if let yy = y { d.y = yy }
        d.uuid = UUID().uuidString
        do {
            try Tianditu_Datas.shareInstance.managedObjectContext.save()
            return true
        }
        catch { return false }
    }
    func exist(id: Int64, name: String) -> Bool {
        let fetchRequest = NSFetchRequest<Data_Favorite>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@ && name = %@", String(id), name)
        if let x = try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest) {
            return x.count > 0
        }
        return false
    }
    func clear() -> Bool {
        let fetchRequest = NSFetchRequest<Data_Favorite>(entityName: entityName)
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
    func getByUUID(uuid: String) -> [Data_Favorite]? {
        let fetchRequest = NSFetchRequest<Data_Favorite>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", uuid)
        return try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest)
    }
    func getByIDAndName(id: Int64, name: String) -> [Data_Favorite]? {
        let fetchRequest = NSFetchRequest<Data_Favorite>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@ && name = %@", String(id), name)
        return try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest)
    }
    func getAll() -> [Data_Favorite]? {
        let fetchRequest = NSFetchRequest<Data_Favorite>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: false)]
        return try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest)
    }
    func deleteByIDAndName(id: Int64, name: String) -> Bool {
        guard let ds = Data_FavoriteOperate.shareInstance.getByIDAndName(id: id, name: name), ds.count > 0 else { return true }
        for d in ds {
            Tianditu_Datas.shareInstance.managedObjectContext.delete(d as NSManagedObject)
        }
        do {
            try Tianditu_Datas.shareInstance.managedObjectContext.save()
            return true
        }
        catch { return false }
    }
    func deleteByUUID(uuid: String) -> Bool {
        guard let ds = Data_FavoriteOperate.shareInstance.getByUUID(uuid: uuid), ds.count > 0 else { return true }
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
