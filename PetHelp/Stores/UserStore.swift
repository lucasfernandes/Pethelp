//
//  UserStore.swift
//  PetHelp
//
//  Created by Lucas Silveira on 24/08/20.
//

import Foundation
import Combine
import FBSDKLoginKit
import FBSDKCoreKit

class UserStore: ObservableObject {
    @Published var user: User? = nil
    @Published var manager = LoginManager()
    @Published var logged: Bool = false
    @Published var failure: Error? = nil

    func loginWithFacebook() {

        if AccessToken.isCurrentAccessTokenActive {
            self.getUser()
            return
        }

        self.manager.logIn(permissions: ["public_profile", "email"], from: nil) { (result, error) in
            if error != nil {
                self.failure = error!
                self.logout()
                return
            } else if result!.isCancelled {
                self.logout()
            } else {
                self.getUser()
            }
        }
    }

    func getUser() {
        let request = GraphRequest(
            graphPath: "me",
            parameters: ["fields": "id, email, name, picture.type(large)"],
            tokenString: AccessToken.current?.tokenString,
            version: Settings.defaultGraphAPIVersion,
            httpMethod: HTTPMethod.get)

        request.start { (data, response, error) in
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: response!, options: [])
                self.user = try JSONDecoder().decode(User.self, from: jsonData)
                self.logged = true

            } catch {
                self.logout()
                self.user = nil
                self.failure = error

            }
        }
    }

    func logout() {
        self.manager.logOut()
        self.logged = false
    }
}
