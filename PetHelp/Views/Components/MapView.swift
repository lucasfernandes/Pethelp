//
//  MapView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 28/08/20.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var locationManager = LocationManager()
    @State private var search = ""
    @State private var trackingMode = MapUserTrackingMode.follow
    @State var annotations: [Location] = []

    var body: some View {
        NavigationView {

            ZStack(alignment: .top) {
                Map(
                    coordinateRegion: $locationManager.currentLocation,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: $trackingMode,
                    annotationItems: $locationManager.annotations.wrappedValue) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        MapAnnotationView(name: location.title, image: Image("dog"))
                    }
                }

                VStack {
                    ZStack {
                        RoundedTextField(placehoder: "Procure um local", text: $search, onEditingChanged: {
                            if $search.wrappedValue.count > 3 {
                                locationManager.autoCompletedSearch(text: $search.wrappedValue)
                            }
                        })
                            .padding()
                            .offset(y: 44)


                        if $search.wrappedValue.isEmpty == false {
                            Button(action: {
                                self.search = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .offset(y: 44)
                            .padding(.trailing, 28)
                            .foregroundColor(.red)
                        }
                    }

                    SearchResultsListView(
                        results: $locationManager.searchResults,
                        selectedFragment: $locationManager.selectedFragment,
                        onSelect: {
                            self.search = ""
                            self.locationManager.searchResults = []
                        })
                        .frame(maxWidth: .infinity, maxHeight: CGFloat($locationManager.searchResults.wrappedValue.count) * 85)
                            .padding(.horizontal, 16)
                            .padding(.top, 30)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Incluir novo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle")
                    .font(Font.system(.headline))
            })
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
