//
//  ExploreView.swift
//  Touristic
//
//  Created by Billy Jefferson on 23/06/23.
//

import SwiftUI

struct ExploreView: View {
    @State var searchQuery = ""
    @State var isShowingFilterModal : Bool = false
    @State var places: [PlaceAdapter] = []
    
    var body: some View {
        
        NavigationStack{
            ScrollView {
//                LazyVStack(alignment: .leading, spacing: 14){
                    ForEach(places, id: \.place_id) { place in
                        
                        PlacesCardView(interests: place.interest, name: place.name, images: place.images)
                    }
//                }
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
                FilterInterestModal()
                
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
    
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
