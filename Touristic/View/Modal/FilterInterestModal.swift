//
//  FilterInterestModal.swift
//  Touristic
//
//  Created by masbek mbp-m2 on 26/06/23.
//

import SwiftUI

struct FilterInterestModal: View {
    @StateObject private var selectedInterestData = SelectedInterestData.shared
    @Binding var selectedInterests: [String]
    
    @State private var temporarySelectedInterests: [String]
    
    @Environment(\.dismiss) var dismiss
    @State private var destination : String = ""
    
    init(selectedInterests: Binding<[String]> = .init(
        get: { SelectedInterestData.shared.selectedInterests },
        set: { SelectedInterestData.shared.selectedInterests = $0 }
    )) {
        _selectedInterests = selectedInterests
        _temporarySelectedInterests = State(initialValue: selectedInterests.wrappedValue)
    }
    
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
                    .onTapGesture {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
                
                TextField("Search Location", text: $destination)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                Text("Interest")
                    .font(.title2)
                    .fontWeight(.bold)
                
                WrappingHStack(models: Array(interestDict.keys).sorted(), viewGenerator: { interest in
                    InterestTagComponent(
                        interestID: interest,
                        selectedInterests: $temporarySelectedInterests
                    )
                })
                .horizontalSpacing(6)
                .verticalSpacing(6)
                Spacer()
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 20)
            .navigationBarTitle("Filter", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        onCancel()
                    }){
                        Text("Cancel")
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        onDone()
                    }) {
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
    
    func onDone() {
        selectedInterests = temporarySelectedInterests
        selectedInterestData.selectedInterests = temporarySelectedInterests
        selectedInterestData.saveSelectedInterests()
        
        dismiss()
    }
    
    func onCancel() {
        temporarySelectedInterests = selectedInterests
        
        dismiss()
    }
}

struct FilterInterestModal_Previews: PreviewProvider {
    static var previews: some View {
        FilterInterestModal()
    }
}
