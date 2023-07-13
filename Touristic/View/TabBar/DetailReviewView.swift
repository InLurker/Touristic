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
                        review in
                        NavigationLink(destination: ReviewExpandedView(review: review)){
                            VStack(alignment: .leading){
                                HStack{
                                    Text(review.name)
                                        .fontWeight(.medium)
                                    Spacer()
                                    Image(systemName: "star.fill")
                                    Text(removeTrailingZero(review.rating))
                                }
                                .foregroundColor(.primary)
                                Spacer()
                                Text(review.description)
                                    .lineLimit(reviewExpanded ? nil : 3)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                HStack{
                                    Spacer()
                                    NavigationLink(destination:ReviewExpandedView(review: review)){
                                        Text("more")
                                    }
                                }
                            }
                            .padding(16)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                        }
                        .padding([.top, .leading, .trailing], 25)
                    }
                    .padding(.bottom, 25)
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
