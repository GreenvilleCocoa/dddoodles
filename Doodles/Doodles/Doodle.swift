//
//  Doodle.swift
//  
//
//  Created by Marcus Smith on 5/12/15.
//
//

import Foundation
import CoreData

class Doodle: NSManagedObject {

    @NSManaged var doodleName: String
    @NSManaged var image: NSData
    @NSManaged var likes: NSNumber
    @NSManaged var artist: Artist

}
