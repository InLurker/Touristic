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
                        Text("*Active your location")
                            .font(.caption)
                        Image(systemName: "mappin.and.ellipse")
                            .onTapGesture {
                                dismiss()
                            }
                    }
                    .foregroundColor(.blue)
                }
                
                TextField("Search Location", text: $destination)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                Text("Interest")
                    .font(.title2)
                    .fontWeight(.bold)
                
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

