//
//  Mappable.swift
//  PetHelp
//
//  Created by Lucas Silveira on 10/10/20.
//

import Foundation
import MapKit
import CoreLocation
import FirebaseFirestore
import SwiftUI

protocol Mappable: ObservableObject {
    var locationManager: CLLocationManager { get set }
    var completer: MKLocalSearchCompleter { get set }
    var region: MKCoordinateRegion { get set }
    var searchResults: [MKLocalSearchCompletion] { get set }
    var annotations: [Location] { get set }
    var locations: [MKPointAnnotation] { get set }
    var locationFound: Location? { get set }
    var selectedFragment: String { get set }
    var currentCoordinate: CLLocation! { get set }
    var collectionRef: CollectionReference! { get set }
    var geoFirestore: GeoFirestore! { get set }
    var sfQuery: GFSQuery! { get set }

    func initLocationManager()
    func configGeofire()
    func getCurrentLocation() -> CLLocationCoordinate2D
    func getCurrentRegion(coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion
    func makeRegion()
    func makeCurrentCoordinate()
    func search(text: String, completion: @escaping (Result<[MKMapItem], Error>) -> Void)
    func setLocation(coordinate2D: CLLocationCoordinate2D, completion: @escaping (Result<Bool, Error>) -> Void)
    func getGeofireLocations()
    func makeLocations(items: [MKMapItem])
}

extension Mappable {
    func initLocationManager() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.makeRegion()
        self.makeCurrentCoordinate()
        self.configGeofire()
        self.getGeofireLocations()
    }

    func configGeofire() {
        collectionRef = Firestore.firestore().collection("geoloc-test")
        geoFirestore = GeoFirestore(collectionRef: collectionRef)
        sfQuery = geoFirestore.query(withCenter: currentCoordinate, radius: 50.0)
    }

    func getCurrentLocation() -> CLLocationCoordinate2D {
        return locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }

    func getCurrentRegion(coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                           longitude: coordinate.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }

    func makeRegion() {
        let currentLocation = getCurrentLocation()
        region = getCurrentRegion(coordinate: currentLocation)
    }

    func makeCurrentCoordinate() {
        let coordinate = getCurrentLocation()
        currentCoordinate = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

    func search(text: String, completion: @escaping (Result<[MKMapItem], Error>) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = self.region

        let search = MKLocalSearch(request: searchRequest)

        search.start { response, _ in
            guard let response = response else {
                completion(.failure(URLError(.unknown)))
                return
            }

            completion(.success(response.mapItems))
        }
    }

    func setLocation(coordinate2D: CLLocationCoordinate2D, completion: @escaping (Result<Bool, Error>) -> Void) {
        let location = CLLocation(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude)
        geoFirestore.setLocation(location: location,
                                 forDocumentWithID: collectionRef.document().documentID) { (err) in
            if let error = err {
                completion(.failure(error))
                return
            }

            completion(.success(true))
        }
    }

    func getGeofireLocations() {
        _ = sfQuery.observe(.documentEntered, with: { (key, location) in
            if let key = key, let loc = location {
                let newLocation = MKPointAnnotation()
                newLocation.title = key
                newLocation.coordinate = loc.coordinate
                self.locations.append(newLocation)
            }
        })
    }

    func makeLocations(items: [MKMapItem]) {
        for item in items {
            DispatchQueue.main.async {
                self.locationFound = Location(
                    id: UUID().description,
                    title: item.name ?? "No name found",
                    coordinate: CLLocationCoordinate2D(
                        latitude: item.placemark.coordinate.latitude,
                        longitude: item.placemark.coordinate.longitude),
                    place: item.placemark)

                self.annotations.append(self.locationFound!)

                let newLocation = MKPointAnnotation()
                newLocation.title = item.name ?? ""
                newLocation.coordinate = item.placemark.coordinate
                self.locations.append(newLocation) // the map loads it after onReceive -> LocationsView
            }
        }
    }
}
