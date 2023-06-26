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
    var body: some View {
        NavigationStack(){
            VStack{
                Text("You don’t have any pinned explore yet.\nAdd by click '+' icon in the right top corner.")
                    .multilineTextAlignment(.center)
            }
            .navigationTitle("Pinned")
            .toolbar{
                Button(action:{
                    isShowingModalNewTrip = true
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
