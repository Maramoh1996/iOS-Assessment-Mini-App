//
//  UserMapping.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 19/08/1445 AH.
//

import Foundation
import CoreData

struct UserMapper {

    func map(response: UserResponse, context: NSManagedObjectContext) -> User {
        let user = User(context: context)
        user.name = response.name
        user.email = response.email
        user.gender = response.gender
        user.status = response.status
        return user
    }
}
