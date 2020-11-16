//
//  AvatarView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 25/08/20.
//

import SwiftUI

struct AvatarView: View {
    @EnvironmentObject var userStore: UserStore
    @State var settingsIsPresented = false

    var body: some View {
        Button(action: {
            self.settingsIsPresented = true
        }, label: {
            userStore.user?.picture.data.url.getImage().renderingMode(.original)
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: 45, height: 45, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("lightBlue"), lineWidth: 2))
        })

        .sheet(isPresented: $settingsIsPresented) {
            SettingsView().environmentObject(userStore)
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}
