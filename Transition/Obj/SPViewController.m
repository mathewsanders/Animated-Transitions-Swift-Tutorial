//
//  SPViewController.m
//  Transition
//
//  Created by unfilet on 6/19/15.
//  Copyright (c) 2015 Mat. All rights reserved.
//

#import "SPViewController.h"
#import "SPTransitionManager.h"

@interface SPViewController ()
@property (nonatomic, strong) SPTransitionManager* transitionManager;
@end

@implementation SPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transitionManager = [SPTransitionManager new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (IBAction)unwindToViewController:(UIStoryboardSegue*) segue {
    // empty for now
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    // this gets a reference to the screen that we're about to transition to
    UIViewController* toViewController = (UIViewController*)segue.destinationViewController;
    
    // instead of using the default transition animation, we'll ask
    // the segue to use our custom TransitionManager object to manage the transition animation
    toViewController.transitioningDelegate = self.transitionManager;

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.presentingViewController == nil ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

@end
