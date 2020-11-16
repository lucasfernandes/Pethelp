//
//  DismissKeyboardModifier.swift
//  PetHelp
//
//  Created by Lucas Silveira on 24/09/20.
//

import SwiftUI

public struct DismissKeyboard: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .onTapGesture {
                content.hideKeyboard()
            }
    }
}
