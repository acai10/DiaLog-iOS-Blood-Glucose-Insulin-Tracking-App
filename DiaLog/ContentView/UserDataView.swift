//
//  UserDataView.swift
//  DiaLog
//
//  Created by acai10 on 28.10.25.
//

import SwiftUI
import RealmSwift

struct UserDataView: View {
    var user: User
    @State private var realmService = RealmService()
    @State private var refreshID = UUID()
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
                HStack(alignment: .top, spacing: AppTheme.spacing) {
                    
                    // left column
                    VStack(alignment: .leading, spacing: AppTheme.vStackSpacingBig) {
                        Text("Entries")
                            .font(AppTheme.fontHeadline)
                        
                        EntryRow(user: user, realmService: realmService)
                    }
                    .frame(maxWidth: AppTheme.textMaxWidth)
                    
                    // right column
                    VStack(alignment: .leading, spacing: AppTheme.vStackSpacingBig) {
                        Text("Persisted Entries")
                            .font(AppTheme.fontHeadline)
                        
                        PersistedEntryRow(user: user, realmService: realmService)
                    }
                    .frame(maxWidth: AppTheme.textMaxWidth)
                }
                .padding()
            }
            .id(refreshID)
            .onAppear() {
                refreshID = UUID()
            }
        }
    }
}
