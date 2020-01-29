//
//  Accessibility+Utils.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 28/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

func say(_ string: String) {
    AccessibilityManager.shared.enqueue(string)
}

protocol AccessibilityManagerDelegate {
    func didChangeQueueState(queue: [String])
}

class AccessibilityManager {
    
    static let shared = AccessibilityManager()
    var delegates: [AccessibilityManagerDelegate] = []
    var queue: [String] = [] {
        didSet {
            delegates.forEach({ $0.didChangeQueueState(queue: queue) })
        }
    }
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(dequeue), name: UIAccessibility.announcementDidFinishNotification, object: nil)
    }
    
    func subscribe<T: AccessibilityManagerDelegate>(_ obj: T) {
        delegates.append(obj)
    }
    
    func enqueue(_ string: String) {
        if queue.isEmpty {
            queue.append(string)
            UIAccessibility.post(notification: .announcement, argument: string)
            return
        }
        queue.append(string)
    }
    
    @objc func dequeue() {
        queue.removeFirst()
        guard let next = queue.first else { return }
        UIAccessibility.post(notification: .announcement, argument: next)
    }
    
    
}
