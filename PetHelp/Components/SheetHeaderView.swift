//
//  SheetHeader.swift
//  PetHelp
//
//  Created by Lucas Silveira on 17/09/20.
//

import SwiftUI

struct SheetHeaderView: View {
    var title = ""
    var onTouch: (() -> Void) = {}
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Button(action: onTouch) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct SheetHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeaderView()
    }
}
