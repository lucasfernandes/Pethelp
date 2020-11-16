//
//  LocationFoundView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 27/09/20.
//

import SwiftUI
import MapKit

struct LocationFoundView: View {
    @Binding var location: Location?
    var onCloseTouch: (() -> Void)
    var onCreateNewTouch: (() -> Void)

    var body: some View {
        VStack(spacing: 4) {
            SheetHeaderView(title: location?.title ?? "", onTouch: onCloseTouch)
                .padding(.bottom, 5)
            VStack(spacing: 3) {
                Text("\(location?.place.thoroughfare ?? ""), \(location?.place.subThoroughfare ?? "") - \(location?.place.subLocality ?? "")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                    .foregroundColor(.secondary)
                Text("\(location?.place.locality ?? "") - \(location?.place.administrativeArea ?? "")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(location?.place.postalCode ?? "") - \(location?.place.administrativeArea ?? ""), \(location?.place.country ?? "")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top)

            Divider().background(Color("listItemOpaqueLightGray"))
                .padding(.top, 20)
                .padding(.bottom, 10)

            HStack {
                Button(action: onCreateNewTouch, label: {
                    Text("Criar novo pet")
                        .frame(maxWidth: .infinity)
                        .padding()
                })
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

        }
        .padding(.horizontal)
    }
}

struct LocationFoundView_Previews: PreviewProvider {
    static var previews: some View {
        LocationFoundView(
            location: .constant(Location(id: "ID", title: "", coordinate: CLLocationCoordinate2D(), place: MKPlacemark())),
            onCloseTouch: {},
            onCreateNewTouch: {})
    }
}
