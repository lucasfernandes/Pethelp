//
//  LocationManager.swift
//  PetHelp
//
//  Created by Lucas Silveira on 28/08/20.
//

import Foundation
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let completer: MKLocalSearchCompleter = MKLocalSearchCompleter()

    @Published var location: CLLocation? = nil
    @Published var currentLocation = MKCoordinateRegion()
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var annotations: [Location] = []
    @Published var selectedFragment: String = "" {
        didSet {
            self.search(text: selectedFragment)
        }
    }

    override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

        self.completer.delegate = self
        self.completer.region = self.currentLocation

        self.getCurrentLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status.rawValue)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        self.location = location
    }
}

extension LocationManager {
    func getCurrentLocation() {

        guard let coordinate = locationManager.location?.coordinate else {
            return
        }

        currentLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }

    func search(text: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = self.currentLocation

        let search = MKLocalSearch(request: searchRequest)

        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            for item in response.mapItems {
                let placemark = item.placemark
                print("\(placemark.thoroughfare!), \(placemark.subThoroughfare!) - \(placemark.subLocality!)")
                print("\(placemark.locality!) - \(placemark.administrativeArea!)")
                print("\(placemark.country!)")
                print(placemark.postalCode!)

                DispatchQueue.main.async {
                    self.annotations.append(Location(
                                                title: item.name ?? "No name found",
                                                coordinate: CLLocationCoordinate2D(
                                                    latitude: item.placemark.coordinate.latitude,
                                                    longitude: item.placemark.coordinate.longitude)))
                }
            }
        }
    }

    func autoCompletedSearch(text: String) {
        completer.queryFragment = text
    }
}

extension LocationManager: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
    }
}
