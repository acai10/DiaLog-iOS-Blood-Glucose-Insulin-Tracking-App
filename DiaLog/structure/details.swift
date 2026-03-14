//
//  Constants.swift
//  DiaLog
//
//  Created by acai10 on 28.10.25.
//

import SwiftUI
import RealmSwift

// MARK: - Entry Display
struct PersistedEntryRow: View {
    var user: User
    var realmService: RealmService
    @State private var refreshID = UUID()
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        ForEach(user.persistedEntries.sorted(by: { $0.date > $1.date }), id: \.id) { entry in
            VStack(alignment: .leading, spacing: AppTheme.vStackSpacingSmall) {
                Text("Date: \(entry.date.formatted(date: .numeric, time: .shortened))")
                Text("Factor: \(entry.factor, specifier: "%.2f")")
                Text("Basal: \(entry.basal) IE")
                Text("Sens: \(entry.sens) mg/dL /IE")
            }
            .padding(AppTheme.bodyPadding)
            .background(AppTheme.persistedBackground(for: colorScheme))
            .cornerRadius(AppTheme.cornerRadius)
            .onLongPressGesture {
                showDeleteAlert = true
            }
            .alert("Delete this entry?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    realmService.deletePersistedEntry(entry: entry)
                    refreshID = UUID()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        .id(refreshID)
    }
}

struct EntryRow: View {
    var user: User
    var realmService: RealmService
    @State private var refreshID = UUID()
    @Environment(\.colorScheme) var colorScheme

    @State private var showDeleteAlert = false

    var body: some View {
        ForEach(user.entries.sorted(by: { $0.date > $1.date }), id: \.id) { entry in
            VStack(alignment: .leading, spacing: AppTheme.vStackSpacingSmall) {
                Text("Date: \(entry.date.formatted(date: .numeric, time: .shortened))")
                Text("Weight: \(entry.weight != nil ? String(format: "%.1f", entry.weight!) : "–")")
                Text("K / 100g: \(entry.k100g != nil ? "\(entry.k100g!)g" : "–")")
                Text("KE Total: \(entry.keTotal) KE")
                Text("Bolus (without): \(entry.bolusWithout) IE")
                Text("Bolus (with): \(entry.bolusWith) IE")
                Text("Addition: \(entry.addition) IE")
                Text("Bolus (with addition): \(entry.bolusWithAddition) IE")
                Text("Level: \(entry.level) mg/dL")
            }
            .padding(AppTheme.bodyPadding)
            .background(AppTheme.entryBackground(for: colorScheme))
            .cornerRadius(AppTheme.cornerRadius)
            .onLongPressGesture {
                showDeleteAlert = true
            }
            .alert("Delete this entry?", isPresented: $showDeleteAlert) {
                Button("delete", role: .destructive) {
                    realmService.deleteEntry(entry: entry)
                    refreshID = UUID()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        .id(refreshID)
    }
}

struct LatestRow: View {
    var user: User
    var realmService: RealmService
    @State private var refreshID = UUID()
    @Environment(\.colorScheme) var colorScheme

    @State private var showDeleteAlert = false

    var body: some View {
        if let entry = user.entries.sorted(by: { $0.date > $1.date }).first {
            VStack(alignment: .leading, spacing: AppTheme.vStackSpacingSmall) {
                Text("Date: \(entry.date.formatted(date: .numeric, time: .shortened))")
                Text("Weight: \(entry.weight != nil ? String(format: "%.1f", entry.weight!) : "–")")
                Text("K / 100g: \(entry.k100g != nil ? "\(entry.k100g!)g" : "–")")
                Text("KE Total: \(entry.keTotal) KE")
                Text("Bolus (without): \(entry.bolusWithout) IE")
                Text("Bolus (with): \(entry.bolusWith) IE")
                Text("Addition: \(entry.addition) IE")
                Text("Bolus (with addition): \(entry.bolusWithAddition) IE")
                Text("Level: \(entry.level) mg/dL")
            }
            .padding(AppTheme.bodyPadding)
            .background(AppTheme.entryBackground(for: colorScheme))
            .cornerRadius(AppTheme.cornerRadius)
            .onLongPressGesture {
                showDeleteAlert = true
            }
            .alert("Delete this entry?", isPresented: $showDeleteAlert) {
                Button("delete", role: .destructive) {
                    realmService.deleteEntry(entry: entry)
                    refreshID = UUID()
                }
                Button("Cancel", role: .cancel) {}
            }
            .id(refreshID)
        }
    }
}
