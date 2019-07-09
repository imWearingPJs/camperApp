//
//  CamperDataModel.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import Foundation
import MapKit

struct ApiResponse: Codable {
    let success: Bool?
    let message: String?
    let sites: [CamperDataModel]
}

class CamperDataModel: NSObject, Codable, MKAnnotation {
    var id: Int
    var latitude: Double?
    var longitude: Double?
    var name: String?
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    // Note, the coordinate var is not a part of the decoded JSON file.
    // It is derived from the lat and lon attributes, which are in the
    // JSON file.
    
    enum CodingKeys: String, CodingKey {
        case id
        case latitude
        case longitude
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        self.coordinate = CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
        self.title = name
        self.subtitle = (String(self.latitude!) + ", " + String(self.longitude!))
    }
}
