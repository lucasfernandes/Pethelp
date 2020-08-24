//
//  BaseView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 22/08/20.
//

import SwiftUI

struct BaseView<Content: View>: View {
    @State private var offsetValue: CGFloat = 0.0
    private var isNavigationEnabled: Bool
    let content: Content

    init(isNavigationEnabled: Bool = false, @ViewBuilder content: () -> Content) {
        self.isNavigationEnabled = isNavigationEnabled
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack {
                Spacer().frame(height: isNavigationEnabled ? 150 : 50)
                content
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.all, 16)
        }
        .background(Color("viewBackground"))
        .edgesIgnoringSafeArea(.all)
    }
}
