//
//  DetailActivityView.swift
//  Touristic
//
//  Created by Billy Jefferson on 26/06/23.
//

import SwiftUI
import MapKit
import ExpandableText

struct DetailActivityView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isExpanded = false
    @State private var reviewExpanded = false
    @State var detailPlace : PlaceAdapter
    @State private var carouselItems : [String]
    @State private var pinIcon = "pin"
    @State private var isShowAddToTripModal = false
    @State private var address: String = ""
    
    init(detailPlace: PlaceAdapter) {
        self.detailPlace = detailPlace
        self.carouselItems = detailPlace.images
    }
    
    var body: some View {
        NavigationStack(){
            ScrollView{
                VStack{
                    TabView {
                        ForEach(carouselItems, id:\.self) { item in
                            AsyncImage(url: URL(string: item)) { phase in
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
                    }
                    .tabViewStyle(PageTabViewStyle())
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
                    ExpandableText(detailPlace.description)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                        .moreButtonText("more")
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
                            Text("\(price.type.capitalized) : \(price.price)")
                            Spacer()
                            
                        }
                        .padding(.bottom, 25)
                    }
                    
                    VStack{
                        HStack{
                            Text("Activites")
                                .padding(.bottom,7)
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ],
                            alignment: .leading,
                            spacing: 16
                        ){
                            ForEach(detailPlace.interest, id:\.self) { interest in
                                HStack {
                                    Image(systemName: "pin")
                                    Text("\(interest)".capitalized)
                                }
                            }
                        }
                    }
                    .padding(.bottom,25)
                    
                    
                    VStack{
                        HStack(alignment: .center) {
                            Text("Review")
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
                        VStack(alignment: .leading) {
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
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                    }
                    .padding(.bottom,16)
                    
                    VStack(alignment: .leading) {
                        Text("Location")
                            .padding(.bottom,7)
                            .font(.title2)
                            .fontWeight(.bold)
                        VStack(alignment: .leading) {
                            Text(address)
                                .font(.caption)
                                .italic()
                                .padding(.horizontal, 16)
                                .multilineTextAlignment(.leading)
                            MapView(coordinate: CLLocationCoordinate2D(latitude: detailPlace.latitude, longitude: detailPlace.longitude))
                                .frame(height: 150)
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                        }
                        .onTapGesture {
                            let mapString = "http://maps.apple.com/?q=\(detailPlace.latitude),\(detailPlace.longitude)"
                            if let url = URL(string: mapString) {
                                UIApplication.shared.open(url)
                            }
                        }
                        .padding(.top, 11)
                        .padding(.bottom, 16)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                    }
                    .padding(.bottom,16)
                }
                .padding(.horizontal,25)
                .padding(.bottom, 25)
            }
        }
        .navigationBarTitle("Place Details")
        .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $isShowAddToTripModal) {
            AddToTripListModal(
                place_id: detailPlace.place_id
            )
            .presentationDetents([.height(UIScreen.main.bounds.size.height / 2) , .medium, .large])
            .presentationDragIndicator(.automatic)
        }
        .onAppear{
            checkForPin()
            retrieveAddress()
        }
    }
    
    func checkForPin() {
        let placeIsPinned = DataRepository.shared.isPlacePinned(context: viewContext, placeID: detailPlace.place_id)
        pinIcon = placeIsPinned ? "pin.fill" : "pin"
    }
    
    func retrieveAddress() {
        getAddressFromCoordinates(latitude: detailPlace.latitude, longitude: detailPlace.longitude) { address in
            if let retrievedAddress = address {
                self.address = retrievedAddress
            } else {
                self.address = "Unable to retrieve address."
            }
        }
    }
    
    func getAddressFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            
            // Extract the address components
            let address = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
            
            completion(address)
        }
    }
    
}

struct DetailActivityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailActivityView(detailPlace: PlaceAdapter(place_id: "p1", name: "Bali", description: "Lorem", latitude: 9.29283, longitude: -1.2037972, interest: ["oke", "ok", "u", "o"], images: ["photo.fill","photo","photo.tv"], reviews: [ReviewAdapter(id: "r1", place_id: "p1", name: "toreto", description: "lorem", rating: 5.0)], avg_rating: "5.0", prices: [Prices(id: "c1", place_id: "p1", type: "entry", price: "Rp 100.000")]))
    }
    
}


