//
//  ContentView.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-22.
//

import SwiftUI

struct PinnedView: View {
    @State private var searchText = ""
    @State private var isShowingModalNewTrip = false
    @ObservedObject private var TripList = TripNameSet.shared
    var body: some View {
        NavigationStack(){
            VStack{
                if TripList.tripNameSet.count < 1{
                    Text("You don’t have any pinned explore yet.\nAdd by click '+' icon in the right top corner.")
                        .multilineTextAlignment(.center)
                }
                else{
                    ScrollView{
                        ForEach(TripList.tripNameSet, id: \.self){trips in
                            NavigationLink(destination: TripActivityView()){
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(UIColor.systemGray6))
                                    .frame(height: 81)
                                    .overlay(
                                        HStack{
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width:59,height: 59)
                                                .foregroundColor(.white)
                                            
                                            VStack(alignment:.leading){
                                                Text("\(trips)")
                                                Text("0 Activty")
                                            }
                                            .padding(.horizontal,10)
                                            Spacer()
                                        }
                                        .padding(.horizontal,10)
                                    )
                                    .padding(.horizontal,25)
                                    .padding(.top,14)
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
            }
            .navigationTitle("Pinned")
            .toolbar{
                Button(action:{
                    isShowingModalNewTrip = true
                    print(TripList)
                },label:{
                    Image(systemName: "plus")
                        .font(.custom("", size: 25))
                        .foregroundColor(Color.accentColor)
                        .padding(.horizontal)
                })
                .sheet(isPresented: $isShowingModalNewTrip) {
                    NewTripView()
                        .presentationDetents([.height(UIScreen.main.bounds.size.height / 2) , .medium, .large])
                        .presentationDragIndicator(.automatic)
                }
            }
            .searchable(text: $searchText, prompt: "Trip Name")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PinnedView()
    }
}
