//
//  FilterInterestModal.swift
//  Touristic
//
//  Created by masbek mbp-m2 on 26/06/23.
//

import SwiftUI

//let tagList = [
//    TagModel(name: "Hiking"),
//    TagModel(name: "Surfing"),
//    TagModel(name: "Camping"),
//    TagModel(name: "Picnic"),
//    TagModel(name: "Sport"),
//    TagModel(name: "Entertainment"),
//    TagModel(name: "Dancing"),
//    TagModel(name: "Shopping"),
//    TagModel(name: "Healing"),
//    TagModel(name: "Swimming"),
//    TagModel(name: "Spiritual"),
//    TagModel(name: "Cycling"),
//    TagModel(name: "Snorkeling"),
//    TagModel(name: "Diving"),
//    TagModel(name: "Climbing"),
//    TagModel(name: "Recreation"),
//    TagModel(name: "Night Life"),
//    TagModel(name: "Local"),
//    TagModel(name: "Photography"),
//    TagModel(name: "Aquatic Recreation"),
//    TagModel(name: "Culinary"),
//    TagModel(name: "Historical"),
//    TagModel(name: "Gardening")
//]

struct FilterInterestModal: View {
    @Environment(\.dismiss) var dismiss
    @State private var destination : String = ""
    @State private var selectedInterests: [String] = []
    var body: some View {
        NavigationStack() {
            VStack(alignment: .leading) {
                HStack{
                    Text("Destination")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    HStack{
//                        Text("*Active your location")
//                            .font(.caption)
//                            .foregroundColor(.black)
//                        Image(systemName: "paperplane.circle")
//                            .font(.title2)
//                            .onTapGesture {
//                                dismiss()
//                            }
                    }
                    .onTapGesture {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(UIColor.systemGray6))
                    .frame(height:36)
                    .overlay(
                        HStack{
                            TextField("Search Location", text: $destination)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button(action:{
                                dismiss()
                            }){
                                Image(systemName: "paperplane.circle")
                                    .font(.title2)
                            }
                        }
                            .padding(.horizontal,10)
                    )
                
                Text("Interest")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top,25)
                WrappingHStack(models: tagList, viewGenerator: { tag in
                    InterestTagComponent(
                        interest: tag.name,
                        selectedInterests: $selectedInterests
                    )
                })
                .horizontalSpacing(6)
                .verticalSpacing(6)
                
                Spacer()
                
                
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 20)
            //            .navigationTitle("Choose Your Interest")
            .navigationBarTitle("Filter", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action:{
                        dismiss()
                    }){
                        Text("Cancel")
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{
                        
                    }){
                        Text("Done")
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal)
                    }
                    
                }
                
            }
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
        }
    }
}

struct FilterInterestModal_Previews: PreviewProvider {
    static var previews: some View {
        FilterInterestModal()
    }
}

