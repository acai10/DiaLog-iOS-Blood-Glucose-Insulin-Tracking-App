//
//  ChangePersistenceDataView.swift
//  DiaLog
//
//  Created by acai10 on 28.10.25.
//

import SwiftUI
import RealmSwift

struct ChangePersistenceDataView: View {
    var user: User
    @State private var refreshID = UUID()
    @State private var factorStr: String = ""
    @State private var basalStr: String = ""
    @State private var sensStr: String = ""
    @State private var realmService = RealmService()
    @State private var persistedEntries: [PersistedEntry] = []
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: AppTheme.backgroundGradient(for: colorScheme),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(spacing: AppTheme.spacing) {
                    Text("\(user.username)")
                        .font(AppTheme.fontTitle)
                    
                    HStack {
                        CustomTextField(placeholder: "factor", text: $factorStr)
                        CustomTextField(placeholder: "basal in IE", text: $basalStr)
                        CustomTextField(placeholder: "sens in mg/dL / EI", text: $sensStr)
                    }
                    .padding()
                    
                    Button(action: {
                        if let latestPersistedEntry = user.persistedEntries
                            .sorted(byKeyPath: "date", ascending: false)
                            .first {
                            
                            let factor = Double(factorStr) ?? latestPersistedEntry.factor
                            let basal = Int(basalStr) ?? latestPersistedEntry.basal
                            let sens = Int(sensStr) ?? latestPersistedEntry.sens
                            
                            realmService.savePersistedEntry(user: user, factor: factor, basal: basal, sens: sens)
                            
                        } else {
                            // Fallback
                            let factor = Double(factorStr) ?? 1.0
                            let basal = Int(basalStr) ?? 0
                            let sens = Int(sensStr) ?? 40
                            
                            realmService.savePersistedEntry(user: user, factor: factor, basal: basal, sens: sens)
                        }
                        
                        refreshID = UUID()
                    }) {
                        Text("Submit")
                            .modifier(CustomTextStyle())
                    }
                    .padding(AppTheme.buttonPadding)
                    .disabled(factorStr.isEmpty && basalStr.isEmpty && sensStr.isEmpty)
                    .opacity(factorStr.isEmpty && basalStr.isEmpty && sensStr.isEmpty ? AppTheme.buttonDisabledOpacity : 1)
                    
                    ScrollView(.vertical) {
                        PersistedEntryRow(user: user, realmService: realmService)
                    }
                    .onAppear() {
                        persistedEntries = user.persistedEntries.sorted(by: { $0.date > $1.date })
                    }
                }
            }
            .id(refreshID)
            .onAppear() {
                refreshID = UUID()
            }
        }
    }
}
