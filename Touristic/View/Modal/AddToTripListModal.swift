//
//  AddToTripListModal.swift
//  Touristic
//
//  Created by masbek mbp-m2 on 30/06/23.
//

import SwiftUI
import AlertKit

struct AddToTripListModal: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var place_id : String
    @State var place_thumbnail: String
    @State private var isShowingNewTripModal = false
    @State private var showAlert = false
    
    @State private var tripsContainingPlaces: [Trip] = [] // original fetched array of trip id
    @State private var userSelectedTrip: [Trip] = [] // modifiable array of trip id
    
    @FetchRequest(
        entity: Trip.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Trip.dateUpdated, ascending: false)
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
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(Color.white)
                .frame(height: 40) // Adjust the height as needed
                ForEach(tripList, id: \.self) { trip in
                    HStack {
                        
                        AsyncImage(url: URL(string: trip.derivedThumbnail ?? "")) { phase in
                            switch phase {
                            case .empty:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .clipped()
                            case .success(let image):
                                image.resizable()
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .clipped()
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .clipped()
                            @unknown default:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .clipped()
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(trip.name ?? "Trip Name")
                            Text(activityCountFormatter(count: trip.places?.count ?? 0))
                        }
                        .padding(.horizontal, 10)
                        
                        Spacer()
                        
                        RoundedCheckbox(
                            trip: trip,
                            userSelectedTrip: $userSelectedTrip
                        )
                        .padding(.horizontal, 2)
                    }
                    .padding(.vertical, 14)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(25)
            .navigationBarTitle("Add To", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:{
                        dismiss()
                    }){
                        Text("Cancel")
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{
                        handleDoneButton()
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
        .onAppear{
            let fetchedTripList = DataRepository.shared.getTripsContainingPlaceID(context: viewContext, trips: Array(tripList), placeID: place_id)
            tripsContainingPlaces = fetchedTripList
            userSelectedTrip = fetchedTripList
        }
    }
    
    private func handleDoneButton() {
        let tripsToAdd = userSelectedTrip.filter { !tripsContainingPlaces.contains($0) }
        let tripsToRemove = tripsContainingPlaces.filter { !userSelectedTrip.contains($0) }
        
        
        tripsToAdd.forEach { trip in
            let success = DataRepository.shared.addPlaceToTrip(context: viewContext, trip: trip, placeID: place_id, place_thumbnail: place_thumbnail)
            if !success {
                AlertKitAPI.present(
                    title: "An error ocurred while saving.",
                    icon: .error,
                    style: .iOS17AppleMusic,
                    haptic: .success
                )
                return // Abort the iterator
            }
        }

        tripsToRemove.forEach { trip in
            let success = DataRepository.shared.removePlaceFromTrip(context: viewContext, trip: trip, placeID: place_id)
            if !success {
                AlertKitAPI.present(
                    title: "An error ocurred while saving.",
                    icon: .error,
                    style: .iOS17AppleMusic,
                    haptic: .success
                )
                return // Abort the iterator
            }
        }
        
        AlertKitAPI.present(
            title: "Changes saved.",
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
}

struct RoundedCheckbox: View {
    var trip: Trip
    @Binding var userSelectedTrip: [Trip]
    
    var isChecked: Bool {
        userSelectedTrip.contains(trip)
    }
    
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
            if isChecked {
                userSelectedTrip.removeAll { $0 == trip }
            } else {
                userSelectedTrip.append(trip)
            }
        }
    }
}
