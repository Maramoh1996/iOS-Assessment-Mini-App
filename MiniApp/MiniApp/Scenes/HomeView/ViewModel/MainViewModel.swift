//
//  MainViewModel.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 10/08/1445 AH.
//

import Foundation
import CoreData
import UIKit

class MainViewModel: EventProtocol {
    
    var isSucceed: Bool = false
    var getUserListResponse: [User]?
    var eventBlock: ((Event) -> Void)?
    private let repo = UserRepository()
    
    enum Event {
        case didSuccess
    }
    
    func getUsers() {
        let cacheUsers = CacheManager.shared.retrieveEntities(entity: User.self)
        
        guard cacheUsers.isEmpty else {
            if let eventBlock = self.eventBlock {
                self.getUserListResponse = cacheUsers
                eventBlock(.didSuccess)
            }
            return
        }
        repo.fetchFromApi { users in
            if let eventBlock = self.eventBlock {
                self.getUserListResponse = cacheUsers
                eventBlock(.didSuccess)
            }
        } errorEvent: { error in
            print("")
        }
    }
}
