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

    @Published var region = MKCoordinateRegion()
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var annotations: [Location] = []
    @Published var locations: [MKPointAnnotation] = []
    @Published var locationFound: Location?
    @Published var selectedFragment: String = "" {
        didSet {
            selectedFragment.isEmpty
                ? searchResults = []
                : self.search(text: selectedFragment)
        }
    }

    override init() {
        super.init()

        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

        self.completer.delegate = self
        self.completer.region = self.region

        self.getCurrentLocation()
        self.getAllLocations()
    }

    private func getAllLocations() {
        let repository = LocationsRepo()
        repository.get { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let locations):
                for location in locations {
                    self.annotations.append(location)

                    let newLocation = MKPointAnnotation()
                    newLocation.title = location.title
                    newLocation.coordinate = location.place.coordinate
                    self.locations.append(newLocation)
                }

            }

        }

    }
}

extension LocationManager {
    private func makeRegion(coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                           longitude: coordinate.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }

    func getCurrentLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        region = makeRegion(coordinate: coordinate)
    }

    func search(text: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = self.region

        let search = MKLocalSearch(request: searchRequest)

        search.start { response, _ in
            guard let response = response else { return }

            for item in response.mapItems {
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
}

extension LocationManager: MKLocalSearchCompleterDelegate {
    func autoCompletedSearch(text: String) {
        completer.queryFragment = text
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
    }
}
