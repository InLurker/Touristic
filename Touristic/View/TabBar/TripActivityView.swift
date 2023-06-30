//
//  TripActivityView.swift
//  Touristic
//
//  Created by Billy Jefferson on 26/06/23.
//

import SwiftUI

struct TripActivityView: View {
    @ObservedObject private var ActivityCount = TripActivitySet.activityShared
    @State private var opacityChanged = 0.0
    @State private var isBouncing = false
    var body: some View {
        NavigationStack(){
            VStack{
                ZStack{
                    if  ActivityCount.tripActivity.count < 1{
                        Text("You don’t have any pinned Activites yet")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(maxHeight: .infinity)
                        HStack{
                            VStack{
                                Spacer()
                                Text("Click Here to Explore")
                                    .padding(.all)
                                Image(systemName: "arrow.down")
                                    .font(.custom("", size: 40))
                            }
                            .opacity(opacityChanged)
                            .scaleEffect(isBouncing ? 1.2 : 1.0)
                            .frame(width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.size.height / 8 * 4.5)
                            Spacer()
                        }
                        .onAppear{
                            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()){
                                self.opacityChanged = 1.0
                                self.isBouncing = true
                            }
                        }
                    }
                    else{
                        ForEach(ActivityCount.tripActivity, id: \.self){activities in 
                            NavigationLink(destination: TripActivityView()){
                                Text("\(activities)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Trip 1")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct TripActivityView_Previews: PreviewProvider {
    static var previews: some View {
        TripActivityView()
    }
}
