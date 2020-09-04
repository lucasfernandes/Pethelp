//
//  RoundedTextField.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI

struct RoundedTextField: View {
    var title = ""
    var placehoder = "Type something"
    let foreground = "textFieldColor"
    @Binding var text: String

    var onEditingChanged: (() -> Void)? = {}

    var body: some View {
        VStack(alignment: .leading) {
            if !title.isEmpty {
                Text(title)
                .foregroundColor(Color(foreground))
                .font(.system(size: 12))
            }
            TextField(placehoder, text: $text, onEditingChanged: { _ in
                onEditingChanged!()
            })
//                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(Font.system(size: 16, weight: .medium))
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary)
                        .foregroundColor(Color("textFieldBackground")))
        }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextField(text: .constant(""))
    }
}
