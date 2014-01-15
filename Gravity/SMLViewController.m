//
//  SMLViewController.m
//  Gravity
//
//  Created by Jerry Jones on 1/15/14.
//  Copyright (c) 2014 Spaceman Labs, Inc. All rights reserved.
//

#import "SMLViewController.h"
#import "SMLGravityView.h"

#define CAPTURE_GRAVITY NO

@interface SMLViewController ()
@property (nonatomic, strong) SMLGravityView *gravityView;
@end

@implementation SMLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self addAndRemove];

}

- (void)addAndRemove
{
	__weak typeof(self) wSelf = self;
	double delayInSeconds = 0.28;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		if (wSelf.gravityView.superview) {
			[wSelf.gravityView removeFromSuperview];
			wSelf.gravityView = nil;
		} else {
			wSelf.gravityView = [[SMLGravityView alloc] initWithFrame:wSelf.view.bounds];
			if (CAPTURE_GRAVITY) {
				wSelf.gravityView.captureGravity = YES;
			}
			
			[wSelf.view addSubview:wSelf.gravityView];
		}

		[wSelf addAndRemove];
	});
}

- (BOOL)shouldAutorotate
{
	return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end