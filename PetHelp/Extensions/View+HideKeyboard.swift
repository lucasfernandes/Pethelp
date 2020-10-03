//
//  View+HideKeyboard.swift
//  PetHelp
//
//  Created by Lucas Silveira on 24/09/20.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    public func dismissKeyboardOnTapAnywhere() -> some View {
        modifier(DismissKeyboard())
    }
}
#endif
