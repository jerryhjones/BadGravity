//
//  CMMotionManager+Spaceman.m
//  Repartee
//
//  Created by Joel Kraut on 9/1/13.
//  Copyright (c) 2013 Spaceman Labs. All rights reserved.
//

#import "CMMotionManager+Spaceman.h"

@implementation CMMotionManager (SML)

+ (CMMotionManager *)sharedMotionManager
{
	static CMMotionManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [[CMMotionManager alloc] init];
	});
	return manager;
}

@end
