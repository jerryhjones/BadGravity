//
//  SMLGravityView.m
//  Gravity
//
//  Created by Jerry Jones on 1/15/14.
//  Copyright (c) 2014 Spaceman Labs, Inc. All rights reserved.
//

#import "SMLGravityView.h"

@implementation SMLGravityView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (nil == self) {
		return nil;
	}
	
	self.backgroundColor = [UIColor clearColor];
	[self setup];
	
	return self;
}

- (void)dealloc
{
	[self.motionManager stopDeviceMotionUpdates];
}

- (void)didMoveToSuperview
{
	[super didMoveToSuperview];
	if (nil == self.superview){
		[self.motionManager stopDeviceMotionUpdates];
	} else {
		if (self.captureGravity) {
			[self startMotionUpdatesCaptured];
		} else {
			[self startMotionUpdates];
		}

	}
}

- (void)setup
{
	self.gravityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	self.gravityView.backgroundColor = [UIColor yellowColor];
	[self addSubview:self.gravityView];
	
	self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
	self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self.gravityView]];
	[_animator addBehavior:_gravity];
	
	self.collision = [[UICollisionBehavior alloc] initWithItems:@[self.gravityView]];
	self.collision.translatesReferenceBoundsIntoBoundary = YES;
	[_animator addBehavior:_collision];
	
	self.motionManager = [CMMotionManager sharedMotionManager];
	self.motionManager.deviceMotionUpdateInterval = 1./30.;
}

- (void)startMotionUpdates
{
	__weak typeof(self) wSelf = self;
//	NSLog(@"start wSelf: %p", wSelf);
	
	[self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
//		NSLog(@"wSelf: %p", wSelf);
		double angle = motion.attitude.yaw + M_PI_2;
		wSelf.gravity.angle = angle;
		if (nil == wSelf) {
			NSLog(@"MOTION UPDATE AFTER stopDeviceMotionUpdates WAS CALLED!!");
		}
		
	}];
}

- (void)startMotionUpdatesCaptured
{
	__weak typeof(self) wSelf = self;
	UIGravityBehavior *gravity = self.gravity;
	[self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
		double angle = motion.attitude.yaw + M_PI_2;
		gravity.angle = angle;
		
		// If self is nil, so is the dynamic animator that the capture gravity behavior is attached to
		// Therefore, the log below will never be called
		if (nil == wSelf) {
			NSLog(@"MOTION UPDATE AFTER stopDeviceMotionUpdates WAS CALLED!!");
		}
		
	}];
}


@end
