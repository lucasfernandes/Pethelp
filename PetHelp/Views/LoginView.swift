//
//  BeginView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI

struct LoginView: View {
    @State var linkIsActive = false
    @EnvironmentObject var userStore: UserStore

    var body: some View {
        NavigationView {
            BaseView {
                VStack {
                    Image("Logo")
                        .resizable()

                    Image("Illustration")
                        .resizable()
                        .frame(height: 400)

                    Text("O PetHelp foi desenvolvido para ajudar animais de rua que precisam de todos nós para sobreviverem de alguma forma.")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .padding([.leading, .bottom, .trailing], 16)

                    Spacer().frame(height: 30)
                    ButtonSpaced(title: $userStore.logged.wrappedValue ? "Entrar" : "Login com Facebook") {
                        if !$userStore.logged.wrappedValue {
                            userStore.loginWithFacebook()
                        }
                    }
                    NavigationLink(destination: HomeView(), isActive: $userStore.logged) {}
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
