//
//  textStyle.swift
//  DiaLog
//
//  Created by acai10 on 06.11.25.
//

import SwiftUI

struct CustomTextStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .font(AppTheme.fontHeadline)
            .frame(maxWidth: AppTheme.textMaxWidth)
            .padding()
            .background(AppTheme.primaryColor(for: colorScheme))
            .foregroundColor(AppTheme.textColorPrimary(for: colorScheme))
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(radius: AppTheme.shadowRadius)
    }
}
