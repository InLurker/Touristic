//
//  NewTripView.swift
//  Touristic
//
//  Created by Billy Jefferson on 23/06/23.
//

import SwiftUI

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
                
                Button(action: {
                    if tripName.isEmpty {
                        // Pass "TripName" to the parent view when the TextField is empty
                        onCreateTrip?("TripName")
                    } else {
                        
                        // Notify the parent view about the new trip
                        onCreateTrip?(tripName)
                    }
                    
                    dismiss()
                }) {
                    Spacer()
                    Text("Create Trip!")
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
            }
            .navigationBarTitle("Trip", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action:{
                        dismiss()
                    }){
                        Text("Cancel")
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if tripName.isEmpty {
                            // Pass "TripName" to the parent view when the TextField is empty
                            onCreateTrip?("TripName")
                        } else {
                            // Handle the "Done" button action
                            
                            // Notify the parent view about the new trip
                            onCreateTrip?(tripName)
                        }
                        dismiss()
                    }) {
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
}

struct NewTripView_Previews: PreviewProvider {
    static var previews: some View {
        NewTripModal(
            onCreateTrip: { tripName in
                print(tripName)
                
            }
        )
    }
}
