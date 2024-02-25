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
    
    func saveLoginDataToCoreData(data: UserListResponse){
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDel.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LoginInfo", in: context)!
        let mngdObj = NSManagedObject(entity: entity, insertInto: context)
        
        mngdObj.setValue(data.name, forKeyPath: "name")
        mngdObj.setValue(data.id, forKeyPath: "id")
        mngdObj.setValue(data.email, forKeyPath: "email")
        mngdObj.setValue(data.gender, forKeyPath: "gender")
        mngdObj.setValue(data.status, forKeyPath: "status")
        
        // Add all loginData here...
        
        do {
            try context.save(); print("LoginData has been saved to CoreData")
        } catch {
            print("An error has occurred: \(error.localizedDescription)")
        }
    }
    
    
}
