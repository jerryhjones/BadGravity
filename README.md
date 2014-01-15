BadGravity
==========

Run on an iOS device, and watch console for the message "MOTION UPDATE AFTER stopDeviceMotionUpdates WAS CALLED". This indicates that a callback block for `startDeviceMotionUpdatesToQueue:withHandler:` was called _after_ `stopDeviceMotionUpdates` was called.

###UIGravityBehavior's dangling pointer
In `SMLViewController.m` change `CAPTURE_GRAVITY` to `YES`, then run on a device and wait. The app will eventually crash at `SMLViewController:86` when trying to set the angle on the gravity behavior. The block is called under the same circumstances as above - the callback takes place after `stopDeviceMotionUpdates` is called. In this case, the view's `UIDynamicAnimator` has been deallocated, but the gravity behavior was captured by the block.