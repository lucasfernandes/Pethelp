//
//  String+getImage.swift
//  PetHelp
//
//  Created by Lucas Silveira on 25/08/20.
//

import SwiftUI

extension String {
    func getImage() -> Image {
        guard let imageUrl = URL(string: self) else {
            return Image("car-full")
        }

        do {
            let data = try Data(contentsOf: imageUrl)
            return Image(uiImage: UIImage(data: data)!)
        } catch {
            return Image("Illustration")
        }
    }
}
