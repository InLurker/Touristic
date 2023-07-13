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
            ScrollView {
                VStack(alignment: .leading){
                    HStack{
                        Text(review.name)
                            .bold()
                        Spacer()
                        Image(systemName: "star.fill")
                        Text(String(removeTrailingZero(review.rating)))
                    }
                    Spacer()
                    Text(review.description)
                        .multilineTextAlignment(.leading)
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
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
