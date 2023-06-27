//
//  PlacesCardView.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-26.
//

import SwiftUI

struct PlacesCardView: View {
    let interests = ["Picnic", "Local", "Spiritual"]
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                HStack(alignment: .center){
                    Text("Place name")
                        .lineLimit(1)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            height: 13
                        )
                    Text("4.7")
                        .lineLimit(1)
                        .font(.footnote)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 13)
                .padding(.horizontal, 9)
                Text(interests.joined(separator: " · "))
                    .lineLimit(1)
                    .font(.caption)
                    .padding(.horizontal, 9)
                    .padding(.bottom, 5)
                Spacer()
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
            .padding(5)
            GeometryReader { geometry in
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: geometry.size.height)
                    .cornerRadius(10)
                    .opacity(0.4)
                    .clipped()
            }
        }
    }
}

struct PlacesCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesCardView()
            .frame(height: 180)
    }
}
