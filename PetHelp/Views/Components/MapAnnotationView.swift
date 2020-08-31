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
    var body: some View {
        VStack {
            image
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: 30, height: 30, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("lightBlue"), lineWidth: 2))
            Text(name)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(Color("lightBlue"))
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView(name: "Verme", image: Image("dog"))
    }
}
