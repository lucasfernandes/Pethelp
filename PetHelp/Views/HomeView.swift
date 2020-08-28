//
//  NewAccountView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userStore: UserStore
    let list = [1, 2, 3]
    let emptyList: [Int] = []

    var body: some View {
        BaseView(isNavigationEnabled: true) {
            VStack {
                LazyVStack {
                    ForEach((emptyList).reversed(), id: \.self) { number in
                        PetListItemView(onTouchUpInside: { print(number) })
                            .padding(.vertical, 4)
                    }
                }

                if emptyList.isEmpty {
                    VStack {
                        Text("Nenhum item na lista")
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                }
            }
            .padding(.horizontal, 16)
            .navigationBarTitle("Minha lista")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: AvatarView(), trailing: Button(action: {
                userStore.logout()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(Color("lightBlue"))
            }))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserStore())
    }
}
