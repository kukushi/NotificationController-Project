# NotificationController

A Swift version Notification Controller of [KKSNotificationController](https://github.com/kukushi/KKSNotificationController).

Fetures include:

* Clarity method name
* Implicit observer removal on controller dealloc.


## Usage

```
// with closure
notificationController.observe(notificationName, object: nil) { (notification) -> Void in
    // do something...
}

// selector way gone with perfromWithSelector:

```

This is the complete example. The removal of observer will be done when controller is deallocated.

##  NSObject Category

A NSObject Category is provided to give you direct access of controller show as above.

## Requirements

NotificationController using ARC and weak Collections. It requires:

* iOS 6 or later.
* OS X 10.7 or later.