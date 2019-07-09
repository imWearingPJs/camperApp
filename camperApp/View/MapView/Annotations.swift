//
//  Annotations.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotationView: MKMarkerAnnotationView {  // use MKPinAnnotationView if we want pins instead
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        canShowCallout = true
        rightCalloutAccessoryView = UIButton(type: .infoLight)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
