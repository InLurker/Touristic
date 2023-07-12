//
//  PlacesCardView.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-26.
//

import SwiftUI

struct PlacesCardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    init (place: PlaceAdapter) {
        self.placeID = place.place_id
        self.interests = place.interest
        self.name = place.name
        self.images = place.images
        self.averageRating = place.avg_rating
    }
    var placeID : String
    var interests : [String] = []
    var name : String = ""
    var images : [String] = [""]
    var averageRating: String
    @State var pinIcon = "pin"
    @State var isShowAddToTripModal = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("\(name)")
                        .lineLimit(1)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            height: 13
                        )
                    Text(averageRating)
                        .lineLimit(1)
                        .font(.footnote)
                        .bold()
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
                .padding(.top, 13)
                .padding(.horizontal, 9)
                
                Text(interests.compactMap { interestDict[$0]?.capitalized }.joined(separator: " · "))
                    .lineLimit(1)
                    .font(.caption)
                    .padding(.horizontal, 9)
                    .padding(.bottom, 5)
                Spacer()
                AsyncImage(url: URL(string: images.first ?? "")) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                height: 120,
                                alignment: .center
                            )
                            .clipped()
                            .cornerRadius(10)
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                height: 120,
                                alignment: .center
                            )
                            .cornerRadius(10)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                height: 120,
                                alignment: .center
                            )
                            .cornerRadius(10)
                            .clipped()
                    @unknown default:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                height: 120,
                                alignment: .center
                            )
                            .cornerRadius(10)
                            .clipped()
                    }
                }
            }
            .padding(5)
            GeometryReader { geometry in
                AsyncImage(url: URL(string: images.first ?? "")) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height)
                            .blur(radius: 18.0)
                            .cornerRadius(10)
                            .opacity(0.4)
                            .clipped()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height)
                            .frame(width: geometry.size.width)
                            .blur(radius: 18.0)
                            .cornerRadius(10)
                            .opacity(0.4)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height)
                            .blur(radius: 18.0)
                            .cornerRadius(10)
                            .opacity(0.4)
                            .clipped()
                    @unknown default:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height)
                            .blur(radius: 18.0)
                            .cornerRadius(10)
                            .opacity(0.4)
                            .clipped()
                        
                    }
                }
            }
        }
        .sheet(isPresented: $isShowAddToTripModal) {
            AddToTripListModal(
                place_id: placeID
            )
            .presentationDetents([.height(UIScreen.main.bounds.size.height / 2) , .medium, .large])
            .presentationDragIndicator(.automatic)
        }
        .onAppear{
            checkForPin()
        }
    }
    
    func checkForPin() {
        let placeIsPinned = DataRepository.shared.isPlacePinned(context: viewContext, placeID: placeID)
        pinIcon = placeIsPinned ? "pin.fill" : "pin"
    }
}
