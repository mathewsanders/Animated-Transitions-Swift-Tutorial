//
//  SPTransitionManager.m
//  Transition
//
//  Created by unfilet on 6/19/15.
//  Copyright (c) 2015 Mat. All rights reserved.
//

#import "SPTransitionManager.h"
#import "BaseAnimation.h"
#import "RotateAnimation.h"
#import "ShuffleAnimation.h"
#import "SlideAnimation.h"
#import "ScaleAnimation.h"

@interface SPTransitionManager ()

@property(nonatomic,strong) BaseAnimation* animation;

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
        self.animation = [[RotateAnimation alloc] init];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    // these methods are the perfect place to set our `presenting` flag to either true or false - voila!
    self.animation.type = AnimationTypePresent;
    return self.animation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animation.type = AnimationTypeDismiss;
    return self.animation;
}


#pragma mark - Navigation Controller Delegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC {
    
    switch (operation) {
    case UINavigationControllerOperationPush:
        self.animation.type = AnimationTypePresent;
            break;
    case UINavigationControllerOperationPop:
        self.animation.type = AnimationTypeDismiss;
            break;
        default: return nil;
    }
    return self.animation;
    
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return nil;
}


@end
