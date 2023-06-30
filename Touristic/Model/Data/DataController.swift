import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TripsData")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
