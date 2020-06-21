//
//  Checkpoint.swift
//  BucketList
//
//  Created by Aldiyar Batyrbekov on 6/19/20.
//  Copyright © 2020 Aldiyar B. All rights reserved.
//

import Foundation
import MapKit

final class Checkpoint: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

