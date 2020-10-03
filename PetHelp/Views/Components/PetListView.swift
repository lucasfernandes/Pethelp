//
//  PetListView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 20/09/20.
//

import SwiftUI

struct PetListView: View {
    var list: [Int]
    @Binding var viewState: BottomSheetViewState
    @Binding var viewPetsState: BottomSheetViewState
    var body: some View {
        ScrollView {
            SheetHeaderView(
                title: NSLocalizedString("pet_list_title", comment: ""),
                onTouch: {
                    self.viewPetsState = .closed
                    self.viewState = .half
                })
                .padding(.top, 20)
                .padding(.horizontal, 16)
            LazyVStack {
                ForEach((list).reversed(), id: \.self) { number in
                    PetListItemView(onTouchUpInside: { print(number) })
                        .padding(.vertical, 4)

                    Divider()
                        .background(Color.gray)
                        .padding(.leading, 30)
                }
            }

            if list.isEmpty {
                VStack {
                    Text("pet_list_empty")
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .padding(.top, 100)
            }
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetListView(list: [2], viewState: .constant(BottomSheetViewState.closed), viewPetsState: .constant(BottomSheetViewState.closed))
    }
}
