//
//  LoginView.swift
//  DiaLog
//
//  Created by acai10 on 28.10.25.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var message = ""
    @State private var userService = UserService()
    @State private var realmService = RealmService()
    @AppStorage("currentUserId") var currentUserId: String?
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
                
                VStack(spacing: AppTheme.spacing) {
                    
                    // input fields
                    CustomTextField(placeholder: "Username", text: $username)
                    
                    CustomSecureField(placeholder: "Password", text: $password)
                    
                    HStack(spacing: AppTheme.spacing) {
                        
                        // Login-Button
                        Button(action: {
                            let result = userService.loginUser(username: username, password: password)
                            switch result {
                            case .success(let user):
                                message = ""
                                currentUserId = user.id
                            case .failure(let error):
                                message = error.message
                            }
                        }) {
                            Text("Login")
                                .modifier(CustomTextStyle())
                        }
                        .padding(AppTheme.buttonPadding)
                        .disabled(username.isEmpty || password.isEmpty)
                        .opacity(username.isEmpty || password.isEmpty ? AppTheme.buttonDisabledOpacity : 1)

                        // SignUp-Button
                        Button(action: {
                            if userService.findUserByUsername(username: username) == nil {
                                userService.saveNewUser(username: username, password: password)
                                let result = userService.loginUser(username: username, password: password)
                                switch result {
                                case .success(let user):
                                    message = ""
                                    currentUserId = user.id
                                case .failure(let error):
                                    message = error.message
                                }
                            } else {
                                message = "Username already taken"
                            }
                        }) {
                            Text("SignUp")
                                .modifier(CustomTextStyle())
                        }
                        .padding(AppTheme.buttonPadding)
                        .disabled(username.isEmpty || password.isEmpty)
                        .opacity(username.isEmpty || password.isEmpty ? AppTheme.buttonDisabledOpacity : 1)
                    }
                    
                    if !message.isEmpty {
                        Text(message)
                            .font(AppTheme.fontHeadline)
                            .padding()
                            .foregroundColor(AppTheme.textColorError)
                    }
                }
                .padding()
            }
            .onAppear() {
                if let storedMessage = UserDefaults.standard.string(forKey: "message"),
                   !storedMessage.isEmpty {
                    message = storedMessage
                    UserDefaults.standard.set(nil, forKey: "message")
                }
            }
        }
    }
}
