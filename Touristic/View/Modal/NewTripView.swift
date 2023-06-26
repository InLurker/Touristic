//
//  NewTripView.swift
//  Touristic
//
//  Created by Billy Jefferson on 23/06/23.
//

import SwiftUI

struct NewTripView: View {
    @Environment(\.dismiss) var dismiss
    @State private var TripName = ""
    private var TripList = TripNameSet.shared
    var body: some View {
        NavigationStack{
            VStack {
                Text("Give Your Trip A Name!")
                TextField("Trip Name",text: $TripName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Button(action:{
                    TripList.tripNameSet.append(TripName)
                    print(TripList)
                    dismiss()
                }){
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
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{
                        
                    }){
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
        NewTripView()
    }
}
