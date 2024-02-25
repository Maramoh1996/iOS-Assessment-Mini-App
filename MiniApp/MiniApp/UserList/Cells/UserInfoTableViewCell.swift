//
//  UserInfoTableViewCell.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 10/08/1445 AH.
//

import Foundation
import UIKit

public class UserInfoTableViewCell: UITableViewCell {
    
    @IBOutlet public weak var userNameLabel: UILabel?
    @IBOutlet public weak var userEmailLabel: UILabel?
    @IBOutlet public weak var userStatusLabel: UILabel?
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    func setupCell() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        userNameLabel?.textColor = .black
        userNameLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        userEmailLabel?.textColor = .gray
        userEmailLabel?.font = UIFont.systemFont(ofSize: 10)
        userStatusLabel?.font = UIFont.systemFont(ofSize: 10)
    }
    
    func setupData(userResponse: UserListResponse) {
        userNameLabel?.text = userResponse.name
        userEmailLabel?.text = userResponse.email
        userStatusLabel?.text = userResponse.status
    }
    
    func setupColors(userResponse: UserListResponse) -> UIColor {
        return userResponse.status == "active" ? .green : .gray
    }
}
