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
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 14){
                    ForEach(0..<10) { _ in
                        PlacesCardView()
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
                FilterInterestModal()
                
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
