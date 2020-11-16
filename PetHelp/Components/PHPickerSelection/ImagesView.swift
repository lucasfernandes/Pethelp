//
//  ImagesView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 20/09/20.
//

import SwiftUI
import Photos
import PhotosUI

struct ImagesView: View {
    @State private var images: [UIImage] = []
    @State private var picker = false
    var body: some View {
        VStack {
            if !images.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 45, height: 200)
                                .cornerRadius(20)
                        }
                    }
                }
            } else {
                Button(action: {
                    picker.toggle()
                }, label: {
                    Text("Pick images")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 35)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
            }
        }
        .sheet(isPresented: $picker) {
            NewImagePicker(images: $images, picker: $picker)
        }
    }
}

struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesView()
    }
}

struct NewImagePicker: UIViewControllerRepresentable {

    @Binding var images: [UIImage]
    @Binding var picker: Bool

    func makeCoordinator() -> Coordinator {
        return NewImagePicker.Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
//        config.filter = .images
        config.filter = .any(of: [.images, .videos])
        config.selectionLimit = 0
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: NewImagePicker

        init(parent: NewImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.picker.toggle()

            for currentImage in results {
                if currentImage.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    currentImage.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        guard let image = image else {
                            print(error)
                            return
                        }

                        self.parent.images.append(image as! UIImage)
                    }
                } else {
                    print("cannot be loaded")
                }
            }
        }
    }
}
