//
//  constants.swift
//  DiaLog
//
//  Created by acai10 on 06.11.25.
//

import SwiftUI

import SwiftUI

struct AppTheme {
    // MARK: - Layout
    static let spacing: CGFloat = 20
    static let cornerRadius: CGFloat = 8
    static let fieldCornerRadius: CGFloat = 12
    static let shadowRadius: CGFloat = 4
    static let vStackSpacingSmall: CGFloat = 4
    static let vStackSpacingBig: CGFloat = 10
    static let bodyPadding: CGFloat = 8
    
    // MARK: - Dynamic Colors
    static func primaryColor(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .blue.opacity(0.8) : .blue
    }
    
    static func secondaryColor(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .green.opacity(0.8) : .green
    }
    
    static func accentColor(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .teal.opacity(0.8) : .teal
    }
    
    static func border(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .white.opacity(0.5) : .black
    }
    
    static func backgroundGradient(for scheme: ColorScheme) -> Gradient {
        if scheme == .dark {
            return Gradient(colors: [
                .black.opacity(0.8),
                .blue.opacity(0.4)
            ])
        } else {
            return Gradient(colors: [
                .mint.opacity(0.9),
                .blue.opacity(0.4)
            ])
        }
    }
    
    static func fieldBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.black.opacity(0.6) : Color.white.opacity(0.9)
    }
    
    static func entryBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.blue.opacity(0.2) : Color.blue.opacity(0.1)
    }
    
    static func persistedBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.green.opacity(0.2) : Color.green.opacity(0.1)
    }
    
    // MARK: - Text
    static func textColorPrimary(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .white : .black
    }
    
    static let textColorError = Color.red
    static let textColorInfo = Color.gray
    static let fontHeadline = Font.headline
    static let fontTitle = Font.title
    static let textMaxWidth: CGFloat = .infinity
    
    // MARK: - Buttons
    static func buttonTint(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .blue.opacity(0.8) : .blue
    }
    
    static let buttonDone = Color.gray
    static let buttonDisabledOpacity: Double = 0.5
    static let buttonStyle: BorderedProminentButtonStyle = .borderedProminent
    static let buttonPadding: Edge.Set = .horizontal
    
    // MARK: - Shadows
    static func shadowColor(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1)
    }
    static let shadowX: CGFloat = 0
    static let shadowY: CGFloat = 2
}
