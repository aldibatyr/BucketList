//
//  AuthenticatedView.swift
//  BucketList
//
//  Created by Aldiyar Batyrbekov on 6/20/20.
//  Copyright © 2020 Aldiyar B. All rights reserved.
//

import SwiftUI
import MapKit


struct AuthenticatedView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    @Binding var showingEditScreen: Bool
    @Binding var showingPlaceDetails: Bool
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var locations: [CodableMKPointAnnotation]
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                Button(action: {
                    let newLocation = CodableMKPointAnnotation()
                    newLocation.title = "Example location"
                    newLocation.subtitle = "Example subtitle"
                    newLocation.coordinate = self.centerCoordinate
                    self.locations.append(newLocation)
                    self.selectedPlace = newLocation
                    self.showingEditScreen = true
                }, label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                        .shadow(color: Color.black.opacity(0.45), radius: 5, x: 0, y: 4)
                })
                
            }
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView(showingEditScreen: .constant(false), showingPlaceDetails: .constant(false), selectedPlace: .constant(MKPointAnnotation.example), locations: .constant([MKPointAnnotation.example as! CodableMKPointAnnotation]))
    }
}
