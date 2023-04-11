//
//  DataManager.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/07.
//  Copyright © 2023 SloWax. All rights reserved.
//


import RealmSwift


protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object

    init(managedObject: ManagedObject)

    func managedObject() -> ManagedObject
}


class DataManager {
    static let shared = DataManager()
    
    let realm = try! Realm()
    
    func create(_ data: TimeCardModel.Attendance) {
        let attendance = data.managedObject()
        
        try! realm.write {
            realm.add(attendance)
        }
    }
    
    func retrieve() -> [TimeCardModel.Attendance] {
        let objects = realm.objects(RealmItemModel.self)
        var timeCard = [TimeCardModel.Attendance]()
        
        objects.forEach { item in
            let convertItem = TimeCardModel.Attendance(managedObject: item)
            timeCard.append(convertItem)
        }
        
        return timeCard
    }
    
    func delete(_ data: TimeCardModel.Attendance) {
        let objects = realm.objects(RealmItemModel.self)
        let toDelete = data.managedObject()
        
        if let deleteIndex = objects.firstIndex(where: { $0.id == toDelete.id }) {
            try! realm.write {
                realm.delete(objects[deleteIndex])
            }
        }
    }
}


class RealmItemModel: Object {
    @objc dynamic var id = Date()
    @objc dynamic var date = Date()
    @objc dynamic var wage = 0
    @objc dynamic var workTime = 0
    @objc dynamic var overTime = 0
    @objc dynamic var nightTime = 0
    @objc dynamic var overNightTime = 0
    @objc dynamic var total = 0
    @objc dynamic var dayPay = 0
}


extension TimeCardModel.Attendance: Persistable {

    init(managedObject: RealmItemModel) {
        self.id = managedObject.id
        self.date = managedObject.date
        self.wage = managedObject.wage
        self.workTime = managedObject.workTime.splitTime
        self.overTime = managedObject.overTime.splitTime
        self.nightTime = managedObject.nightTime.splitTime
        self.overNightTime = managedObject.overNightTime.splitTime
        self.total = managedObject.total.splitTime
        self.dayPay = managedObject.dayPay
    }

    func managedObject() -> RealmItemModel {
        let module = RealmItemModel()
        
        module.id = self.id
        module.date = self.date
        module.wage = self.wage
        module.workTime = self.combineTime(.work)
        module.overTime = self.combineTime(.over)
        module.nightTime = self.combineTime(.night)
        module.overNightTime = self.combineTime(.overNight)
        module.total = self.combineTime(.total)
        module.dayPay = self.dayPay
        
        return module
    }
}
