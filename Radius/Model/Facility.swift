//
//  Facility.swift
//  Radius
//
//  Created by Nagaraj V Rao on 29/06/23.
//

import Foundation

class Facility {
    let facility: FacilityResponse

    var facilityID: String { facility.facilityID }
    var name: String { facility.name }
    var options: [Option] { facility.options.map { Option($0) } }

    init(facility: FacilityResponse) {
        self.facility = facility
    }
}

class Option {
    let option: OptionResponse

    var name: String { option.name }
    var icon: String { option.icon }
    var id: String { option.id }
    
    var isDisabled = false
//    var isSelected = false

    init(_ optionResponse: OptionResponse) {
        self.option = optionResponse
    }
}

extension Option: NSCopying, CardDataProtocol {
    func copy(with zone: NSZone? = nil) -> Any {
        let copiedOption = Option(option)
        copiedOption.isDisabled = isDisabled
        return copiedOption
    }
}


class Exclusion {
    let exclusion: ExclusionResponse

    var facilityID: String { exclusion.facilityID }
    var optionsID: String { exclusion.optionsID }

    init(exclusion: ExclusionResponse) {
        self.exclusion = exclusion
    }
}

