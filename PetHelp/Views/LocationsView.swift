//
//  LocationsView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 07/09/20.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userStore: UserStore
    @ObservedObject private var locationManager = LocationManagerX()
    @State private var search = ""
    //    @State private var trackingMode = MapUserTrackingMode.follow
    @State var viewState: BottomSheetViewState = .half
    @State var viewPetsState: BottomSheetViewState = .closed
    @State var viewStateLocationFound: BottomSheetViewState = .closed
    @State var newPetPresented = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var locationFound: Location?
    @State private var selectedPlace: MKPointAnnotation?
    @State var showingPlaceDetails = false

    let list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] // list of pets

    var keyboardState = KeyboardState()

    var body: some View {
        ZStack(alignment: .topLeading) {
            MapView(centerCoordinate: $centerCoordinate,
                    selectedLocation: $selectedLocation,
                    selectedPlace: $selectedPlace,
                    showingPlaceDetails: $showingPlaceDetails,
                    annotations: locations,
                    region: locationManager.region)
                .edgesIgnoringSafeArea(.all)
            AvatarView().offset(x: 16, y: 30)

            ZStack {
                BottomSheet(viewState: self.$viewState) {
                    VStack {
                        SearchBar(placeholder: NSLocalizedString("locations_searchbar", comment: ""),
                                  onEditingChanged: {
                                    if $search.wrappedValue.count > 3 {
                                        locationManager.autoCompletedSearch(text: $search.wrappedValue)
                                    }
                                  },
                                  onFocus: {
                                    self.viewState = .full
                                  },
                                  onCleanText: {
                                    self.locationManager.searchResults = []
                                  },
                                  text: $search)
                            .padding(.horizontal, 10)

                        VStack {
                            switch $viewState.wrappedValue {
                            case .full, .half:
                                VStack(alignment: .leading) {
                                    if $locationManager.searchResults.wrappedValue.isEmpty {
                                        Text("locations_options")
                                            .font(Font.subheadline.bold())
                                            .foregroundColor(.gray)
                                            .padding(.leading, 10)
                                            .padding(.bottom, -2)
                                        Divider()
                                            .background(Color.gray)
                                            .padding(.leading, 10)
                                        HStack {
                                            ButtonCircle(
                                                title: NSLocalizedString(
                                                    "locations_button_list_title",
                                                    comment: ""
                                                ),
                                                subtitle: NSLocalizedString(
                                                    "locations_button_list_description",
                                                    comment: ""),
                                                iconName: "list.number",
                                                onTouch: {
                                                    hideKeyboard()
                                                    viewState = .closed
                                                    viewPetsState = .full
                                                })

                                            ButtonCircle(
                                                title: NSLocalizedString(
                                                    "locations_button_add_title",
                                                    comment: ""),
                                                subtitle: NSLocalizedString(
                                                    "locations_button_add_description",
                                                    comment: ""),
                                                onTouch: {
                                                    hideKeyboard()
                                                    print("adding new one!")
                                                    newPetPresented = true
                                                })

                                        }
                                        .padding(.top, 10)
                                        .frame(alignment: .top)

                                    } else {
                                        SearchResultsListView(
                                            results: $locationManager.searchResults,
                                            selectedFragment: $locationManager.selectedFragment,
                                            onSelect: {
                                                self.search = ""
                                                self.locationManager.searchResults = []
                                                self.viewState = .peek

//                                                if $locationManager.locationFound.wrappedValue != nil {
//                                                    self.selectedLocation = $locationManager.annotations.wrappedValue.last?.coordinate
////                                                    self.centerCoordinate = $locationManager.locationFound.wrappedValue!.coordinate
//                                                }
                                                hideKeyboard()
                                            })
                                            .frame(alignment: .top)
                                            .animation(.easeInOut(duration: 0.2))
                                    }
                                }

//                                                            if $locationManager.searchResults.wrappedValue.isEmpty {
//                                                                AnnotationsListView(
//                                                                    annotations: $locationManager.annotations,
//                                                                    selectedLocation: $selectedLocation,
//                                                                    onSelect: {
//                                                                        self.selectedLocation = nil
//                                                                        self.viewState = .peek
//                                                                    }
//                                                                )
//                                                                .frame(alignment: .top)
//                                                                .animation(.easeInOut(duration: 0.2))
//                                                            }
                            case .closed, .peek:
                                EmptyView()
                            }
                        }
                    }

                }
                .opacity(0.9)
                .environmentObject(keyboardState)

                BottomSheet(viewState: $viewStateLocationFound) {
                    LocationFoundView(
                        location: $locationManager.locationFound,
                        onCloseTouch: {
                            viewStateLocationFound = .closed
                            viewState = .half
                            self.centerCoordinate = MKCoordinateRegion().center
                        },
                        onCreateNewTouch: {
                            self.hideKeyboard()
                            self.locationManager.setLocation(coordinate2D: $locationManager.locationFound.wrappedValue?.coordinate ?? CLLocationCoordinate2D()) { _ in }
//                            newPetPresented = true
                        })
                }

                BottomSheet(viewState: self.$viewPetsState, showIndicator: false) {
                    PetListView(list: list,
                                viewState: $viewState,
                                viewPetsState: $viewPetsState)
                }

                .sheet(isPresented: $newPetPresented, content: {
                    NewPetView(firstLocation: $locationManager.locationFound, onClose: {
                        newPetPresented = false
                    })
                })
            }

            .alert(isPresented: $showingPlaceDetails) {
                Alert(
                    title: Text("Unknown"),
                    message: Text("Missing place information."),
                    primaryButton: .default(Text("OK")),
                    secondaryButton: .default(Text("Edit")) {
                        // edit this place
                    })
            }
        }
        .onReceive(locationManager.$locations) { locations in
            self.locations = locations
        }
        .onReceive(locationManager.$locationFound) { locationFound in
            if locationFound != nil {
                self.viewState = .closed
                self.viewPetsState = .closed
                self.viewStateLocationFound = .half

                self.centerCoordinate = locationFound?.coordinate ?? CLLocationCoordinate2D()
            }
        }
        .navigationBarHidden(true)
        .dismissKeyboardOnTapAnywhere()
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
