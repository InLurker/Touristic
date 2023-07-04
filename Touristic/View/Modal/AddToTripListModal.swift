//
//  AddToTripListModal.swift
//  Touristic
//
//  Created by masbek mbp-m2 on 30/06/23.
//

import SwiftUI

struct AddToTripListModal: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var place_id : String = ""
    @State private var isShowingNewTripModal = false
    @State private var showAlert = false
    
    @FetchRequest(
        entity: Trip.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Trip.objectID, ascending: false)
        ]
    ) var tripList: FetchedResults<Trip>
    
    var body: some View {
        NavigationStack{
            ScrollView() {
                Button(action: {
                    isShowingNewTripModal = true
                }) {
                    HStack {
                        Spacer()
                        Text("Add New Trip!")
                            .foregroundColor(.white) // Set the text color
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(height: 40) // Adjust the height as needed
                
                ForEach(tripList, id: \.self) { trip in
                    HStack {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .clipped()
                        
                        VStack(alignment: .leading) {
                            Text(trip.name ?? "Trip Name")
                            Text("0 Activity")
                        }
                        .padding(.horizontal, 10)
                        
                        Spacer()
                        
                        RoundedCheckbox(isChecked: DataRepository.shared.isPlaceInTrip(context: viewContext, trip: trip, placeID: place_id), place_id: place_id)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(25)
            .navigationBarTitle("Add To", displayMode: .inline)
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
                        dismiss()
                        
                    }){
                        Text("Done")
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Failed To Create New Trip"),
                    message: Text("An error occurred while creating the trip."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $isShowingNewTripModal) {
                NewTripModal(
                    onCreateTrip: { tripName in
                        let success = DataRepository.shared.createTrip(
                            context: viewContext,
                            tripName: tripName
                        )
                        if !success {
                            showAlert = true
                        }
                    }
                )
                .presentationDetents([.height(UIScreen.main.bounds.size.height / 2) , .medium, .large])
                .presentationDragIndicator(.automatic)
            }
        }
    }
}

struct RoundedCheckbox: View {
    @State var isChecked: Bool
    @State var place_id : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
                .frame(width: 24, height: 24)
            
            if isChecked {
                
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .onTapGesture {
            isChecked.toggle()
        }
    }
}

struct AddToTripListModal_Previews: PreviewProvider {
    static var previews: some View {
        AddToTripListModal()
    }
}
