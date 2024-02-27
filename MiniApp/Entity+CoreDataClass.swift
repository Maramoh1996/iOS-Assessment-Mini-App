//
//  Entity+CoreDataClass.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 11/08/1445 AH.
//
//

import Foundation
import UIKit
import CoreData

@objc(Entity)
public class Entity: NSManagedObject {

    static func addCoreData(id: Int, name: String, email: String, gender: String, status: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var newData = UserListResponse(id: id, name: name, email: email, gender: gender, status: status)
        newData.name = name
        newData.id = id
        newData.gender = gender
        newData.email = email
        newData.status = status
        do {
            try context.save()
        } catch {
            print("error-Saving data")
        }
    }
}
