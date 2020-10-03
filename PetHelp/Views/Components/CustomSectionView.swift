//
//  CustomSectionView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 27/09/20.
//

import SwiftUI

struct CustomSectionView: View {
    var text = "Section"
    var body: some View {
        VStack {
            Text(text)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("buttonCircleBackground"))
        .opacity(0.8)

    }
}


struct CustomSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSectionView()
    }
}
