//
//  UsersListViewController.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 10/08/1445 AH.
//

import Foundation
import UIKit


class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?

    var viewModel: MainViewModel?
    var getUserListResponse: [User]?

    
    class func instanceFromStoryboard() -> UIViewController? {
        let storyBoard = UIStoryboard.init(name: "UsersList", bundle: Bundle.main)
            let usersListViewController = storyBoard.instantiateViewController(withIdentifier: "UsersListViewController") as? UsersListViewController
            return usersListViewController
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Users"
    }

    
    func setupView() {
        self.view.backgroundColor = .white
        tableView?.registerNibCellBundled(ofType: UserInfoTableViewCell.self)
    }
}

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getUserListResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as! UserInfoTableViewCell
        
        guard let userList = getUserListResponse?[indexPath.row] else { return UITableViewCell() }
        cell.setupData(userResponse: userList)
        cell.userStatusLabel?.textColor = cell.setupColors(userResponse: userList)
        return cell
    }
}

extension UITableView {
    func registerNibCellBundled<T: UITableViewCell>(ofType cellType: T.Type, reuseIdentifier: String? = nil) {
            let identifier: String = reuseIdentifier ?? "\(cellType)"
            let nib = UINib(nibName: identifier, bundle: Bundle(for: cellType))
            register(nib, forCellReuseIdentifier: identifier)
        }
}
