//
//  NewAccountView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userStore: UserStore

    var body: some View {
        BaseView(isNavigationEnabled: true) {
            Spacer()
            ButtonSpaced(title: "Continuar", action: {})
        }
        .navigationBarTitle("PetHelp", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: AvatarView(), trailing: Button(action: {
            userStore.logout()
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(Color("lightBlue"))
        }))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
