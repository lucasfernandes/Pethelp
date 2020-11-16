//
//  RoundedTextEditor.swift
//  PetHelp
//
//  Created by Lucas Silveira on 17/09/20.
//

import SwiftUI

struct RoundedTextEditor: View {
    var title = ""
    var placehoder = "Type something"
    let foreground = "textFieldColor"
    let numberOfLInes = 1
    @Binding var text: String

    var onEditingChanged: (() -> Void)? = {}
    
    var body: some View {
        VStack(alignment: .leading) {
            if !title.isEmpty {
                Text(title)
                    .foregroundColor(Color(foreground))
                    .font(.system(size: 12))
            }
            TextEditor(text: $text)
                .frame(height: 120, alignment: .topLeading)
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

struct RoundedTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextEditor(text: .constant(""))
    }
}
