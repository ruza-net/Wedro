//
//  City.swift
//  Wedro
//
//  Implements the JSON Codable protocol.
//
//  Created by Jan Růžička on 04/09/2018.
//  Copyright © 2018 Jan Růžička. All rights reserved.
//

import Foundation


struct City: Codable {
    var name: String
    var country: String
    
    var id: Int
    var location: Location
    
    enum CodingKeys: String, CodingKey {
        case name, country, id
        
        case location = "coord"
    }
}

struct Location: Codable, CustomStringConvertible {
    var latitude: Float
    var longitude: Float
    
    public var description: String { return "[ latitude: \(self.latitude), longitude: \(self.longitude) ]" }
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
