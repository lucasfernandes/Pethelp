//
//  RoundedTextField.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI

struct RoundedTextField: View {
    var title = "Title"
    var placehoder = "Type something"
    let foreground = "textFieldColor"
    @State private var text = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(foreground))
                .font(.system(size: 12))
            TextField(placehoder, text: $text)
                .font(Font.system(size: 16, weight: .medium))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white))
        }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextField()
    }
}
