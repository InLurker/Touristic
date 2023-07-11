//
//  ExploreView.swift
//  Touristic
//
//  Created by Billy Jefferson on 23/06/23.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var selectedInterestData = SelectedInterestData.shared
        
    @State var selectedInterests: [String]
    
    @State var searchQuery = ""
    @State var isShowingFilterModal : Bool = false
    @State var places: [PlaceAdapter] = []
    
    init(selectedInterests: Binding<[String]> = .init(
        get: { SelectedInterestData.shared.selectedInterests },
        set: { SelectedInterestData.shared.selectedInterests = $0 }
    )) {
        _selectedInterests = State(initialValue: selectedInterests.wrappedValue)
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                if(places.count < 1) {
                    Spacer()
                    Text("No places match your interest selection.")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                else if (filteredPlace.count < 1) {
                    Spacer()
                    Text("No places match your search query.")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 14) {
                            ForEach(filteredPlace, id: \.place_id) { place in
                                NavigationLink(destination: DetailActivityView(detailPlace: place)) {
                                    PlacesCardView(place: place)
                                }
                                .foregroundColor(.primary)
                            }
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 25)
                    }
                }
            }
            .onChange(of: _selectedInterests.wrappedValue) { _ in
                fetchPlaceByInterest()
            }
            .navigationTitle("Explore")
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Activities Name") {        }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingFilterModal = true
                        // Handle filter button tap
                    }) {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $isShowingFilterModal) {
                FilterInterestModal(
                    selectedInterests: $selectedInterests
                )
            }
        }
        .onAppear {
            fetchPlaceByInterest()
        }
    }
    
    var filteredPlace: [PlaceAdapter] {
        if searchQuery.isEmpty {
            return places
        }else { return places.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        }
    }
    
    func fetchPlaceByInterest() {
        getPlacesByInterest(interests: selectedInterests) { result in
            switch result {
            case .success(let place):
                places = place
            case .failure(let error):
                print(error)
            }
        }
    }
}
