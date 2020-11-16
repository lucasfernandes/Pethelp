//
//  Pets.swift
//  PetHelp
//
//  Created by Lucas Silveira on 12/10/20.
//

import Foundation

protocol Pets: ObservableObject {
    var pets: [Pet] { get }
    func add(pet: Pet, completion: @escaping (Result<Pet, Error>) -> Void)
    func get(completion: @escaping (Result<[Pet], Error>) -> Void)
    func remove(pet: Pet, completion: @escaping (Result<Pet.ID, Error>) -> Void)
}

extension Pets {
    func add(pet: Pet, completion: @escaping (Result<Pet, Error>) -> Void) {
        completion(.failure(URLError(.unknown)))
    }

    func get(completion: @escaping (Result<[Pet], Error>) -> Void) {
        completion(.failure(URLError(.unknown)))
    }

    func remove(pet: Pet, completion: @escaping (Result<Pet.ID, Error>) -> Void) {
        completion(.failure(URLError(.unknown)))
    }
}
