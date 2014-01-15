//
//  SMLGravityView.h
//  Gravity
//
//  Created by Jerry Jones on 1/15/14.
//  Copyright (c) 2014 Spaceman Labs, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMMotionManager+Spaceman.h"

@interface SMLGravityView : UIView

@property (assign, nonatomic) BOOL captureGravity;
@property (strong, nonatomic) UIView *gravityView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collision;
@property (strong, nonatomic) CMMotionManager *motionManager;

@end
