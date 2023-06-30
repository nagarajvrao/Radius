//
//  FacilitiesResponse.swift
//  Radius
//
//  Created by Nagaraj V Rao on 29/06/23.
//

import Foundation

struct FacilitiesResponse: Codable {
    let facilities: [FacilityResponse]
    let exclusions: [[ExclusionResponse]]
}

// MARK: - Exclusion
struct ExclusionResponse: Codable {
    let facilityID, optionsID: String

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case optionsID = "options_id"
    }
}

// MARK: - Facility
struct FacilityResponse: Codable {
    let facilityID, name: String
    let options: [OptionResponse]

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case name, options
    }
}

// MARK: - Option
struct OptionResponse: Codable {
    let name, icon, id: String
}
