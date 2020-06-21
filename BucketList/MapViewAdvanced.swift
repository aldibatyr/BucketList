//
//  MapViewAdvanced.swift
//  BucketList
//
//  Created by Aldiyar Batyrbekov on 6/19/20.
//  Copyright © 2020 Aldiyar B. All rights reserved.
//

import SwiftUI
import MapKit

struct MapViewAdvanced: UIViewRepresentable {
    @Binding var checkpoints: [Checkpoint]
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.addAnnotations(checkpoints)
    }
}


