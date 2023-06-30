//
//  Repository.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-28.
//

import Foundation
import CoreData



class DataRepository {
    
    static let shared = DataRepository()
    
    func createTrip(context: NSManagedObjectContext, tripName: String) -> Bool {
        let trip = Trip(context: context)
        trip.name = tripName
        
        do {
            try context.save()
            return true
        } catch {
            print("Error saving trip: \(error.localizedDescription)")
            return false
        }
    }
    
    func removeTrip(context: NSManagedObjectContext, trip: Trip) -> Bool {
        context.delete(trip)
        
        do {
            try context.save()
            return true
        } catch {
            print("Error removing trip: \(error.localizedDescription)")
            return false
        }
    }
    
    func addPlaceToTrip(context: NSManagedObjectContext, trip: Trip, placeID: String) -> Bool {
        let place = Place(context: context)
        place.place_id = placeID
        
        trip.addToPlaces(place)
        do {
            try context.save()
            return true
        } catch {
            print("Error adding place to trip: \(error.localizedDescription)")
            return false
        }
    }
    
    func removePlaceFromTrip(context: NSManagedObjectContext, trip: Trip, placeID: String) -> Bool {
        guard let places = trip.places as? Set<Place> else {
            print("Error removing place from trip: Invalid places set")
            return false
        }
        
        if let placeToRemove = places.first(where: { $0.place_id == placeID }) {
            trip.removeFromPlaces(placeToRemove)
            context.delete(placeToRemove)
            
            do {
                try context.save()
                return true
            } catch {
                print("Error removing place from trip: \(error.localizedDescription)")
            }
        } else {
            print("Error removing place from trip: Place not found")
        }
        
        return false
    }
    
    func isPlaceInTrip(context: NSManagedObjectContext, trip: Trip, placeID: String) -> Bool {
        guard let places = trip.places as? Set<Place> else {
            print("Error checking place in trip: Invalid places set")
            return false
        }
        
        return places.contains { $0.place_id == placeID }
    }
    
    func isPlacePinned(context: NSManagedObjectContext, placeID: String) -> Bool {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "place_id == %@", placeID)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking if place is pinned: \(error.localizedDescription)")
            return false
        }
    }
}
