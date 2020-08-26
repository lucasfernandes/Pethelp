//
//  SettingsView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 25/08/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userStore: UserStore
    @Environment(\.presentationMode) var presentationMode

    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    var body: some View {
        NavigationView {
//            VStack {
//                userStore.user?.picture.data.url.getImage().renderingMode(.original)
//                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
//                    .frame(width: 80, height: 80, alignment: .center)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color("lightBlue"), lineWidth: 2))
//            }

            List {
                HStack(spacing: 10) {
                    userStore.user?.picture.data.url.getImage().renderingMode(.original)
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .frame(width: 80, height: 80, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("lightBlue"), lineWidth: 2))

                    VStack(alignment: .leading) {
                        Text(userStore.user!.name)
                        Text(userStore.user!.email)
                            .font(.caption)
                    }
                }

                Section(header: Text("Informações")) {
                    Text("Version \(appVersion!)")
                }
                Section(header: Text("Ações")) {
                    Button(action: {
                        userStore.logout()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Sair")
                    })
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Perfil", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle")
                    .font(Font.system(.headline))
            })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
