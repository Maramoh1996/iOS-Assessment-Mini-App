//
//  TitleWithButtonCell.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 17/08/1445 AH.
//

import Foundation
import UIKit


class TitleWithButtonCell: UITableViewCell, URLSessionWebSocketDelegate, EventProtocol {
    
    @IBOutlet weak var webSocketTitle: UILabel?
    @IBOutlet weak var connectButton: UIButton?
    @IBOutlet weak var inputTextField: UITextField?
    
    var webSocket = WebSocket()
    var isConnected: Bool = false
    var textInput: String?
    var eventBlock: ((Event) -> Void)?

    enum Event {
        case didMessageSent
    }
    
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
            webSocket.connectWebSocket()
        } else {
            connectButton?.setTitle("Connect", for: .normal)
            isConnected.toggle()
            webSocket.closeSession()
        }
    }
    
    @IBAction func sendButton(_ sender: Any) {
        textInput = inputTextField?.text
        let isWebSocketConnected =  webSocket.isWebSocketConnected
        if isWebSocketConnected {
            webSocket.send(message: textInput ?? "")
            if let eventBlock = eventBlock {
                eventBlock(.didMessageSent)
            }
        }
        inputTextField?.text = ""
    }
}
