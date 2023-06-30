//
//  CardView.swift
//  Radius
//
//  Created by Nagaraj V Rao on 28/06/23.
//

import SwiftUI

struct CardView: View {
    let icon: Image
    let title: String
    let background = Color.white
    let isDisabled: Bool
    
    @State private var isSelected = false
    var onSelect: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            icon
                .resizable()
                .frame(width: 50, height: 50)
                .opacity(isDisabled ? 0.5 : 1.0)
                .disabled(isDisabled)
            
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(width: 100, height: 120)
        .background(background)
        .cornerRadius(10)
        .shadow(radius: 4)
        .opacity(isDisabled ? 0.5 : 1.0)
        .disabled(isDisabled)
        .onTapGesture {
            if !isDisabled {
                isSelected.toggle()
                onSelect?()
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: isSelected ? 2 : 0)
        )
    }
}

