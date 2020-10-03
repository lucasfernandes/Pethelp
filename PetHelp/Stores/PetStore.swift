//
//  PetStore.swift
//  PetHelp
//
//  Created by Lucas Silveira on 20/09/20.
//

import Foundation

class PetStore: ObservableObject {
    @Published var pets = []
    var pet: Pet?
}

extension PetStore {
    func save(pet: Pet) {
        //
    }

    func update(pet: Pet) {
        //
    }
}
