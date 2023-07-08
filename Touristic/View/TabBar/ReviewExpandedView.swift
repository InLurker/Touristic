//
//  ReviewExpandedView.swift
//  Touristic
//
//  Created by Billy Jefferson on 27/06/23.
//

import SwiftUI

struct ReviewExpandedView: View {
    @State var review : ReviewAdapter
    var body: some View {
        NavigationStack(){
            VStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.systemGray6))
                    .overlay(
                        ScrollView{
                            VStack{
                                HStack{
                                    Text(review.name)
                                    Spacer()
                                    Image(systemName: "star.fill")
                                    Text(String(review.rating))
                                }
                                Spacer()
                                Text(review.description)
                            }
                            .padding(16)
                        }
                    )
            }
            .padding(25)
            .navigationTitle("Review")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct ReviewExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewExpandedView(review: ReviewAdapter(id: "r1", place_id: "p1", name: "toreto", description: "lorem", rating: 5.0))
    }
}
