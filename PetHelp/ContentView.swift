//
//  ContentView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 21/08/20.
//

import SwiftUI
import FBSDKCoreKit

struct ContentView: View {
    var userStore = UserStore()
    var body: some View {
        BeginView()
            .onOpenURL(perform: { url in
                ApplicationDelegate.shared.application(
                    UIApplication.shared,
                    open: url,
                    sourceApplication: nil,
                    annotation: UIApplication.OpenURLOptionsKey.annotation)
            })
            .environmentObject(userStore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
