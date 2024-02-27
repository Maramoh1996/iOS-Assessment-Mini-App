//
//  TitleWithButtonCell.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 17/08/1445 AH.
//

import Foundation
import UIKit

class TitleWithButtonCell: UITableViewCell {
    
    @IBOutlet weak var webSocketTitle: UILabel?
    @IBOutlet weak var connectButton: UIButton?
    
    var isConnected: Bool = false
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    func setupCell() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        webSocketTitle?.text = "Connected to WebSocket"
        webSocketTitle?.textColor = .gray
        webSocketTitle?.font = UIFont.systemFont(ofSize: 15)
        
        connectButton?.backgroundColor = .purple
        connectButton?.layer.cornerRadius = 10
        connectButton?.setTitle("Connect", for: .normal)
        connectButton?.setTitleColor(UIColor .white, for: .normal)
    }
    
    @IBAction func connectButton(_ sender: AnyObject) {
        if !isConnected {
            connectButton?.setTitle("Disconnect", for: .normal)
            isConnected.toggle()
        } else {
            connectButton?.setTitle("Connect", for: .normal)
            isConnected.toggle()
        }
    }
}
