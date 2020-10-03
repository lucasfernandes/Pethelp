//
//  ButtonCircle.swift
//  PetHelp
//
//  Created by Lucas Silveira on 15/09/20.
//

import SwiftUI

struct ButtonCircle: View {
    var title = "Adicionar"
    var subtitle = "pet perdido"
    var iconName = "plus"
    var onTouch: (() -> Void) = {}

    var body: some View {
        VStack {
            Button(action: onTouch, label: {
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
//                    .foregroundColor(Color("lightBlue"))
                    .font(Font.title.bold())
            })
            .background(
                Circle()
                    .frame(width: 48, height: 48, alignment: .center)
                    .foregroundColor(Color("buttonCircleBackground"))
            )
            .padding(.top, 8)
            .padding(.bottom, 12)

            VStack(spacing: -2) {
                Text(title)
                    .font(Font.subheadline.weight(.light))
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
        }
    }
}

struct ButtonCircle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonCircle()
    }
}
