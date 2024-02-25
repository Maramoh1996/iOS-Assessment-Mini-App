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
    var getUserListResponse: [UserListResponse]?
    var eventBlock: ((Event) -> Void)?
    
    enum Event {
        case didSuccess([UserListResponse]?)
    }
    
    func getUsers() {
        let url = URL(string: "https://gorest.co.in/public-api/users")!
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else { return }
            do {
                let jsonData = try JSONDecoder().decode(UsersListResponse.self, from: data)
                self.getUserListResponse = jsonData.data
                if let eventBlock = self.eventBlock {
                    eventBlock(.didSuccess(self.getUserListResponse))
                }
            } catch let error {
                print("failed to decode json:", error)
            }
        }.resume()
    }
}
