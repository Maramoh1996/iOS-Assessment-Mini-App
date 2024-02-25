//
//  LoginViewModel.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 09/08/1445 AH.
//

import Foundation
import UIKit

class LoginViewModel {
    
    enum CellType {
        case welcomeTitle
        case userField
        case passwordField
        case loginButton
    }
    
    var cellType: [CellType] = [.welcomeTitle,
                                .userField,
                                .passwordField,
                                .loginButton]
    
    
    
//    func configureWelcomeTitleCell(tableView: UITableView) -> UITableViewCell {
//            let cell = UITableViewCell()
//            cell.backgroundColor = .clear
//            cell.selectionStyle = .none
//            cell.isUserInteractionEnabled = true
//            cell.contentView.isUserInteractionEnabled = true
//            cell.addSubview(titleAndSubTitleView)
//
//            titleAndSubTitleView.setConstrint([.all(0), .leading(-10)])
//
//            titleAndSubTitleView.titleLabel?.text = selectedMainCategory?.title
//            titleAndSubTitleView.subTitleLabel?.text = selectedMainCategory?.description
//
//            return cell
//        }
    
}
