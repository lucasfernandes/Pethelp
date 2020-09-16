//
//  NewAccountView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userStore: UserStore
    @State var newIsPresented = false


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
                    .padding(.top, 100)
                }
            }
            .padding(.horizontal, 16)
            .navigationBarTitle("Minha lista", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: AvatarView(), trailing: Button(action: {
                newIsPresented = true
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(Color("lightBlue"))
            }))
        }

//        NavigationLink(destination: MapView(), isActive: $newIsPresented) {}

//        .sheet(isPresented: $newIsPresented) {
//            MapView()
//        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserStore())
    }
}
