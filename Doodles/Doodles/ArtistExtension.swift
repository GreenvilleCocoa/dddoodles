//
//  ArtistExtension.swift
//  Doodles
//
//  Created by Marcus Smith on 5/12/15.
//
//

import Foundation
import CoreData

let artistEntityName = "Artist"

extension Artist {
    
    class func newArtist() -> Artist {
        return NSEntityDescription.insertNewObjectForEntityForName(artistEntityName, inManagedObjectContext: CoreDataStack.sharedInstance.managedObjectContext!) as! Artist
    }
    
    class func artistWith(firstName: String, lastName: String) -> Artist {
        let fetchRequest = NSFetchRequest(entityName: artistEntityName);
        
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
    
    class func allArtists() -> [Artist] {
        let fetchRequest = NSFetchRequest(entityName: artistEntityName)
        
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        fetchRequest.predicate = predicate
        
        let firstNameDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        let lastNameDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
        fetchRequest.sortDescriptors = [firstNameDescriptor, lastNameDescriptor]
        
        return CoreDataStack.sharedInstance.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Artist] ?? []
    }
}