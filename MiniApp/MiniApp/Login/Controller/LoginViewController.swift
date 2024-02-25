//
//  ViewController.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 08/08/1445 AH.
//

import UIKit
import Security


class LoginViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel?
    @IBOutlet weak var userNameField: UITextField?
    @IBOutlet weak var passwordField: UITextField?
    @IBOutlet weak var loginButton: UIButton?
         
    var mainViewController: MainViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        welcomeLabel?.text = "Hello,"
        welcomeLabel?.textColor = .purple
        welcomeLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        userNameField?.layer.cornerRadius = 10
        userNameField?.layer.borderWidth = 0.5
        userNameField?.layer.borderColor = UIColor.gray.cgColor
        userNameField?.resignFirstResponder()
        userNameField?.placeholder = "User name"
        
        passwordField?.layer.cornerRadius = 10
        passwordField?.layer.borderWidth = 0.5
        passwordField?.layer.borderColor = UIColor.gray.cgColor
        passwordField?.isSecureTextEntry = true
        passwordField?.placeholder = "Password"
        
        loginButton?.layer.cornerRadius = 10
        loginButton?.backgroundColor = .purple
        loginButton?.setTitle("Login", for: .normal)
        loginButton?.setTitleColor(.white, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
        
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let userName = userNameField?.text else { return }
        
        self.mainViewController = MainViewController.instanceFromStoryboard() as? MainViewController
        guard let mainViewController = self.mainViewController else { return }
        mainViewController.userName = userName
        self.navigationController?.pushViewController(mainViewController, animated: true)
        saveUserNameAndPasswordToKeyChain()
    }
        
    
    func saveUserNameAndPasswordToKeyChain() {
        guard let userName = userNameField?.text else { return }
        guard let password = passwordField?.text else { return }
        let pass = password.data(using: .utf8)!
        
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: userName,
            kSecValueData as String: pass,
        ]
        // Add user to KeyChain
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            print(attributes)
            print("User saved successfully in the keychain")
        } else {
            print(attributes)
            print("Something went wrong trying to save the user in the keychain")
        }
        retrieveUserNameAndPasswordFromKeyChain(userName: userName, password: pass)
    }

    func retrieveUserNameAndPasswordFromKeyChain(userName: String, password: Data) {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: userName,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        // Check if user exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                print(username)
                print(password)
            }
        } else {
            print("Something went wrong trying to find the user in the keychain")
        }
    }
}

// TextField Configuration
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
             passwordField?.becomeFirstResponder()
        } else {
            passwordField?.resignFirstResponder()
        }
        return true
    }
}
