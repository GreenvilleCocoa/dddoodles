//
//  ArtistExtension.swift
//  Doodles
//
//  Created by Marcus Smith on 5/12/15.
//
//

import Foundation
import CoreData

extension Artist {
    
    static let entityName = "Artist"
    
    class func newArtist() -> Artist {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: CoreDataStack.sharedInstance.managedObjectContext!) as! Artist
    }
    
    class func artistWith(firstName: String, lastName: String) -> Artist? {
        let fetchRequest = NSFetchRequest(entityName: entityName);
        
        let predicate = NSPredicate(format: "firstName == %@ AND lastName == %@", firstName, lastName)
        fetchRequest.predicate = predicate
        
        if let artist = CoreDataStack.sharedInstance.managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)?.first as? Artist {
            return artist
        }
        
        let newArtist = self.newArtist()
        newArtist.firstName = firstName
        newArtist.lastName = lastName
        
        return newArtist
    }
}