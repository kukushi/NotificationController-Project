//
//  NotificationController.swift
//  NotificationController
//
//  Created by kukushi on 3/1/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import Foundation

private var notificationControllerAssociationKey: UInt8 = 0

public extension NSObject {
    var notificationController: NotificationController! {
        get {
            var controller = objc_getAssociatedObject(self, &notificationControllerAssociationKey) as? NotificationController
            if controller == nil {
                controller = NotificationController(observer: self)
                self.notificationController = controller
            }
            return controller
        }
        set(newValue) {
            objc_setAssociatedObject(self, &notificationControllerAssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        }
    }
}

public class NotificationController: NSObject {
    public typealias NotificationClouse = (NSNotification!) -> Void
    
    private let observer: NSObject!
    private var blockInfos = Set<NotificationInfo>()
    private var selectorInfos = Set<NotificationInfo>()
    
    private var DefaultCenter: NSNotificationCenter {
        return NSNotificationCenter.defaultCenter()
    }
    
    // MARK: Initalization
    
    init (observer: NSObject) {
        self.observer = observer
    }
    
    deinit {
        unobserveAll()
    }
    
    // MARK: Observe with Clouse
    
    public func observe(notification: String?, object: NSObject? = nil, queue: NSOperationQueue? = nil, block: NotificationClouse) {
        let observer = DefaultCenter.addObserverForName(notification, object: object, queue: queue, usingBlock: block)
        
        let info = NotificationInfo(observer: observer as! NSObject, name: notification, object: object)
        
        blockInfos.insert(info)
        
    }
    
    public func unobserve(notification: String?, object: NSObject? = nil) {
        var deadInfos = Set<NotificationInfo>()
        
        for info in blockInfos {
            if info.name == notification && info.object == object {
                DefaultCenter.removeObserver(info.observer, name: info.name, object: info.object)
            }
            
            deadInfos.insert(info)
        }
        
        for info in deadInfos {
            blockInfos.remove(info)
        }
    }
    
    public func unobserveAll() {
        
        for info in blockInfos {
            DefaultCenter.removeObserver(info.observer, name: info.name, object: info.object)
        }
        
        self.blockInfos.removeAll(keepCapacity: false)
    }
}

private struct NotificationInfo: Hashable {
    weak var observer: NSObject!
    let name: String!
    let object: NSObject?
    let selector: Selector?
    
    init (observer: NSObject, name: String?, object: NSObject? = nil, selector: Selector? = nil) {
        self.observer = observer
        self.name = name
        self.object = object
        self.selector = selector
    }
    
    var hashValue: Int {
        return name.hash
    }
}

private func ==(lhs: NotificationInfo, rhs: NotificationInfo) -> Bool {
    if lhs == rhs {
        return true
    }
    else {
        return lhs.name == rhs.name
    }
}
