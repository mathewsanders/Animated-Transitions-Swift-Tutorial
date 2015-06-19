//
//  SPTransitionManager.m
//  Transition
//
//  Created by unfilet on 6/19/15.
//  Copyright (c) 2015 Mat. All rights reserved.
//

#import "SPTransitionManager.h"

@interface SPTransitionManager ()

@property (nonatomic) bool presenting;

@end

@implementation SPTransitionManager


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView* container = transitionContext.containerView;
    UIView* fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    
    CGAffineTransform offScreenRight = CGAffineTransformMakeRotation(-M_PI/2);
    CGAffineTransform offScreenLeft = CGAffineTransformMakeRotation(M_PI/2);
    
    // prepare the toView for the animation
    toView.transform = self.presenting ? offScreenRight : offScreenLeft;
    
    // set the anchor point so that rotations happen from the top-left corner
    toView.layer.anchorPoint = CGPointMake(0, 0);
    fromView.layer.anchorPoint = CGPointMake(0, 0);
    
    // updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
    toView.layer.position = CGPointMake(0, 0);
    fromView.layer.position = CGPointMake(0, 0);

    // add the both views to our view controller
    [container addSubview:toView];
    [container addSubview:fromView];

    // get the duration of the animation
    // DON'T just type '0.5s' -- the reason why won't make sense until the next post
    // but for now it's important to just follow this approach
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // perform the animation!
    // for this example, just slid both fromView and toView to the left at the same time
    // meaning fromView is pushed off the screen and toView slides into view
    // we also use the block animation usingSpringWithDamping for a little bounce

    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.8f
                        options:0
                     animations:^{
                         // slide fromView off either the left or right edge of the screen
                         // depending if we're presenting or dismissing this view
                         fromView.transform = self.presenting ? offScreenLeft : offScreenRight;
                         toView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         // tell our transitionContext object that we've finished animating
                         [transitionContext completeTransition:true];
                     }];
    
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.75;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    // these methods are the perfect place to set our `presenting` flag to either true or false - voila!
    self.presenting = true;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presenting = false;
    return self;
}


@end
