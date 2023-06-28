//
//  PlacesCardView.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-26.
//

import SwiftUI

struct PlacesCardView: View {
    var interests : [String] = ["yaya", "okeo"]
    var name : String = ""
    var images : [String] = [""]
    @State var clicked = true
    @State var pinIcon = "pin"
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                HStack(alignment: .center){
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
                    Text("4.7")
                        .lineLimit(1)
                        .font(.footnote)
                        .bold()
                    Button(
                        action:{
                            clicked = !clicked
                            pinIcon = clicked ? "pin" : "pin.fill"
                        })
                    {
                        Image(systemName: pinIcon)
                            .foregroundColor(.blue)
                    }
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
                AsyncImage(url: URL(string: images[0])) { phase in
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
                AsyncImage(url: URL(string: images[0])) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height)
                            .blur(radius: 4.0)
                            .cornerRadius(10)
                            .opacity(0.4)
                            .clipped()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height)
                            .blur(radius: 4.0)
                            .cornerRadius(10)
                            .opacity(0.4)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height)
                            .cornerRadius(10)
                            .opacity(0.4)
                            .clipped()
                    @unknown default:
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
    }
}

struct PlacesCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesCardView()
            .frame(height: 180)
    }
}
