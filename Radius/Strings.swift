//
//  Strings.swift
//  Radius
//
//  Created by Nagaraj V Rao on 29/06/23.
//

import Foundation

enum Strings: String {
    case propertyType = "Property Type"
    case numberofRooms = "Number of Rooms"
    case otherFacilities = "Other facilities"
    
    var localised: String {
        rawValue
    }
}
