//
//  Data_FavoriteIndexOperate.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import CoreData

class Data_FavoriteIndexOperate {
    internal static let shareInstance = Data_FavoriteIndexOperate()
    private init() {}
    private let entityName = "Data_FavoriteIndex"
}
extension Data_FavoriteIndexOperate {
    private func clear() -> Bool {
        let fetchRequest = NSFetchRequest<Data_FavoriteIndex>(entityName: entityName)
        guard let sr = try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest) else { return false }
        guard sr.count > 0 else { return true }
        for x in sr { Tianditu_Datas.shareInstance.managedObjectContext.delete(x as NSManagedObject) }
        do {
            try Tianditu_Datas.shareInstance.managedObjectContext.save()
            return true
        }
        catch { return false }
    }
    private func insert(id: Int64) -> Bool {
        let m = NSEntityDescription.insertNewObject(forEntityName: entityName, into: Tianditu_Datas.shareInstance.managedObjectContext) as? Data_FavoriteIndex
        guard let d = m else { return false }
        d.id = id
        do {
            try Tianditu_Datas.shareInstance.managedObjectContext.save()
            return true
        }
        catch { return false }
    }
    func get() -> Int64 {
        let fetchRequest = NSFetchRequest<Data_FavoriteIndex>(entityName: entityName)
        let data = try? Tianditu_Datas.shareInstance.managedObjectContext.fetch(fetchRequest)
        if let d = data, d.count == 1 {
            d[0].id = d[0].id + 1
            try? Tianditu_Datas.shareInstance.managedObjectContext.save()
            return d[0].id
        } else {
            guard clear() else { abort() }
            let id: Int64 = 0
            _ = insert(id: id)
            return id
        }
    }
}
