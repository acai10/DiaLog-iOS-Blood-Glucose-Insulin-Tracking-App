//
//  button.swift
//  DiaLog
//
//  Created by acai10 on 06.11.25.
//

import SwiftUI

// MARK: - Button
struct DailyResetButton: View {
    var user: User
    var realmService: RealmService
    private let buttonKey = "buttonPressedDate"
    @State private var isPressed = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: handleButtonPress) {
            Text(isPressed ? "Done for today ✅" : "Basal")
                .frame(maxWidth: AppTheme.textMaxWidth)
        }
        .buttonStyle(.borderedProminent)
        .tint(isPressed ? AppTheme.buttonDone : AppTheme.buttonTint(for: colorScheme))
        .padding()
        .onAppear(perform: checkIfResetNeeded)
    }

    // Logik
    private func handleButtonPress() {
        isPressed = true
        UserDefaults.standard.set(Date(), forKey: buttonKey)
        let latestFactor = user.persistedEntries.sorted(by: { $0.date > $1.date }).first?.factor ?? 1.0
        let latestBasal = user.persistedEntries.sorted(by: { $0.date > $1.date }).first?.basal ?? 0
        let latestSens = user.persistedEntries.sorted(by: { $0.date > $1.date }).first?.sens ?? 0
        
        realmService.savePersistedEntry(user: user, factor: latestFactor, basal: latestBasal, sens: latestSens)
    }

    private func checkIfResetNeeded() {
        if let lastPress = UserDefaults.standard.object(forKey: buttonKey) as? Date {
            if !Calendar.current.isDateInToday(lastPress) {
                isPressed = false
                UserDefaults.standard.removeObject(forKey: buttonKey)
            } else {
                isPressed = true
            }
        } else {
            isPressed = false
        }
    }
}
