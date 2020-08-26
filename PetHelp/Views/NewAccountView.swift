//
//  NewAccountView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userStore: UserStore

    var body: some View {
        BaseView(isNavigationEnabled: true) {
            VStack(spacing: 20) {
                Spacer()
                Text("Is Logged: \($userStore.logged.wrappedValue.description)")
//                Image("Illustration")
                userStore.user?.picture.data.url.getImage()
                    .resizable(capInsets: /*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/, resizingMode: /*@START_MENU_TOKEN@*/.stretch/*@END_MENU_TOKEN@*/)
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            userStore.logout()
        }, label: {
            userStore.user?.picture.data.url.getImage().renderingMode(.original)
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: 40, height: 40, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
        }), trailing: Button(action: {
            userStore.logout()
        }, label: {
            Image(systemName: "plus")
        }))
    }
}

struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
