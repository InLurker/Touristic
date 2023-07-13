//
//  TripThumbnail.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-07-13.
//

import CoreData

extension Trip {
    @objc var derivedThumbnail: String? {
        guard let context = managedObjectContext else {
            return nil
        }
        
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trip == %@", self)
        fetchRequest.fetchLimit = 1
        
        do {
            let places = try context.fetch(fetchRequest)
            return places.first?.thumbnail
        } catch {
            print("Error fetching place: \(error)")
            return nil
        }
    }
}
