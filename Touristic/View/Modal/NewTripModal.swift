//
//  NewTripView.swift
//  Touristic
//
//  Created by Billy Jefferson on 23/06/23.
//

import SwiftUI
import AlertKit

struct NewTripModal: View {
    @Environment(\.dismiss) var dismiss
    @State private var tripName = ""
    var onCreateTrip: ((String) -> Void)?
    
    init(onCreateTrip: @escaping (String) -> Void) {
        self.onCreateTrip = onCreateTrip
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Give Your Trip A Name!")
                TextField("Trip Name", text: $tripName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                
                Button(
                    action: {
                        onAddNewTrip()
                    }
                ) {
                    Spacer()
                    Text("Create Trip!")
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(Color.white)
                .padding(.horizontal, 14)
            }
            .padding(.horizontal)
            .navigationBarTitle("Trip", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(
                        action: {
                            dismiss()
                        }
                    ) {
                        Text("Cancel")
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            onAddNewTrip()
                        }
                    ) {
                        Text("Done")
                            .foregroundColor(Color.accentColor)
                        
                            .padding(.horizontal)
                    }
                }
            }
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    func onAddNewTrip() {
        if tripName.isEmpty {
            // Pass "TripName" to the parent view when the TextField is empty
            onCreateTrip?("Trip")
        } else {
            // Handle the "Done" button action
            
            // Notify the parent view about the new trip
            onCreateTrip?(tripName)
        }
        
        AlertKitAPI.present(
            title: "New trip added.",
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
        dismiss()
    }
}
