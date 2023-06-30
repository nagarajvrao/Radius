//
//  ClearButton.swift
//  Radius
//
//  Created by Nagaraj V Rao on 30/06/23.
//

import SwiftUI

struct ClearButton: View {
    var onTapped: (()->())?
    var body: some View {
        Button(action: {
            onTapped?()
        }) {
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                Text("Clear")
            }
            .foregroundColor(.cyan)
        }
    }
}
