//
//  AddToTripListModal.swift
//  Touristic
//
//  Created by masbek mbp-m2 on 30/06/23.
//

import SwiftUI

struct AddToTripListModal: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var TripName = ""
    private var TripList = TripNameSet.shared
    @State private var isShowingNewTripModal = false
    
    @State private var items: [Item] = [
        Item(name: "Item 1", isChecked: false),
        Item(name: "Item 2", isChecked: false),
        Item(name: "Item 3", isChecked: false)
    ]
    var body: some View {
        NavigationStack{
            VStack {
                
                Capsule()
                    .fill(Color.accentColor) // Choose the desired background color
                    .frame(height: 40) // Adjust the height as needed
                    
                    .overlay(
                        Button(action: {
                            TripList.tripNameSet.append(TripName)
                            isShowingNewTripModal = true
//                            print(TripList)
//                            dismiss()
                        }) {
                            HStack {
                                Spacer()
                                Text("Add New Trip!")
                                    .foregroundColor(.white) // Set the text color
                                Spacer()
                            }
                        }
                    )
                    .padding(.horizontal)
                    

                ForEach(items.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .clipped()
                        
                        VStack(alignment: .leading) {
                            Text(items[index].name)
                            Text("0 Activity")
                        }
                        .padding(.horizontal, 10)
                        
                        Spacer()
                        
                        RoundedCheckbox(isChecked: $items[index].isChecked)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                
                
            }
            .navigationBarTitle("Add To", displayMode: .inline)
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
                        dismiss()
                        
                    }){
                        Text("Done")
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal)
                    }
                    
                }
                
            }
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $isShowingNewTripModal) {
                NewTripModal(
                    onCreateTrip: { tripName in
                        addNewTrip(
                            context: viewContext,
                            tripName: tripName)
                    })
                    .presentationDetents([.height(UIScreen.main.bounds.size.height / 2) , .medium, .large])
                    .presentationDragIndicator(.automatic)
            }

        }
    }
    
}

struct RoundedCheckbox: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
                .frame(width: 24, height: 24)
            
            if isChecked {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .onTapGesture {
            isChecked.toggle()
        }
    }
}
struct Item: Identifiable {
    let id = UUID()
    let name: String
    var isChecked: Bool
}

struct AddToTripListModal_Previews: PreviewProvider {
    static var previews: some View {
        AddToTripListModal()
    }
}
