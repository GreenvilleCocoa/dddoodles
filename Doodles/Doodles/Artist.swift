//
//  Artist.swift
//  
//
//  Created by Marcus Smith on 5/12/15.
//
//

import Foundation
import CoreData

class Artist: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var doodles: Doodle

}
