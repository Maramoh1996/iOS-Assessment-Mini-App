//
//  MainViewController.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 10/08/1445 AH.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    var viewModel = MainViewModel()
    var usersListViewController: UsersListViewController?
    var userName: String = ""
    
    class func instanceFromStoryboard() -> UIViewController? {
        let storyBoard = UIStoryboard.init(name: "MainView", bundle: Bundle.main)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
            return mainViewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureBinding()
    }
    
    func configureBinding() {
        viewModel.onEvent { (event) in
            switch event {
            case .didSuccess:
                DispatchQueue.main.async {
                    self.usersListViewController = UsersListViewController.instanceFromStoryboard() as? UsersListViewController
                    guard let usersListViewController = self.usersListViewController else { return }
                    usersListViewController.getUserListResponse = self.viewModel.getUserListResponse
                    self.navigationController?.pushViewController(usersListViewController, animated: true)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupView() {
        self.view.backgroundColor = .purple
        tableView?.separatorStyle = .none
        tableView?.contentInsetAdjustmentBehavior = .never
        tableView?.isScrollEnabled = false
        tableView?.registerNibCellBundled(ofType: TitleWithButtonCell.self)
    }

}

// TableView Configuration

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleWithButtonCell", for: indexPath) as! TitleWithButtonCell
        cell.onEvent { (event) in
            switch event {
            case .didMessageSent:
                self.showAlertMessage(message: cell.textInput ?? "")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Header Style"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        headerView.backgroundColor = .purple

        let label = UILabel.init(frame: CGRect.init(x: 10, y: 30, width: tableView.frame.size.width, height: 45))
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textAlignment = .left
        label.text = "Hello, \(String(describing: userName))"
        
        let listButton = UIButton.init(frame: CGRect.init(x: 300, y: 40, width: 110, height: 30))
        listButton.setTitleColor(.purple, for: .normal)
        listButton.setTitle("Users list", for: .normal)
        listButton.backgroundColor = .white
        listButton.layer.cornerRadius = 10
        listButton.addTarget(self, action: #selector(showDetail), for: .touchUpInside)

        
        headerView.addSubview(label)
        headerView.addSubview(listButton)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    @objc func showDetail(_ button:UIButton) {
        viewModel.getUsers()
    }
    
    func showAlertMessage(message: String) {
        let alert = UIAlertController(title: "Message Sent", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
