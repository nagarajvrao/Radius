//
//  Array+App.swift
//  Radius
//
//  Created by Nagaraj V Rao on 29/06/23.
//

import Foundation

extension Array {
    func value(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }
        
        return self[index]
    }
}
