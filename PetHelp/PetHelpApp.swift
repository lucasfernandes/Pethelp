//
//  PetHelpApp.swift
//  PetHelp
//
//  Created by Lucas Silveira on 21/08/20.
//

import SwiftUI
import Firebase

@main
struct PetHelpApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
