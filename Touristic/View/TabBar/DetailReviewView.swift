//
//  DetailReviewView.swift
//  Touristic
//
//  Created by Billy Jefferson on 26/06/23.
//

import SwiftUI

struct DetailReviewView: View {
//    @ObservedObject private var reviewListing = ListReview.list
    
    @State var reviews : [ReviewAdapter]
    @State private var reviewExpanded = false
    var body: some View {
        NavigationStack(){
            VStack{
                ScrollView{
                    ForEach(reviews, id: \.id){
                        comments in
                        NavigationLink(destination: TripActivityView()){
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 113)
                                .foregroundColor(Color(UIColor.systemGray6))
                                .overlay(
                                    VStack{
                                        HStack{
                                            Text("\(comments.name)")
                                            Spacer()
                                            Image(systemName: "star.fill")
                                            Text("\(removeTrailingZero(review.rating))")
                                        }
                                        .foregroundColor(.black)
                                        Spacer()
                                        Text("Bedugul Temple or Ulun Danu Temple with Lake Beratan/nTheres a floating temple, very pretty. Surrounded by a Beautiful lake, many photo spots, flowers & greeneries. It has a Bali gate too where you can wear traditional clothes & click but they need to be paid separately./nIts a big place & you can walk around. It had a very peaceful, calm vibe to it. We liked it./nIn Bali, always try to combine multiple places in the same area so you are able to use the same vehicle to come & go and also finish the whole stretch./nThere are photographers who will click your photo, print & give to you in a frame for a fee./nSo the main temple is locked & can’t enter it. As our guide told us that Bali temples work with a community / caste only system. And even he has an assigned temple that his family goes to. And some temples opens only during special days for their community itself. So only selective group of people are allowed in different temples. So every temple you go to, you are allowed only on the exterior part & not where the main gods are./nI believe theres a parking fee & an entry fee. There are clean paid toilets in almost all the tourist places.")
                                            .lineLimit(reviewExpanded ? nil : 3)
                                            .foregroundColor(.black)
                                        HStack{
                                            Spacer()
                                            NavigationLink(destination:ReviewExpandedView(review: comments )){
                                                Text("more")
                                            }
                                        }
                                    }
                                        .padding(16)
                                )
                                .padding([.top, .leading, .trailing], 25)
                        }
                    }
//                    .padding(25)
                }
            }
            .navigationTitle("Review")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct DetailReviewView_Previews: PreviewProvider {
    static var previews: some View {
        DetailReviewView(reviews: [ReviewAdapter(id: "r1", place_id: "p1", name: "toreto", description: "lorem", rating: 5.0)])
    }
}
