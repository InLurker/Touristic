//
//  DetailActivityView.swift
//  Touristic
//
//  Created by Billy Jefferson on 26/06/23.
//

import SwiftUI
import MapKit

struct DetailActivityView: View {
    @State private var isExpanded = false
    @State private var reviewExpanded = false
    @State private var CarouselItems = ["photo.fill","photo","photo.tv"]
    @State private var CarouselCounter = 0
    @State private var carouselColor: Color = .black
    var body: some View {
        NavigationStack(){
            VStack{
                ScrollView{
                    VStack{
                        TabView {
                            ForEach(0..<CarouselItems.count, id: \.self) { index in
                                Image(systemName: CarouselItems[index])
                                    .resizable()
                                    .scaledToFill()
                            }
                        }.tabViewStyle(PageTabViewStyle())
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .frame(height: 310)
                        VStack{
                            HStack{
                                Text("Pura Ulun Danu Bratan")
                                Spacer()
                                Image(systemName: "pin")
                            }
                            .frame(maxWidth: .infinity)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom,7)
                            Text("Administratively, Ulun Danu Beratan Temple is located at Candikuning Village, Baturiti Subdistrict, Tabanan regency in Bali, Indonesia. The temple is located at the heart of Bali Island., approximately 50 kms to the north from Denpasar, by the main street connecting Denpasar and Singaraja.\n\nUlun Danu Beratan Temple is one of nine “Kahyangan Jagat Temple” which are surrounding Bali Island, that makes it become one of the most important Temple for the Balinese, especially for Hindu.\n\nThere are of five compounds of temples and one Buddhist Stupa, such as: Penataran Agung, Prajapati, Dalem Purwa, Taman Beji, Lingga Petak, Buddhist Stupa")
                                .lineLimit(isExpanded ? nil : 3)
                                .fixedSize(horizontal: false, vertical: true)
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    isExpanded.toggle()
                                }) {
                                    Text(isExpanded ? "Less" : "More")
                                        .foregroundColor(.blue)
                                }
                            }
                            VStack{
                                HStack{
                                    Text("Price")
                                        .padding(.bottom,7)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .font(.title2)
                                .fontWeight(.bold)
                                HStack{
                                    Image(systemName: "figure.walk")
                                        .foregroundColor(.yellow)
                                        .padding(.horizontal,24)
                                    Text("Adult : Rp. 30.000")
                                    Spacer()
                                }
                                HStack{
                                    Image(systemName: "figure.walk")
                                        .font(.custom("", size: 10))
                                        .foregroundColor(.red)
                                        .padding(.horizontal,27)
                                    Text("Adult : Rp. 20.000")
                                    Spacer()
                                }
                            }
                            .padding(.bottom,25)
                            VStack{
                                HStack{
                                    Text("Activities")
                                        .padding(.bottom,7)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .font(.title2)
                                .fontWeight(.bold)
                                HStack{
                                    Image(systemName: "pin")
                                    Text("Activity")
                                    Spacer()
                                    Image(systemName: "pin")
                                    Text("Activity")
                                    Spacer()
                                }
                                .padding(.bottom,16)
                                HStack{
                                    Image(systemName: "pin")
                                    Text("Activity")
                                    Spacer()
                                    Image(systemName: "pin")
                                    Text("Activity")
                                    Spacer()
                                }
                            }
                            .padding(.bottom,25)
                            VStack{
                                HStack{
                                    Text("Review")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text("5.0")
                                    Spacer()
                                    NavigationLink(destination:DetailReviewView()){
                                        Text("See All")
                                    }
                                }
                                .padding(.bottom,7)
                                .frame(maxWidth: .infinity)
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 113)
                                    .foregroundColor(Color(UIColor.systemGray6))
                                    .overlay(
                                        VStack{
                                            HStack{
                                                Text("Name")
                                                Spacer()
                                                Image(systemName: "star.fill")
                                                Text("5")
                                            }
                                            Spacer()
                                            Text("Bedugul Temple or Ulun Danu Temple with Lake Beratan/nTheres a floating temple, very pretty. Surrounded by a Beautiful lake, many photo spots, flowers & greeneries. It has a Bali gate too where you can wear traditional clothes & click but they need to be paid separately./nIts a big place & you can walk around. It had a very peaceful, calm vibe to it. We liked it./nIn Bali, always try to combine multiple places in the same area so you are able to use the same vehicle to come & go and also finish the whole stretch./nThere are photographers who will click your photo, print & give to you in a frame for a fee./nSo the main temple is locked & can’t enter it. As our guide told us that Bali temples work with a community / caste only system. And even he has an assigned temple that his family goes to. And some temples opens only during special days for their community itself. So only selective group of people are allowed in different temples. So every temple you go to, you are allowed only on the exterior part & not where the main gods are./nI believe theres a parking fee & an entry fee. There are clean paid toilets in almost all the tourist places.")
                                                .lineLimit(reviewExpanded ? nil : 3)
                                            HStack{
                                                Spacer()
                                                NavigationLink(destination:ReviewExpandedView()){
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
                                            MapView(coordinate: CLLocationCoordinate2D(latitude: -8.2760, longitude: 115.1628))
                                                .frame(height: 150)
                                                .cornerRadius(10)
                                        }
                                    )
                            }
                            
                        }
                        .padding(.horizontal,25)
                    }
                }
            }
            .navigationTitle("Detail")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct DetailActivityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailActivityView()
    }
}


