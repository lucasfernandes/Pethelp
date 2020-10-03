//
//  Pet.swift
//  PetHelp
//
//  Created by Lucas Silveira on 20/09/20.
//
//@State private var race = ""
//@State private var name = ""
//@State private var description = ""
//@State private var cpf = ""
//@State private var agency = ""
//@State private var account = ""
//
//@State private var images: [UIImage] = []
import Foundation

struct Pet: Identifiable {
    var id: String
    var race: String
    var name: String
    var description: String
    var document: String
    var agency: String
    var account: String
    var locations: [Location]?
}
