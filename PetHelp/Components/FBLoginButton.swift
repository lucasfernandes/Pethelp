//
//  FBLoginButton.swift
//  PetHelp
//
//  Created by Lucas Silveira on 24/08/20.
//

import SwiftUI
import FBSDKLoginKit

struct FBLoginButton: View {
    @AppStorage("logged") var logged = false
    @AppStorage("email") var email = ""
    @State var manager = LoginManager()
    var action: (() -> Void)?

    var body: some View {
        ButtonSpaced(title: logged ? "Sair" : "Login com Facebook") {
            if logged {
                manager.logOut()
                email = ""
                logged = false
            } else {
                manager.logIn(permissions: ["public_profile", "email"], from: nil) { (result, error) in
                    if error != nil {
                        print(error?.localizedDescription ?? "error found on login")
                        return
                    }

                    // success
                    if !result!.isCancelled {
                        logged = true
                        let request = GraphRequest(graphPath: "me", parameters: ["fields": "email"])
                        request.start { (_, response, _) in
                            guard let profileData = response as? [String: Any] else { return }
                            email = profileData["email"] as! String
                            self.action!()
                        }
                    }
                }
            }
        }
    }
}

struct FBLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        FBLoginButton()
    }
}
