//
//  ContentView.swift
//  Radius
//
//  Created by Nagaraj V Rao on 28/06/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = FacilitiesViewModel()
    @State private var showAlert = false // New state property to control the visibility of the alert

    var body: some View {
        VStack(alignment: .trailing) {
            ClearButton {
               vm.clear()
            }.padding(5)
            
            VStack {
                FacilitiesView(title: .propertyType, cardData: vm.propertyTypes, vm: vm)
                FacilitiesView(title: .numberofRooms, cardData: vm.numberOfRooms, vm: vm)
                FacilitiesView(title: .otherFacilities, cardData: vm.otherFacilities, vm: vm)
            }
            
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .foregroundColor(.blue)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(vm.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}





