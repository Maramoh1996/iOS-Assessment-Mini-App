//
//  GetUserListResponse.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 10/08/1445 AH.
//

import Foundation

public struct UsersListResponse: Codable {
    public var data: [UserListResponse]
}

public struct UserListResponse: Codable {
    public var id: Int?
    public var name: String?
    public var email: String?
    public var gender: String?
    public var status: String?
}
