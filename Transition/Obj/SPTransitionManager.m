//
//  SPTransitionManager.m
//  Transition
//
//  Created by unfilet on 6/19/15.
//  Copyright (c) 2015 Mat. All rights reserved.
//

#import "SPTransitionManager.h"
#import "RotateAnimation.h"

@interface SPTransitionManager ()

@property(nonatomic,strong) RotateAnimation* rotateAnimation;

@end

@implementation SPTransitionManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rotateAnimation = [[RotateAnimation alloc] init];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    // these methods are the perfect place to set our `presenting` flag to either true or false - voila!
    self.rotateAnimation.type = AnimationTypePresent;
    return self.rotateAnimation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.rotateAnimation.type = AnimationTypeDismiss;
    return self.rotateAnimation;
}


#pragma mark - Navigation Controller Delegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC {
    
    switch (operation) {
    case UINavigationControllerOperationPush:
        self.rotateAnimation.type = AnimationTypePresent;
            break;
    case UINavigationControllerOperationPop:
        self.rotateAnimation.type = AnimationTypeDismiss;
            break;
        default: return nil;
    }
    return self.rotateAnimation;
    
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return nil;
}


@end
