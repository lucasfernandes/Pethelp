//
//  UserStore.swift
//  PetHelp
//
//  Created by Lucas Silveira on 24/08/20.
//

import Foundation
import Combine
import FBSDKLoginKit

class UserStore: ObservableObject {
    @Published var user: User? = nil
    @Published var manager = LoginManager()
    @Published var logged: Bool = false
    @Published var failure: Error? = nil

    func loginWithFacebook() {
        self.manager.logIn(permissions: ["public_profile", "email"], from: nil) { (result, error) in
            if error != nil {
                self.failure = error!
                return
            }

            if !result!.isCancelled {
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
                        self.logged = false
                        self.user = nil
                        self.failure = error
                    }
                }
            }
        }
    }

    func logout() {
        self.manager.logOut()
        self.logged = false
    }
}
