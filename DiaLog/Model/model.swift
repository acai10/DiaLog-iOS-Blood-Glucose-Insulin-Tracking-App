//
//  Entry.swift
//  DiaLog
//
//  Created by acai10 on 27.10.25.
//

import RealmSwift
import Foundation

class NewEntry: Object {
    @Persisted var date: Date = Date()
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var user: User?
    @Persisted var weight: Double?
    @Persisted var k100g: Double?
    @Persisted var keTotal: Int = 0
    @Persisted var bolusWithout: Int = 0
    @Persisted var bolusWith: Int = 0
    @Persisted var level: Int = 0
    @Persisted var addition: Int = 0
    @Persisted var bolusWithAddition: Int = 0
}

class PersistedEntry: Object {
    @Persisted var date: Date = Date()
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var user: User?
    @Persisted var factor: Double = 1.0
    @Persisted var basal: Int = 0
    @Persisted var sens: Int = 40
}

class User: Object {
    @Persisted var date: Date = Date()
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var username: String = ""
    @Persisted var password: String = ""
    @Persisted var entries: List<NewEntry> = List()
    @Persisted var persistedEntries: List<PersistedEntry> = List()
}

/*
class Evaluation: Object {
    // evaluate the data
}
*/
