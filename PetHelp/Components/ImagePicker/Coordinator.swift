//
//  Coordinator.swift
//  PetHelp
//
//  Created by Lucas Silveira on 25/08/20.
//

import Foundation

import Foundation
import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker

    init(_ parent: ImagePicker) {
        self.parent = parent
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            parent.url = info[.imageURL] as? URL
            parent.image = uiImage
        }

        parent.presentationMode.wrappedValue.dismiss()
    }
}
