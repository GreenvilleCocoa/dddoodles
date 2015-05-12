//
//  DoodleExtension.swift
//  Doodles
//
//  Created by Marcus Smith on 5/12/15.
//
//

import Foundation
import CoreData

extension Doodle {
    
    static let entityName = "Doodle"
    
    class func newDoodle() -> Doodle {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: CoreDataStack.sharedInstance.managedObjectContext!) as! Doodle
    }
    
    class func doodlesMatchingString(searchString: String) -> [Doodle] {
        let fetchRequest = NSFetchRequest(entityName: entityName);
        
        let predicate = NSPredicate(format: "doodleName CONTAINS[cd] %@ OR artist.firstName CONTAINS[cd] %@ OR artist.lastName CONTAINS[cd] %@", searchString, searchString, searchString)
        fetchRequest.predicate = predicate
        
        let searchDescriptor = NSSortDescriptor(key: "doodleName", ascending: true)
        fetchRequest.sortDescriptors = [searchDescriptor]
        
        return CoreDataStack.sharedInstance.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Doodle] ?? []
    }
    
    func like() {
        likes = NSNumber(integer: Int(likes) + 1)
        
        CoreDataStack.sharedInstance.saveContext()
    }
}