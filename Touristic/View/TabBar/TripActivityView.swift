//
//  TripActivityView.swift
//  Touristic
//
//  Created by Billy Jefferson on 26/06/23.
//

import SwiftUI
import CoreData
import AlertKit

struct TripActivityView: View {
    @State private var opacityChanged = 0.0
    @State private var isBouncing = false
    
    var trip: Trip
    
    @FetchRequest var placesInList: FetchedResults<Place>
        
    init(trip: Trip) {
        self.trip = trip
        
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = NSPredicate(format: "trip == %@", argumentArray: [trip])
        
        self._placesInList = FetchRequest(fetchRequest: fetchRequest)
    }
    
    @State var placeAdapters: [PlaceAdapter] = []
    
    var body: some View {
        NavigationStack(){
            VStack{
                ZStack{
                    if (trip.places?.count ?? 0 < 1) {
                        Text("You don’t have any pinned activities yet")
                            .multilineTextAlignment(.center)
                        HStack {
                            VStack{
                                Spacer()
                                Text("Click Here to Explore")
                                    .padding(.all)
                                Image(systemName: "arrow.down")
                                    .font(.custom("", size: 40))
                            }
                            .opacity(opacityChanged)
                            .scaleEffect(isBouncing ? 1.2 : 1.0)
                            .frame(width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.size.height / 8 * 4.5)
                            Spacer()
                        }
                        .task {
                            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                                self.opacityChanged = 1.0
                                self.isBouncing = true
                            }
                        }
                    } else {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 14) {
                                ForEach(placeAdapters, id: \.place_id) { place in
                                    NavigationLink(destination: DetailActivityView(detailPlace: place)) {
                                        PlacesCardView(place: place)
                                    }
                                    .foregroundColor(.primary)
                                }
                            }
                            .onChange(of: Array(placesInList)) { _ in
                                retrievePlacesInList()
                            }
                            .padding(.vertical, 14)
                            .padding(.horizontal, 25)
                        }
                    }
                }
                .onAppear{
                    retrievePlacesInList()
                }
            }
            .navigationTitle(trip.name ?? "Trip Name")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    func showPlaceRetrievalError() {
        AlertKitAPI.present(
            title: "Error occurred while retrieving place.",
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
    }
    
    
    func retrievePlacesInList() {
        placeAdapters.removeAll()
        placesInList.forEach { place in
            guard let placeID = place.place_id else {
                showPlaceRetrievalError()
                return
            }
            getPlaceById(place_id: placeID) { result in
                switch result {
                case .success(let place):
                    placeAdapters.append(place)
                case .failure(let error):
                    print(error)
                    showPlaceRetrievalError()
                }
            }
        }
    }
}
