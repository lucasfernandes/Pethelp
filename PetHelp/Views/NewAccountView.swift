//
//  NewAccountView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI

struct NewAccountView: View {
    var body: some View {
        BaseView(isNavigationEnabled: true) {
            VStack(spacing: 20) {
                Spacer()
                Image("Illustration")
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))

                VStack(spacing: 20) {
                    RoundedTextField(title: "Nome", placehoder: "Digite seu nome")
                    RoundedTextField(title: "E-mail", placehoder: "Digite seu email")
                    RoundedTextField(title: "CPF", placehoder: "Digite seu CPF")
                }

                Spacer()

                ButtonSpaced(title: "Continuar", action: {
                })
            }
            .navigationTitle("Nova conta")
            .keyboardAdaptive()
        }
    }
}

struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView()
    }
}
