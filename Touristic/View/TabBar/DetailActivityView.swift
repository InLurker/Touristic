//
//  DetailActivityView.swift
//  Touristic
//
//  Created by Billy Jefferson on 26/06/23.
//

import SwiftUI
import MapKit

struct DetailActivityView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isExpanded = false
    @State private var reviewExpanded = false
    @State var detailPlace : PlaceAdapter
    @State var carouselItems : [String]
    @State var pinIcon = "pin"
    @State var isShowAddToTripModal = false
    
    init(detailPlace: PlaceAdapter) {
        self.detailPlace = detailPlace
        self.carouselItems = detailPlace.images
    }
    
    var body: some View {
        NavigationStack(){
                ScrollView{
                    VStack{
                        TabView {
                            ForEach(0..<carouselItems.count, id: \.self) { index in
                                AsyncImage(url: URL(string: carouselItems[index])) { phase in
                                    switch phase {
                                    case .empty:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFill()
                                    case .success(let image):
                                        image.resizable()
                                            .scaledToFill()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFill()
                                    @unknown default:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFill()
                                    }
                                }
                            }
                        }.tabViewStyle(PageTabViewStyle())
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .frame(height: 250)
                    }
                    VStack{
                        HStack{
                            Text("\(detailPlace.name)")
                                .font(.title)
                            Spacer()
                            Button(
                                action: {
                                    isShowAddToTripModal = true
                                }
                            ) {
                                Image(systemName: pinIcon)
                                    .foregroundColor(.accentColor)
                            }
                            .onChange(of: isShowAddToTripModal) { isBeingShown in
                                if !isBeingShown {
                                    checkForPin()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom,7)
                        HStack {
                            Text("\(detailPlace.description)")
                                .lineLimit(isExpanded ? nil : 3)
                                .fixedSize(horizontal: false, vertical: true)
                            VStack{
                                Spacer()
                                Button(action: {
                                    isExpanded.toggle()
                                }) {
                                    Text(isExpanded ? "Less" : "More")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    .padding([.horizontal,.vertical],25)
                    VStack{
                        HStack{
                            Text("Price")
                                .padding(.bottom,7)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .fontWeight(.bold)
                        ForEach(detailPlace.prices, id: \.place_id) { price in
                            HStack{
                                Image(systemName: "figure.walk")
                                    .foregroundColor(.yellow)
                                Text("\(price.type.capitalized) : \(price.price)")
                                Spacer()
                                
                            }
                            .padding(.bottom,25)
                            VStack{
                                HStack{
                                    Text("Activites")
                                        .padding(.bottom,7)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                LazyVStack (alignment: .leading){
                                    let columnCount = 2
                                    let rowCount = (detailPlace.interest.count + columnCount - 1) / columnCount
                                    
                                    ForEach(0..<rowCount) { rowIndex in
                                        HStack(spacing: 16) {
                                            ForEach(0..<columnCount) { columnIndex in
                                                let index = rowIndex * columnCount + columnIndex
                                                if index < detailPlace.interest.count {
                                                    let interest = detailPlace.interest[index]
                                                    
                                                    HStack {
                                                        Image(systemName: "pin")
                                                        Text("\(interest)")
                                                        Spacer()
                                                    }
                                                    
                                                } else {
                                                    Spacer()
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            
                            .padding(.bottom,25)
                            VStack{
                                HStack{
                                    Text("Review")
                                        .padding(.bottom,7)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text(detailPlace.avg_rating)
                                    Spacer()
                                    NavigationLink(destination:DetailReviewView(reviews: detailPlace.reviews)){
                                        Text("See All")
                                    }
                                }
                                .padding(.bottom,7)
                                .frame(maxWidth: .infinity)
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 113)
                                    .foregroundColor(Color(UIColor.systemGray6))
                                    .overlay(
                                        VStack(alignment: .leading){
                                            HStack{
                                                Text(detailPlace.reviews.first?.name ?? "Review name")
                                                    .bold()
                                                Spacer()
                                                Image(systemName: "star.fill")
                                                Text(String(removeTrailingZero(detailPlace.reviews.first?.rating ?? 5.0)))
                                            }
                                            Spacer()
                                            Text(detailPlace.reviews.first?.description ?? "lor")
                                                .lineLimit(reviewExpanded ? nil : 3)
                                            HStack{
                                                Spacer()
                                                NavigationLink(destination:ReviewExpandedView(review: detailPlace.reviews.first ?? ReviewAdapter(id: "r1", place_id: "p1", name: "toreto", description: "lorem", rating: 5.0))){
                                                    Text("more")
                                                }
                                            }
                                        }
                                            .padding(16)
                                    )
                            }
                            VStack{
                                Text("Location")
                                    .padding(.bottom,7)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 183)
                                    .foregroundColor(Color(UIColor.systemGray6))
                                    .overlay(
                                        VStack{
                                            Text("distance")
                                            MapView(coordinate: CLLocationCoordinate2D(latitude: detailPlace.latitude, longitude: detailPlace.longitude))
                                                .frame(height: 150)
                                                .cornerRadius(10)
                                        }
                                    )
                            }
                            
                        }
                    }
                    .padding(.horizontal,25)
            }
                .navigationBarTitle("Place Details")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .sheet(isPresented: $isShowAddToTripModal) {
            AddToTripListModal(
                place_id: detailPlace.place_id
            )
            .presentationDetents([.height(UIScreen.main.bounds.size.height / 2) , .medium, .large])
            .presentationDragIndicator(.automatic)
        }
        .onAppear{
            checkForPin()
        }
    }
    func checkForPin() {
        let placeIsPinned = DataRepository.shared.isPlacePinned(context: viewContext, placeID: detailPlace.place_id)
        pinIcon = placeIsPinned ? "pin.fill" : "pin"
    }
}

struct DetailActivityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailActivityView(detailPlace: PlaceAdapter(place_id: "p1", name: "Bali", description: "Lorem", latitude: 9.29283, longitude: -1.2037972, interest: ["oke", "ok", "u", "o"], images: ["photo.fill","photo","photo.tv"], reviews: [ReviewAdapter(id: "r1", place_id: "p1", name: "toreto", description: "lorem", rating: 5.0)], avg_rating: "5.0", prices: [Prices(id: "c1", place_id: "p1", type: "entry", price: "Rp 100.000")]))
    }
    
}


