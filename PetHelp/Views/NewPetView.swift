//
//  NewPetView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 17/09/20.
//

import SwiftUI
import MapKit
import TLCustomMask

struct NewPetView: View {
    @Binding var firstLocation: Location?

    @State private var race = ""
    @State private var name = ""
    @State private var description = ""
    @State private var document = ""
    @State private var agency = ""
    @State private var account = ""
    @State private var images: [UIImage] = []
    @State private var picker = false
    @State private var useMyCurrentLocation = true

    var cpfMask = TLCustomMask(formattingPattern: "$$$.$$$.$$$-$$")
    var agencyMask = TLCustomMask(formattingPattern: "$$$$")
    var accountMask = TLCustomMask(formattingPattern: "$$$$$-$")
    var onClose: (() -> Void) = {}
    var customMask = TLCustomMask()

    private func deleteImage(image: UIImage) {
        self.images.remove(at: self.images.firstIndex(of: image)!)
    }

    private func toogleLocation() {
        useMyCurrentLocation = !useMyCurrentLocation
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("sheetBackground").edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 20) {
                SheetHeaderView(title: "Novo pet", onTouch: onClose)
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                    .padding(.horizontal, 16)

                ScrollView {
                    VStack(alignment: .leading) {
                        CustomSectionView(text: "Descrição")
                        ZStack(alignment: .leading) {
                            if self.description.isEmpty {
                                VStack {
                                    Text("Descreva em detalhes o que está acontecendo com o animal")
                                        .padding(.top, 10)
                                        .padding(.leading, 3)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }.padding(.horizontal, 16)
                            }
                            TextEditor(text: $description)
                                .padding(.horizontal, 16)
                        }
                        .frame(height: 100)

                        Divider()
                        Button(action: {
                            picker.toggle()
                        }, label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Adicione até 4 fotos e 1 vídeo")
                                        .font(.caption)
                                    Image(systemName: "photo.on.rectangle").frame(alignment: .leading)
                                }
                                    .padding(.horizontal, 16)

                                Spacer()
                                if !images.isEmpty {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 15) {
                                            ForEach(images, id: \.self) { image in
                                                ZStack(alignment: .topTrailing) {
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 100, height: 80, alignment: .trailing)
                                                        .foregroundColor(.red)
                                                        .cornerRadius(20)
                                                    Button(action: {
                                                        deleteImage(image: image)
                                                    }, label: {
                                                        Image(systemName: "xmark.circle.fill")
                                                            .resizable()
                                                            .frame(width: 20, height: 20)
                                                            .foregroundColor(.red)
                                                    })
                                                    .offset(x: 7, y: -7)
                                                }
                                            }
                                        }.padding(.top, 20)
                                    }
                                    Spacer()
                                }
                            }
                            .sheet(isPresented: $picker) {
                                NewImagePicker(images: $images, picker: $picker)
                            }
                        })
                    }

                    VStack(alignment: .leading) {
                        CustomSectionView(text: "Detalhes")
                        TextField("Raça do animal", text: $race)
                            .padding(.horizontal, 16)

                        Divider()
                        TextField("O animal tem nome?", text: $name)
                            .padding(.horizontal, 16)
                        CustomSectionView(text: "Dados bancários")
                        TextField("CPF", text: $document)
                            .onChange(of: document) {
                                self.document = cpfMask.formatString(string: $0)}
                            .padding(.horizontal, 16)
                            .keyboardType(.numberPad)

                        Divider()
                        TextField("Número da agência", text: $agency)
                            .onChange(of: agency) {
                                self.agency = agencyMask.formatString(string: $0)}
                            .padding(.horizontal, 16)
                            .keyboardType(.numberPad)

                        Divider()
                        TextField("Número da conta", text: $account)
                            .onChange(of: account) {
                                self.account = accountMask.formatString(string: $0)}
                            .padding(.horizontal, 16)
                            .keyboardType(.numberPad)
                    }

                    if firstLocation != nil && useMyCurrentLocation == false {
                        CustomSectionView(text: "Local pesquisado")
                        VStack(alignment: .leading, spacing: 3) {
                            Text(firstLocation?.title ?? "")
                                .font(.title3)
                            Text("\(firstLocation?.place.thoroughfare ?? ""), \(firstLocation?.place.subThoroughfare ?? "") - \(firstLocation?.place.subLocality ?? "")")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(firstLocation?.place.locality ?? "") - \(firstLocation?.place.administrativeArea ?? "")")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(firstLocation?.place.postalCode ?? "") - \(firstLocation?.place.administrativeArea ?? ""), \(firstLocation?.place.country ?? "")")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 16)
                    }

                    VStack(alignment: .leading) {
                        CustomSectionView(text: "Último lugar visto")
                        VStack(alignment: .leading) {
                            Toggle(isOn: $useMyCurrentLocation) {
                                Text("Desejo Usar minha localização atual como local atual do animal")
                                    .font(.caption)
                            }
                        }.padding(.horizontal, 16)
                    }
                }
                .onAppear {
                    if firstLocation != nil {
                        toogleLocation()
                    }
                }
                .dismissKeyboardOnTapAnywhere()
            }
        }
    }
}

struct NewPetView_Previews: PreviewProvider {
    static var previews: some View {
        NewPetView(firstLocation: .constant(Location(
                                                id: "ID", title: "",
                                                coordinate: CLLocationCoordinate2D(),
                                                place: MKPlacemark())))
    }
}
