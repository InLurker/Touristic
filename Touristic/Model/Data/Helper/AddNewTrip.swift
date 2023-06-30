//
//  AddNewTrip.swift
//  Touristic
//
//  Created by masbek mbp-m2 on 30/06/

import CoreData


func addNewTrip(
    context: NSManagedObjectContext,
    tripName: String
) {
    let success = DataRepository.shared.createTrip(
        context: context,
        tripName: tripName
    )
    if success {
        print("Added " + tripName)
    }
}
