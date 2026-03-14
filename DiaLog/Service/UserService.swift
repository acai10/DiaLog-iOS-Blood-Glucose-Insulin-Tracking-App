//
//  UserService.swift
//  DiaLog
//
//  Created by acai10 on 27.10.25.
//

enum LoginError: Error {
    case userNotFound
    case wrongPassword

    var message: String {
        switch self {
        case .userNotFound:
            return "User not found"
        case .wrongPassword:
            return "Password is wrong"
        }
    }
}

import RealmSwift
import Foundation

class UserService {
    
    // save new user
    func saveNewUser(username: String, password: String) -> Void {
        let realm = try! Realm()
        
        // if user with same credentials exist return
        if realm.objects(User.self)
            .filter("username == %@ AND password == %@", username, password)
            .first != nil { return }
        
        let data = User()
        data.username = username
        data.password = password
        
        try! realm.write {
            realm.add(data)
        }
    }
    
    // login user
    func loginUser(username: String, password: String) -> Result<User, LoginError> {
        let realm = try! Realm()

        if let user = realm.objects(User.self).filter("username == %@", username).first {
            if user.password == password {
                UserDefaults.standard.set(user.id, forKey: "currentUserId")
                return .success(user)
            } else {
                return .failure(.wrongPassword)
            }
        } else {
            return .failure(.userNotFound)
        }
    }
    
    // find user by username & password
    func findUserByUsername(username: String) -> User? {
        let realm = try! Realm()
        
        if let user = realm.objects(User.self)
            .filter("username == %@", username)
            .first {
            return user
        } else {
            return nil
        }
    }
    
    // find user by userId
    func findUserByUserId(userId: String) -> User? {
        let realm = try! Realm()
        
        if let user = realm.object(ofType: User.self, forPrimaryKey: userId) {
            return user
        } else {
            return nil
        }
    }
    
    // logout
    func logoutUser() -> Void {
        if UserDefaults.standard.object(forKey: "currentUserId") != nil {
            UserDefaults.standard.removeObject(forKey: "currentUserId")
        }
    }
    
    // delete user
    func deleteUser(userId: String) -> String {
        var username: String = ""
        let realm = try! Realm()
            
        if let user = realm.object(ofType: User.self, forPrimaryKey: userId) {
            username = user.username
            try! realm.write {
                realm.delete(user.entries)
                realm.delete(user.persistedEntries)
                
                realm.delete(user)
            }
            return "User " + username + " deleted!"
        } else {
            return "User " + username + " not found!"
        }
    }
}
