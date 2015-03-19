# NotificationController

A Swift version Notification Controller of [KKSNotificationController](https://github.com/kukushi/KKSNotificationController).

Fetures include:

* Clarity method name
* Implicit observer removal on controller dealloc.


## Usage

```
// use Block
notificationController.observe(notificationName, object: nil) { (notification) -> Void in
    // do something...
}

// use selector is not current supported

```

This is the complete example. The removal of observer will be done when controller is deallocated.

## 


NSObject Category

A NSObject Category is provided to give you direct access of controller.

[self.notificationController observeNotification:notificationName object:nil block:^(NSNotification *notification) {
    // Do something
}];

## Requirements

NotificationController using ARC and weak Collections. it requires:

* iOS 6 or later.
* OS X 10.7 or later.