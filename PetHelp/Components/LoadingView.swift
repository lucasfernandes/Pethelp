//
//  LoadingView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 26/08/20.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)

            ProgressView()
                .colorInvert()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
