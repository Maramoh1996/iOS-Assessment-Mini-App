//
//  UserRepository.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 19/08/1445 AH.
//

import Foundation
import CoreData
import UIKit

class UserRepository {
    
    func fetchFromApi(successEvent: (([User]) -> Void)?, errorEvent: ((Error) -> Void)?) {
        guard let url = URL(string: "https://gorest.co.in/public-api/users") else { return }
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GetUsersResponse.self, from: data)
               
                CacheManager.shared.clearStorage(for: User.self)
                
                let users = response.data.compactMap { data in
                    return UserMapper().map(response: data, context: CacheManager.shared.context)
                }
              
                CacheManager.shared.saveContext()
                successEvent?(users)

            } catch let error {
                errorEvent?(error)
            }
        }.resume()
    }
}
