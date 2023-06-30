//
//  FacilitiesViewModel.swift
//  Radius
//
//  Created by Nagaraj V Rao on 29/06/23.
//

import Foundation
import Combine

final class FacilitiesViewModel: ObservableObject {
    private var response: FacilitiesResponse?
    
    private var facilities: [Facility] = []
    private var exclusions: [[Exclusion]] = []
    
    @Published var propertyTypes: [Option] = []
    @Published var numberOfRooms: [Option] = []
    @Published var otherFacilities: [Option] = []
    
    var ds: (propertyTypes: [Option]?, numberOfRooms: [Option]?, otherFacilities: [Option]?)
    
    var exclusionDict: [String: Set<String>] {
        var dictionary: [String: Set<String>] = [:]
        
        let flattenedExclusions = exclusions.flatMap { $0 }
        
        for exclusion in flattenedExclusions {
            let facilityID = exclusion.facilityID
            let optionsID = exclusion.optionsID
            
            if dictionary[facilityID] != nil {
                dictionary[facilityID]?.insert(optionsID)
            } else {
                dictionary[facilityID] = [optionsID]
            }
            
            if dictionary[optionsID] != nil {
                dictionary[optionsID]?.insert(facilityID)
            } else {
                dictionary[optionsID] = [facilityID]
            }
        }
        
        return dictionary
    }

    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage = ""
    
    private var cancellable: AnyCancellable?

    init() {
        isLoading = true
        cancellable = Networking.shared.loadFacilities()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.isError = true
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] facilities in
                guard let self = self else { return }
                isError = false
                response = facilities
                generateModels(from: facilities)
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}


extension FacilitiesViewModel {
    // Generate the models from the Codable models
    func generateModels(from response: FacilitiesResponse) {
        facilities = response.facilities.map { facility in
            Facility(facility: facility)
        }

        exclusions = response.exclusions.map { exclusionArray in
            exclusionArray.map { exclusion in
                Exclusion(exclusion: exclusion)
            }
        }
        propertyTypes = facilities.value(at: 0)?.options ?? []
        numberOfRooms = facilities.value(at: 1)?.options ?? []
        otherFacilities = facilities.value(at: 2)?.options ?? []
        
        ds = (propertyTypes, numberOfRooms, otherFacilities)
    }
    
    func clear() {
        propertyTypes = ds.propertyTypes ?? []
        numberOfRooms = ds.numberOfRooms ?? []
        otherFacilities = ds.otherFacilities ?? []
    }
}

extension FacilitiesViewModel: Selectable {
    func onSelecting(id: String) {
        guard let toBeDisabled = exclusionDict[id] else { return }
        disable(ids: toBeDisabled)
    }
    
    private func disable(ids: Set<String>) {
        let propertyTpesCopy = propertyTypes.map { $0.copy() as! Option }
        let numberOfRoomsCopy = numberOfRooms.map { $0.copy() as! Option }
        let otherFacilitiesCopy = otherFacilities.map { $0.copy() as! Option }
        
        propertyTpesCopy.forEach { option in
            if ids.contains(option.id) {
                option.isDisabled.toggle()
                propertyTypes = propertyTpesCopy
            }
        }
        
        numberOfRoomsCopy.forEach { option in
            if ids.contains(option.id) {
                option.isDisabled.toggle()
                numberOfRooms = numberOfRoomsCopy
            }
        }
        
        otherFacilitiesCopy.forEach { option in
            if ids.contains(option.id) {
                option.isDisabled.toggle()
                otherFacilities = otherFacilitiesCopy
            }
        }
    }
}

