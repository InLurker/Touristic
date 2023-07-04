//
//  ContentView.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-22.
//

import SwiftUI

struct PinnedView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Trip.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Trip.objectID, ascending: false)
        ]
    ) var trips: FetchedResults<Trip>
    
    @State private var searchText = ""
    @State private var isShowingModalNewTrip = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack() {
            VStack{
                if filteredTripList.count < 1 {
                        Text("You don’t have any pinned explore yet.\nAdd by clicking the '+' icon in the top right corner.")
                            .multilineTextAlignment(.center)
                } else {
                    List{
                        Section {
                            ForEach(filteredTripList, id: \.self) { trip in
                                NavigationLink(destination: TripActivityView()) {
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
                                    }
                                    .padding(.vertical, 14)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            .onDelete(perform: deleteTrip)
                        }
                    header: { Text("") }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Pinned")
            .toolbar{
                Button(action:{
                    isShowingModalNewTrip = true
                },label:{
                    Image(systemName: "plus")
                        .foregroundColor(Color.accentColor)
                        .padding(.horizontal)
                })
                .sheet(isPresented: $isShowingModalNewTrip) {
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
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Failed To Create New Trip"),
                        message: Text("An error occurred while creating the trip."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .searchable(text: $searchText, prompt: "Trip Name")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    var filteredTripList: [Trip] {
        if searchText.isEmpty {
            return Array(trips)
        } else {
            return trips.filter { trip in
                trip.name?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }
    
    private func deleteTrip(at offsets: IndexSet) {
        offsets.forEach { index in
            let trip = trips[index]
            let result = DataRepository.shared.removeTrip(
                context: viewContext,
                trip: trip
            )
            if result == false {
                // Handle error if trip deletion fails
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PinnedView()
    }
}
