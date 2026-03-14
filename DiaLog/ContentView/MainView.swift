//
//  MainView.swift
//  DiaLog
//
//  Created by acai10 on 28.10.25.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    @AppStorage("message") var message: String = ""
    @AppStorage("currentUserId") var currentUserId: String?
    @State private var refreshID = UUID()
    @State private var userService = UserService()
    @State private var realmService = RealmService()
    @State private var loggedInUser: User? = nil
    
    @State private var bolusWithoutStr: String = ""
    @State private var levelStr: String = ""
    @State private var k100gStr: String = ""
    @State private var weightStr: String = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: AppTheme.backgroundGradient(for: colorScheme),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                ScrollView(.vertical) {
                    VStack(spacing: AppTheme.spacing) {
                        if let user = loggedInUser {
                            Text("Welcome, \(user.username)!")
                                .font(AppTheme.fontTitle)
                            
                            HStack {
                                CustomTextField(placeholder: "carbs per 100g", text: $k100gStr)
                                CustomTextField(placeholder: "weight in g", text: $weightStr)
                            }
                            
                            HStack {
                                CustomTextField(placeholder: "Bolus in EI", text: $bolusWithoutStr)
                                CustomTextField(placeholder: "Level in mg/dL", text: $levelStr)
                            }
                            
                            Button(action: {
                                if let latestEntry = user.entries
                                    .sorted(byKeyPath: "date", ascending: false)
                                    .first,
                                   let latestPersistedEntry = user.persistedEntries
                                    .sorted(byKeyPath: "date", ascending: false)
                                    .first {
                                    
                                    let bolusWithout = Int(bolusWithoutStr) ?? latestEntry.bolusWithout
                                    let level = Int(levelStr) ?? latestEntry.level
                                    let k100g = Double(k100gStr) ?? nil
                                    let weight = Double(weightStr) ?? nil
                                    
                                    realmService.saveNewEntry(persistedEntry: latestPersistedEntry,
                                                              user: user,
                                                              bolusWithout: bolusWithout,
                                                              level: level,
                                                              k100g: k100g,
                                                              weight: weight)
                                    
                                } else {
                                    // Fallback
                                    let bolusWithout = Int(bolusWithoutStr) ?? 0
                                    let level = Int(levelStr) ?? 0
                                    let latestPersistedEntry = PersistedEntry()
                                    
                                    realmService.saveNewEntry(persistedEntry: latestPersistedEntry, user: user, bolusWithout: bolusWithout, level: level)
                                }
                                
                                refreshID = UUID()
                            }) {
                                Text("Submit")
                                    .modifier(CustomTextStyle())
                            }
                            .padding(AppTheme.buttonPadding)
                            .disabled((bolusWithoutStr.isEmpty || (k100gStr.isEmpty && weightStr.isEmpty)) && levelStr.isEmpty)
                            .opacity((bolusWithoutStr.isEmpty || (k100gStr.isEmpty && weightStr.isEmpty)) && levelStr.isEmpty ? AppTheme.buttonDisabledOpacity : 1)
                            
                            LatestRow(user: user, realmService: realmService)
                            
                            HStack {
                                // navigation to user data
                                NavigationLink("Data") {
                                    UserDataView(user: user)
                                }
                                .buttonStyle(AppTheme.buttonStyle)
                                
                                // daily Basal
                                DailyResetButton(user: user, realmService: realmService)
                                
                                // navigation to change persitent data
                                NavigationLink("Change") {
                                    ChangePersistenceDataView(user: user)
                                }
                                .buttonStyle(AppTheme.buttonStyle)
                            }
                            
                            // logout-Button
                            Button(action: {
                                loggedInUser = nil
                                userService.logoutUser()
                            }) {
                                Text("Logout")
                                    .modifier(CustomTextStyle())
                            }
                            .padding(AppTheme.buttonPadding)
                            
                            
                            // delete-user-Button
                            Button(action: {
                                if let userId = user.id as String? {
                                    loggedInUser = nil
                                    userService.logoutUser()
                                    message = userService.deleteUser(userId: userId)
                                    UserDefaults.standard.set(message, forKey: "message")
                                }
                            }) {
                                Text("Delete User")
                                    .modifier(CustomTextStyle())
                            }
                            .padding(AppTheme.buttonPadding)
                            
                        } else {
                            Text("User not found")
                                .font(AppTheme.fontTitle)
                                .foregroundColor(AppTheme.textColorError)
                            
                            if !message.isEmpty {
                                Text(message)
                                    .foregroundColor(AppTheme.textColorInfo)
                                    .padding(.top)
                            }
                        }
                    }
                    .padding()
                }
            }
            .id(refreshID)
            .onAppear {
                // realmService.deleteAll()
                refreshID = UUID()
                if let userId = currentUserId {
                    if let foundUser = userService.findUserByUserId(userId: userId) {
                        loggedInUser = foundUser
                        message = ""
                    } else {
                        message = "User not found"
                        UserDefaults.standard.set(nil, forKey: "currentUserId")
                    }
                } else {
                    message = "No User logged in"
                    UserDefaults.standard.set(nil, forKey: "currentUserId")
                }
            }
        }
    }
}
