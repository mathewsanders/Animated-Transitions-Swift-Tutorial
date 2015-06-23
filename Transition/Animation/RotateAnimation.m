//
//  RotateAnimation.m
//  Transition
//
//  Created by unfilet on 6/23/15.
//  Copyright (c) 2015 Mat. All rights reserved.
//

#import "RotateAnimation.h"

@implementation RotateAnimation

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView* container = transitionContext.containerView;
    
    
    UIView* fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView* toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    
    //    UIView* fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    //    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    
    CGAffineTransform offScreenRight = CGAffineTransformMakeRotation(-M_PI/2);
    CGAffineTransform offScreenLeft = CGAffineTransformMakeRotation(M_PI/2);
    
    // prepare the toView for the animation
    
    
    // set the anchor point so that rotations happen from the top-left corner
//    [self setAnchorPoint:CGPointMake(0.0, 0.0) forView:toView];
//    [self setAnchorPoint:CGPointMake(0.0, 0.0) forView:fromView];

    toView.transform = CGAffineTransformIdentity;
    
    toView.layer.anchorPoint = CGPointZero;
    fromView.layer.anchorPoint = CGPointZero;
    
    // updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
    toView.layer.position = CGPointZero;
    fromView.layer.position = CGPointZero;
    
    toView.transform = self.type == AnimationTypePresent ? offScreenRight : offScreenLeft;
    
    // add the both views to our view controller
    [container insertSubview:toView belowSubview:fromView];
    
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
                         fromView.transform = self.type == AnimationTypePresent ? offScreenLeft : offScreenRight;
                         toView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         // tell our transitionContext object that we've finished animating
                         fromView.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:true];
                     }];
    
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.type == AnimationTypePresent) return 1.0;
    else if (self.type == AnimationTypeDismiss) return 1.75;
    else return [super transitionDuration:transitionContext];
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = oldOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

@end
