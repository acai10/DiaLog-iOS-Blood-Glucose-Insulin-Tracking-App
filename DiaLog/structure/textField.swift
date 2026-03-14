//
//  textFields.swift
//  DiaLog
//
//  Created by acai10 on 06.11.25.
//

import SwiftUI

// MARK: - Custom Styled TextFields
struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(AppTheme.fieldBackground(for: colorScheme))
            .cornerRadius(AppTheme.fieldCornerRadius)
            .shadow(color: AppTheme.shadowColor(for: colorScheme), radius: AppTheme.shadowRadius, x: AppTheme.shadowX, y: AppTheme.shadowY)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

struct CustomSecureField: View {
    let placeholder: String
    @Binding var text: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .background(AppTheme.fieldBackground(for: colorScheme))
            .cornerRadius(AppTheme.fieldCornerRadius)
            .shadow(color: AppTheme.shadowColor(for: colorScheme), radius: AppTheme.shadowRadius, x: AppTheme.shadowX, y: AppTheme.shadowY)
    }
}
