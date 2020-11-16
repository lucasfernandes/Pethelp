//
//  ButtonSpaced.swift
//  PetHelp
//
//  Created by Lucas Silveira on 21/08/20.
//

import SwiftUI

public enum ButtonType: String {
    case primary = "buttonPrimary"
    case secondary = "buttonSecondary"
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
    }
}

struct ButtonSpaced: View {
    var title: String = "Tap me"
    var buttonType: ButtonType = .primary
    var action: (() -> Void)?
    @State private var buttonBackground = ButtonType.primary.rawValue

    var body: some View {
        HStack {
            Button(action: action ?? {}) {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 50)
                    .foregroundColor(Color("buttonPrimaryForeground"))
                    .font(.system(size: 16, weight: .semibold))
                    .overlay(
                        RoundedRectangle(cornerRadius: 26.5)
                            .stroke(Color("buttonSpacedPrimary"), lineWidth: 2)
                            .shadow(color: Color("buttonSpacedSecondary"), radius: 3, x: 2, y: 2)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 26.5)
                            )
                            .shadow(color: Color("buttonSpacedPrimary"), radius: 2, x: -2, y: -2)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 26.5)
                            )
                    )
                    .background(Color($buttonBackground.wrappedValue))
                    .cornerRadius(26.5)
                    .shadow(color: Color($buttonBackground.wrappedValue), radius: 5, x: 0, y: 5)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 26.5)
                    )
                    .shadow(color: Color($buttonBackground.wrappedValue), radius: 2, x: 0, y: 5)
            }
            .buttonStyle(ScaleButtonStyle())
            .onAppear {
                buttonBackground = buttonType == .primary
                    ? ButtonType.primary.rawValue
                    : ButtonType.secondary.rawValue
            }
        }
    }
}

struct ButtonSpaced_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSpaced()
    }
}
