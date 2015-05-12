//
//  DoodleExtension.swift
//  Doodles
//
//  Created by Marcus Smith on 5/12/15.
//
//

import Foundation
import CoreData

let doodleEntityName = "Doodle"

extension Doodle {
    
    class func newDoodle() -> Doodle {
        return NSEntityDescription.insertNewObjectForEntityForName(doodleEntityName, inManagedObjectContext: CoreDataStack.sharedInstance.managedObjectContext!) as! Doodle
    }
    
    class func doodlesMatching(string: String) -> [Doodle] {
        let fetchRequest = NSFetchRequest(entityName: doodleEntityName);
        
        let predicate = NSPredicate(format: "doodleName CONTAINS[cd] %@ OR artist.firstName CONTAINS[cd] %@ OR artist.lastName CONTAINS[cd] %@", string, string, string)
        fetchRequest.predicate = predicate
        
        let searchDescriptor = NSSortDescriptor(key: "doodleName", ascending: true)
        fetchRequest.sortDescriptors = [searchDescriptor]
        
        return CoreDataStack.sharedInstance.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Doodle] ?? []
    }
    
    class func allDoodles() -> [Doodle] {
        let fetchRequest = NSFetchRequest(entityName: doodleEntityName)
        
        let predicate = NSPredicate(format: "TRUEPREDICATE")
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