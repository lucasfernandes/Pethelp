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
    @ObservedObject private var locationManager = LocationManager()
    @State private var search = ""
    //    @State private var trackingMode = MapUserTrackingMode.follow
    @State var viewState: BottomSheetViewState = .peek
    @State var viewPetsState: BottomSheetViewState = .peek
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedLocation: CLLocationCoordinate2D? = nil

    var keyboardState = KeyboardState()

    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate,
                    selectedLocation: $selectedLocation,
                    annotations: locations,
                    region: locationManager.region)
                .edgesIgnoringSafeArea(.all)

            ZStack {
                BottomSheet(viewState: self.$viewState) {
                    VStack {
                        SearchBar(placeholder: "Procure o local",
                                  onEditingChanged: {
                                    if $search.wrappedValue.count > 3 {
                                        locationManager.autoCompletedSearch(text: $search.wrappedValue)
                                    }
                                  },
                                  onFocus: {
                                    self.viewState = .full
                                  },
                                  onBlur: {},
                                  text: $search)
                            .padding(.horizontal, 10)


                        VStack {
                            switch $viewState.wrappedValue {
                            case .full, .half:
                                VStack(alignment: .leading) {
                                    Text("Opções")
                                        .font(Font.subheadline.bold())
                                        .foregroundColor(.gray)
                                        .padding(.leading, 10)
                                        .padding(.bottom, -2)
                                    Divider()
                                        .background(Color.gray)
                                        .padding(.leading, 10)
                                    HStack {
                                        ButtonCircle(title: "Lista", subtitle: "de pets", iconName: "list.number", onTouch: {
                                            print("adding new one!")
                                        })

                                        ButtonCircle(title: "Adicionar", subtitle: "novo pet", onTouch: {
                                            print("adding new one!")
                                        })

                                    }
                                    .padding(.top, 10)
                                    .frame(alignment: .top)
                                }

                                if $locationManager.searchResults.wrappedValue.isEmpty {
                                    AnnotationsListView(
                                        annotations: $locationManager.annotations,
                                        selectedLocation: $selectedLocation,
                                        onSelect: {
                                            self.selectedLocation = nil
                                            self.viewState = .peek
                                        }
                                    )
                                    .frame(alignment: .top)
                                    .animation(.easeInOut(duration: 0.2))
                                } else {
                                    SearchResultsListView(
                                        results: $locationManager.searchResults,
                                        selectedFragment: $locationManager.selectedFragment,
                                        onSelect: {
                                            self.search = ""
                                            self.locationManager.searchResults = []
                                            self.viewState = .peek
                                        })
                                        .frame(alignment: .top)
                                        .animation(.easeInOut(duration: 0.2))
                                }
                            case .closed, .peek:
                                EmptyView()
                            }
                        }
                    }

                }
                .environmentObject(keyboardState)

//                BottomSheet(viewState: self.$viewPetsState) {
//                    VStack {
//                        Text("new bottom sheet").frame(maxWidth: .infinity)
//                    }
//                }
            }
        }
        .onReceive(locationManager.$locations) { locations in
            self.locations = locations
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}



//            Circle()
//                .fill(Color.blue)
//                .opacity(0.3)
//                .frame(width: 32, height: 32)

//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        let newLocation = MKPointAnnotation()
//                        newLocation.coordinate = self.centerCoordinate
//                        self.locations.append(newLocation)
//
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                    .frame(width: 24, height: 24)
//                    .padding()
//                    .background(Color.black.opacity(0.75))
//                    .foregroundColor(.white)
//                    .font(.title)
//                    .clipShape(Circle())
//                    .padding(.trailing)
//                }
//            }
