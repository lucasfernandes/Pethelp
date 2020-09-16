//
//  MapAnnotationView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 30/08/20.
//

import SwiftUI

struct MapAnnotationView: View {
    var name: String
    var image: Image
    @State var size: CGFloat = 20

    var body: some View {
        VStack {
            Button(action: {
                size = $size.wrappedValue == 20 ? 60 : 20
                print("TAPPED =====>")
            }, label: {
                image
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(width: $size.wrappedValue, height: $size.wrappedValue, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                Text(name)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            })

        }
        .shadow(radius: 5)
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView(name: "Verme", image: Image("dog"))
    }
}
