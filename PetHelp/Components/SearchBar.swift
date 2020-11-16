//
//  SearchBar.swift
//  PetHelp
//
//  Created by Lucas Silveira on 06/09/20.
//

import SwiftUI

struct SearchBar: View {
    var placeholder: String
    var onEditingChanged: (() -> Void) = {}
    var onFocus: (() -> Void) = {}
    var onBlur: (() -> Void) = {}
    var onCleanText: (() -> Void) = {}
    @Binding var text: String

    func performChanges(isEditing: Bool) {
        isEditing ? onFocus() : onBlur()
    }

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.secondary)
            TextField(placeholder, text: $text, onEditingChanged: performChanges(isEditing:))
                .onChange(of: text) {
                    print($0)
                    onEditingChanged()
                }

            if text != "" {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium)
                    .foregroundColor(Color("searchBarButtonClear"))
                    .padding(3)
                    .onTapGesture {
                        withAnimation {
                            self.text = ""
                            self.onCleanText()
                        }
                    }
            }
        }
        .padding(10)
        .background(Color("searchBarBackground"))
        .cornerRadius(12)
        .padding(.vertical, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(placeholder: "", text: .constant(""))
    }
}
