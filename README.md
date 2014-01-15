BadGravity
==========

Run on an iOS device, and watch console for the message "MOTION UPDATE AFTER stopDeviceMotionUpdates WAS CALLED". This indicates that a callback block for `startDeviceMotionUpdatesToQueue:withHandler:` was called _after_ `stopDeviceMotionUpdates` was called.

###~~UIGravityBehavior's~~ UIDynamicBehavior's dangling pointer

The `dynamicAnimator` property on all `UIDynamicBehavior` objects is unsafe. Any behavior that outlives it's animator is  a crash waiting to happen.

The following will always crash, with a behavior of any type.
````
UIView *item = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
[self.view addSubview:item];
UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
UIGravityBehavior *behavior = [[UIGravityBehavior alloc] initWithItems:@[item]];
[animator addBehavior:behavior];

double delayInSeconds = 0.4;
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
	NSTimeInterval time = behavior.dynamicAnimator.elapsedTime;
});
````

To see how easy it is to cause issues when combined w/ motion updates with block callbacks, you can try the following: 

In `SMLViewController.m` change `CAPTURE_GRAVITY` to `YES`, then run on a device and wait. The app will eventually crash at `SMLViewController:86` when trying to set the angle on the gravity behavior. The block is called under the same circumstances as above - the callback takes place after `stopDeviceMotionUpdates` is called. In this case, the view's `UIDynamicAnimator` has been deallocated, but the gravity behavior was captured by the block.
