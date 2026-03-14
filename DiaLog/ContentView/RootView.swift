//
//  ContentView.swift
//  DiaLog
//
//  Created by acai10 on 27.10.25.
//

import SwiftUI

struct RootView: View {
    @AppStorage("currentUserId") var currentUserId: String?
    
    var body: some View {
        if currentUserId != nil {
            MainView() // logged in - content view
        } else {
            LoginView() // login screen
        }
    }
}
