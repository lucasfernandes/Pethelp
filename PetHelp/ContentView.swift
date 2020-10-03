//
//  ContentView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 21/08/20.
//

import SwiftUI
import FBSDKCoreKit
import MapKit

struct ContentView: View {
    var userStore = UserStore()

    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    var body: some View {
//        NewPetView()
        LoginView()
            .onOpenURL(perform: { urlToOpen in
                ApplicationDelegate.shared.application(
                    UIApplication.shared,
                    open: urlToOpen,
                    sourceApplication: nil,
                    annotation: UIApplication.OpenURLOptionsKey.annotation)
            })
            .environmentObject(userStore)

//        LocationsView()
//            .environmentObject(userStore)
//        ImagesView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
