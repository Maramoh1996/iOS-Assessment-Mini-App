//
//  Entity+CoreDataProperties.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 11/08/1445 AH.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: NSObject?
    @NSManaged public var name: NSObject?
    @NSManaged public var gender: NSObject?
    @NSManaged public var email: NSObject?
    @NSManaged public var status: NSObject?

}

extension Entity : Identifiable {

}
