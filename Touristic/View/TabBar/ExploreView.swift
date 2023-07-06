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
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 14) {
                    ForEach(fitleredPlace, id: \.place_id) { place in
                        PlacesCardView(placeID: place.place_id, interests: place.interest, name: place.name, images: place.images)
                    }
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 25)
            }
            .frame(maxHeight: .infinity)
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
            getPlacesByInterest { result in
                switch result {
                case .success(let place):
                    places = place
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    var fitleredPlace: [PlaceAdapter] {
        if searchQuery.isEmpty {
            return places
        }else { return places.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        }
    }
}
