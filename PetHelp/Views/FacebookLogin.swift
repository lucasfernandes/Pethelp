//
//  FacebookLogin.swift
//  PetHelp
//
//  Created by Lucas Silveira on 24/08/20.
//

import SwiftUI
import FBSDKLoginKit
import Firebase
import FirebaseAuth

struct FacebookLogin: View {
    var body: some View {
        login()
            .frame(maxWidth: .infinity, maxHeight: 62)
            .padding(.all, 16)

    }
}

struct FacebookLogin_Previews: PreviewProvider {
    static var previews: some View {
        FacebookLogin()
    }
}

struct login: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return login.Coordinator()
    }

    func makeUIView(context: UIViewRepresentableContext<login>) -> FBLoginButton {
        let button = FBLoginButton(frame: .zero, permissions: [.publicProfile])
        button.delegate = context.coordinator
//        button.isHidden = true
//        button.permissions = ["email"]
        return button
    }

    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<login>) {
    }

    class Coordinator: NSObject, LoginButtonDelegate {
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if error != nil {
                print(error?.localizedDescription)
                return
            }

            if AccessToken.current != nil {
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)

                Auth.auth().signIn(with: credential) { (response, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }

                    print(response?.user.displayName)
                    print(response?.user.photoURL)
                }
            }
        }

        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }


    }
}
