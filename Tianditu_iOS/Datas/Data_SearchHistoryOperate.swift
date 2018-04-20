//
//  Data_SearchHistory.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/20.
//  Copyright © 2018年 JT. All rights reserved.
//

import CoreData

class Data_SearchHistoryOperate {
    
    internal static let shareInstance = Data_SearchHistoryOperate()
    private init() {}
    
    private let entityName = "Data_SearchHistory"

}
extension Data_SearchHistoryOperate {
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
        let m = NSEntityDescription.insertNewObject(forEntityName: entityName, into: Tianditu_Datas.shareInstance.managedObjectContext) as? Data_SearchHistory
        guard let d = m else { return false }
        d.address = address
        d.county = county
        if let df = datafrom { d.datafrom = df }
        if let iidd = id { d.id = iidd }
        d.imageAddress = imageAddress
        d.name = name
        d.phone = phone
        d.region = region
        d.typeStr = typeStr
        if let xx = x { d.x = xx }
        if let yy = y { d.y = yy }
        d.uuid = UUID().uuidString
        do {
            try Tianditu_Datas.shareInstance.managedObjectContext.save()
            return true
        }
        catch { return false }
    }
    
    func clear() -> Bool {
        let fetchRequest = NSFetchRequest<Data_SearchHistory>(entityName: entityName)
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
    
    func getByUUID(uuid: String) -> [Data_SearchHistory]? {
        let fetchRequest = NSFetchRequest<Data_SearchHistory>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", uuid)
        return try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest)
    }
    func getByName(name: String) -> [Data_SearchHistory]? {
        let fetchRequest = NSFetchRequest<Data_SearchHistory>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        return try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest)
    }
    
    func getAll() -> [Data_SearchHistory]? {
        let fetchRequest = NSFetchRequest<Data_SearchHistory>(entityName: entityName)
        return try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest)
    }
    
    func deleteByUUID(uuid: String){
        guard let ds = Data_SearchHistoryOperate.shareInstance.getByUUID(uuid: uuid), ds.count > 0 else { return }
        for d in ds {
            Tianditu_Datas.shareInstance.managedObjectContext.delete(d as NSManagedObject)
        }
    }
    func deleteByName(name: String){
        guard let ds = Data_SearchHistoryOperate.shareInstance.getByName(name: name), ds.count > 0 else { return }
        for d in ds {
            Tianditu_Datas.shareInstance.managedObjectContext.delete(d as NSManagedObject)
        }
    }
}
extension Data_SearchHistory {
    var attribute: Object_Attribute {
        var a = [Any]()
        a.append(id)
        a.append(x)
        a.append(y)
        a.append(name ?? "")
        a.append(typeStr ?? "")
        a.append(region ?? "")
        a.append(county ?? "")
        a.append(phone ?? "")
        a.append(address ?? "")
        a.append(datafrom)
        a.append(imageAddress ?? "")
        return Object_Attribute(data: a, uuid: uuid)
    }
}
