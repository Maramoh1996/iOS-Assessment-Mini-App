//
//  WebSocket.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 18/08/1445 AH.
//

import Foundation
import UIKit

class WebSocket: NSObject, URLSessionWebSocketDelegate {
    
    private var webSocket : URLSessionWebSocketTask?
    var isWebSocketConnected: Bool = false

    func connectWebSocket() {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let url = URL(string:  "wss://echo.websocket.org/")
        
        webSocket = session.webSocketTask(with: url!)
        webSocket?.resume()
        isWebSocketConnected = true
    }

    func closeSession() {
        let reason = "Closing connection".data(using: .utf8)
        webSocket?.cancel(with: .goingAway, reason: reason)
        isWebSocketConnected = false
    }
    
    func send(message: String) {
        let workItem = DispatchWorkItem{
            
            DispatchQueue.main.async {
                self.webSocket?.send(URLSessionWebSocketTask.Message.string(message), completionHandler: { error in
                    
                    if error == nil {
                        self.send(message: message)
                    } else {
                        print(error?.localizedDescription ?? "")
                    }
                })
            }
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: workItem)
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
          print("Web Socket did connect")
      }
      
      func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
          print("Web Socket did disconnect")
      }
}
