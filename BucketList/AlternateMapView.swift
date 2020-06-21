//
//  AlternateMapView.swift
//  BucketList
//
//  Created by Aldiyar Batyrbekov on 6/19/20.
//  Copyright © 2020 Aldiyar B. All rights reserved.
//

import SwiftUI
import MapKit

struct AlternateMapView: UIViewRepresentable {

    
    var locationManager = CLLocationManager()
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}

struct AlternateMapView_Previews: PreviewProvider {
    static var previews: some View {
        AlternateMapView()
    }
}
