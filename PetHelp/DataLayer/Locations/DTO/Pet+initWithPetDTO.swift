//
//  Pet+initWithPetDTO.swift
//  PetHelp
//
//  Created by Lucas Silveira on 01/10/20.
//

import Foundation

extension Pet {

//    getLocations

    init(petDTO: PetDTO) {
        id = petDTO.id!
        race = petDTO.race
        race = petDTO.race
        name = petDTO.name
        description = petDTO.description
        document = petDTO.document
        agency = petDTO.agency
        account = petDTO.account
    }
}
