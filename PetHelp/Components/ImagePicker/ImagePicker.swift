//
//  ImagePicker.swift
//  PetHelp
//
//  Created by Lucas Silveira on 25/08/20.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var imageUrl: URL?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        //
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

