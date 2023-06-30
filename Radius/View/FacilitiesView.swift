//
//  FacilitiesView.swift
//  Radius
//
//  Created by Nagaraj V Rao on 29/06/23.
//

import SwiftUI

protocol Selectable {
    func onSelecting(id: String)
}

struct FacilitiesView: View {
    let title: Strings
    let cardData: [Option]
    let vm: Selectable
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title.localised)
                .padding(10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(cardData) { card in
                        CardView(
                            icon: Image(card.icon),
                            title: card.name,
                            isDisabled: card.isDisabled,
                            onSelect: {
                                vm.onSelecting(id: card.id)
                            }
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


struct CardData: Identifiable {
    let id: Int
    let icon: Image
    let name: String
    var isDisabled: Bool
}

protocol CardDataProtocol: Identifiable {
    var id: String { get }
    var icon: String { get }
    var name: String { get }
    var isDisabled: Bool { get set }
}

