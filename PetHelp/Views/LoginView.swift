//
//  BeginView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI
import FBSDKLoginKit

struct LoginView: View {
    @State var linkIsActive = false
    @State var manager = LoginManager()
    @State var userIsLogged = false
    @EnvironmentObject var userStore: UserStore

    var body: some View {
        ZStack {
            NavigationView {
                BaseView {
                    VStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: 374.29, height: 49.4)

                        Image("Illustration")
                            .resizable()
                            .frame(height: 400)

                        Text("login_meaning")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                            .padding([.leading, .bottom, .trailing], 16)

                        Spacer().frame(height: 30)
                        ButtonSpaced(title: NSLocalizedString("login_button_title", comment: "")) {
                            $userIsLogged.wrappedValue == false
                                ? userStore.loginWithFacebook()
                                : userStore.getUser()
                        }.padding(.horizontal, 16)

                        if $userIsLogged.wrappedValue == true {
                            NavigationLink(destination: LocationsView(), isActive: $userStore.hasUserInfo) {}
                        }
                    }
                    .navigationBarHidden(true)
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                }
            }

            if $userStore.isLoading.wrappedValue {
                LoadingView()
            }
        }
        .onReceive(userStore.$logged, perform: { logged in
            self.userIsLogged = logged
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
