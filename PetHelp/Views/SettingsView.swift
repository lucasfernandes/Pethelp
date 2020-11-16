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
        VStack(alignment: .leading) {
            SheetHeaderView(
                title: NSLocalizedString("profile_title", comment: ""),
                onTouch: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                .padding(.all, 16)

            List {
                HStack(spacing: 10) {
                    userStore.user?.picture.data.url.getImage().renderingMode(.original)
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .frame(width: 80, height: 80, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("lightBlue"), lineWidth: 2))

                    VStack(alignment: .leading) {
                        Text(userStore.user?.name ?? "")
                        Text(userStore.user?.email ?? "")
                            .font(.caption)
                    }
                }

                Section(header: Text("profile_informations")) {
                    Text("\(NSLocalizedString("profile_version", comment: "")) \(appVersion!)")
                }
                Section(header: Text("profile_actions")) {
                    Button(action: {
                        userStore.logout()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("profile_logout")
                    })
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
