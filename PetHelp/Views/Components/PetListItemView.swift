//
//  PetListItemView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 26/08/20.
//

import SwiftUI

struct PetListItemView: View {
    var onTouchUpInside: (() -> Void)? = {}
    var body: some View {
        Button(action: {
            onTouchUpInside!()
        }, label: {
            HStack {
                Image("dog")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .padding(.all, 8)
                    .padding(.leading, 8)

                VStack(alignment: .leading) {
                    Text("Bull Terrier").font(.subheadline)
                    Text("Milou").font(.title2).fontWeight(.bold)
                    Text("Postado dia 12/02").font(.caption2).padding(.top, 10)
                }.foregroundColor(Color.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing, 16)
                    .foregroundColor(Color("listItemDark"))
            }
            .frame(maxWidth: .infinity, minHeight: 96, alignment: .leading)
            .border(Color.white, width: 1)
            .cornerRadius(2)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 2)
                    .shadow(color: Color("listItemMidGray"), radius: 1, x: 0, y: 0)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .shadow(color: Color("listItemLightGray"), radius: 2, x: 0, y: 0)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .shadow(color: Color("listItemBlue"), radius: 9, x: 0, y: 0)
            )
            .cornerRadius(8)
            .shadow(color: Color("listItemMidGray"), radius: 5, x: 0, y: 0)
            .shadow(color: Color("listItemMidGray"), radius: 20, x: 10, y: 0)
        })
    }
}

struct PetListView: View {
    var body: some View {
        BaseView {
            ScrollView {
                LazyVStack {
                    ForEach((1...10).reversed(), id: \.self) { number in
                        PetListItemView(onTouchUpInside: { print(number) })
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                    }
                }
            }
        }
    }
}


struct PetListItemView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        PetListView()
    //    }

    static var previews: some View {
        BaseView {
            PetListItemView()
                .padding(.horizontal, 8)
        }
    }
}
