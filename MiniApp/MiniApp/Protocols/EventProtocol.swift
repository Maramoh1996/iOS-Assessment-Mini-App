//
//  EventProtocol.swift
//  MiniApp
//
//  Created by Maram Alghanoom on 11/08/1445 AH.
//

import Foundation

public protocol EventProtocol: AnyObject {
    associatedtype Event

    var eventBlock: ((Event) -> Void)? { get set }
}

public extension EventProtocol {

    @discardableResult
    func onEvent(_ eventBlock: ((Event) -> Void)?) -> Self {
        self.eventBlock = eventBlock
        return self
    }
}
