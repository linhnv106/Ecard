//
//  MapViewExtentsion.swift
//  ECard
//
//  Created by LinhNguyen on 10/27/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import MapKit
extension MKMapView
{
    func findPlacemark(for addressStr: String, onDone: @escaping (MKPlacemark?) -> ())
    {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressStr)
        { placemarks, _ in
            if let placemark = placemarks?.first, placemark.location != nil
            {
                onDone(MKPlacemark(placemark: placemark))
            }
            else
            {
                onDone(nil)
            }
        }
    }
}
