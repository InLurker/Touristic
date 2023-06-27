//
//  ContentView.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-22.
//

import SwiftUI

struct PinnedView: View {
    @State private var searchText = ""
    @State private var isShowingModalNewTrip = false
    @ObservedObject private var TripList = TripNameSet.shared
    
    @State private var searchResultTripList = ["Trip 1", "Trip 2", "Trip 3", "Trip 4", "Trip 5", "Trip 6", "Trip 7", "Trip 9", "Trip 10"]
    
    var body: some View {
        NavigationStack(){
            List {
                if fitleredTripList.count < 1{
                    Text("You don’t have any pinned explore yet.\nAdd by click '+' icon in the right top corner.")
                        .multilineTextAlignment(.center)
                }
                else {
                    Section {
                        ForEach(fitleredTripList, id: \.self) { trip in
                            NavigationLink(destination: TripActivityView()) {
                                HStack {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .clipped()
                                    
                                    VStack(alignment: .leading) {
                                        Text(trip)
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
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Pinned")
            .toolbar{
                Button(action:{
                    isShowingModalNewTrip = true
                    print(TripList)
                },label:{
                    Image(systemName: "plus")
                        .foregroundColor(Color.accentColor)
                        .padding(.horizontal)
                })
                .sheet(isPresented: $isShowingModalNewTrip) {
                    NewTripView()
                        .presentationDetents([.height(UIScreen.main.bounds.size.height / 2) , .medium, .large])
                        .presentationDragIndicator(.automatic)
                }
            }
            .searchable(text: $searchText, prompt: "Trip Name")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        
    }
    
    var fitleredTripList: [String] {
        if searchText.isEmpty {
            return searchResultTripList
        } else {
            return searchResultTripList.filter { $0.lowercased().contains(searchText) }
        }
    }
    
    func deleteTrip(at offsets: IndexSet) {
        searchResultTripList.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PinnedView()
    }
}
