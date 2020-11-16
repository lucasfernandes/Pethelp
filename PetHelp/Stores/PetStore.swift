//
//  PetStore.swift
//  PetHelp
//
//  Created by Lucas Silveira on 20/09/20.
//

import Foundation
import MapKit

class PetStore: LocationManagerX, Pets {
    @Published var pets: [Pet] = []

    func addPet() {
        self.setLocation(coordinate2D: CLLocationCoordinate2D()) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                if value == true {
                    self.add(pet: Pet(id: "", race: "", name: "", description: "", document: "", agency: "", account: "", locations: [])) { (result2) in
                        switch result2 {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case .success(let pet):
                            self.pets.append(pet)
                        }
                    }
                }
            }
        }
    }
}
