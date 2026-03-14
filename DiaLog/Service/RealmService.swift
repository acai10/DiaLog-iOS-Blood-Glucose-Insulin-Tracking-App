//
//  RealmService.swift
//  DiaLog
//
//  Created by acai10 on 27.10.25.
//

import RealmSwift

class RealmService {
    
    // save a new entry
    func saveNewEntry(
        persistedEntry: PersistedEntry,
        user: User,
        bolusWithout: Int,
        level: Int,
        k100g: Double? = nil,
        weight: Double? = nil
    ) {
        let realm = try! Realm()
        let data = NewEntry()
        
        data.user = user
        data.weight = weight
        data.k100g = k100g
        
        if let ke = k100g, let w = weight {
            data.keTotal = Int(((ke * w) / 1000).rounded())
            data.bolusWithout = data.keTotal + bolusWithout
        } else {
            data.keTotal = bolusWithout
            data.bolusWithout = bolusWithout
        }
        
        data.bolusWith = Int((Double(data.bolusWithout) * persistedEntry.factor).rounded())
        data.level = level
        
        // Correction factor
        let targetLevel = 120
        let correction = level - targetLevel
        
        if persistedEntry.sens != 0 {
            let additionalBolus = Double(correction) / Double(persistedEntry.sens)
            data.addition = Int(additionalBolus.rounded())
        } else {
            data.addition = 0
        }
        
        data.bolusWithAddition = data.bolusWith + data.addition
        
        try! realm.write {
            realm.add(data)
            user.entries.append(data)
        }
    }
    
    // save new calculation elements - stay the same over a timespan
    func savePersistedEntry(user: User, factor: Double, basal: Int, sens: Int) {
        let realm = try! Realm()
        
        let data = PersistedEntry()
        data.user = user
        data.factor = factor
        data.basal = basal
        data.sens = sens
        
        try! realm.write {
            realm.add(data)
            
            user.persistedEntries.append(data)
        }
    }
    
    // delete certain entry
    func deleteEntry(entry: NewEntry) -> Void {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(entry)
        }
    }
    
    // delete certain persisted entry
    func deletePersistedEntry(entry: PersistedEntry) -> Void {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(entry)
        }
    }
    
    // read data of specific user
    func readAllDataOfUser(userId: String) -> ([NewEntry], [PersistedEntry]) {
        let realm = try! Realm()
        
        // NewEntries sorted by date
        let allNewEntries = Array(
            realm.objects(NewEntry.self)
                 .filter("id == %@", userId)
                 .sorted(byKeyPath: "date", ascending: false)
        )
        
        // PersistedEntries sorted by date
        let allPersistedEntries = Array(
            realm.objects(PersistedEntry.self)
                 .filter("id == %@", userId)
                 .sorted(byKeyPath: "date", ascending: false)
        )
        
        return (allNewEntries, allPersistedEntries)
    }
    
    // delete all in realm (mainly for testing)
    func deleteAll() -> Void {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
        try! realm.write {
            realm.deleteAll()
        }
    }
}


