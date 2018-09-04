//
//  City.swift
//  Wedro
//
//  Performs partial JSON deserialization.
//
//  Created by Jan Růžička on 04/09/2018.
//  Copyright © 2018 Jan Růžička. All rights reserved.
//

import Foundation


struct City {
    let name: String
    let country: String
    
    let id: Int
    let location: (latitude: Double, longitude: Double)
}

extension City {
    init?(json: [String: Any]) {
        guard
            let name = json["name"] as? String,
            let country = json["contry"] as? String,
            let id = json["id"] as? Int,
            let location = json["coord"] as? [String: Double]
        else {
            return nil
        }
        
        guard
            let latitude = location["lat"],
            let longitude = location["lng"]
        else {
            return nil
        }
        
        self.name = name
        self.country = country
        
        self.id = id
        self.location = (latitude, longitude)
    }
}
