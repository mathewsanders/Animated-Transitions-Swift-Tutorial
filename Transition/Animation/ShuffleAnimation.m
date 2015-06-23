//
//  ShuffleAnimation.m
//  VCTransitions
//
//  Created by Tyler Tillage on 7/3/13.
//  Copyright (c) 2013 CapTech. All rights reserved.
//

#import "ShuffleAnimation.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShuffleAnimation

#pragma mark - Animated Transitioning

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //Get references to the view hierarchy
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //Take a snapshot of the 'from' view
    UIView *fromSnapshot = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    fromSnapshot.frame = fromViewController.view.frame;
    [containerView insertSubview:fromSnapshot aboveSubview:fromViewController.view];
    [fromViewController.view removeFromSuperview];
    
    //Add the 'to' view to the hierarchy
    toViewController.view.frame = fromSnapshot.frame;
    [containerView insertSubview:toViewController.view belowSubview:fromSnapshot];
    
    //The amount of horizontal movement need to fit the views side by side in the middle of the animation
    CGFloat width = floorf(fromSnapshot.frame.size.width/2.0)+5.0;
    
    //Animate using keyframe animations
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        
        //Apply z-index translations to make the views move away from the user
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.20 animations:^{
            CATransform3D fromT = CATransform3DIdentity;
            fromT.m34 = 1.0 / -2000;
            fromT = CATransform3DTranslate(fromT, 0.0, 0.0, -590.0);
            fromSnapshot.layer.transform = fromT;
            
            CATransform3D toT = CATransform3DIdentity;
            toT.m34 = 1.0 / -2000;
            toT = CATransform3DTranslate(fromT, 0.0, 0.0, -600.0);
            toViewController.view.layer.transform = toT;
        }];
        
        //Adjust the views horizontally to clear eachother
        [UIView addKeyframeWithRelativeStartTime:0.20 relativeDuration:0.20 animations:^{
            if (self.type == AnimationTypePresent) {
                fromSnapshot.layer.transform = CATransform3DTranslate(fromSnapshot.layer.transform, -width, 0.0, 0.0);
                toViewController.view.layer.transform = CATransform3DTranslate(toViewController.view.layer.transform, width, 0.0, 0.0);
            } else if (self.type == AnimationTypeDismiss) {
                fromSnapshot.layer.transform = CATransform3DTranslate(fromSnapshot.layer.transform, width, 0.0, 0.0);
                toViewController.view.layer.transform = CATransform3DTranslate(toViewController.view.layer.transform, -width, 0.0, 0.0);
            }
        }];
        
        //Pull the 'to' view in front of the 'from' view
        [UIView addKeyframeWithRelativeStartTime:0.40 relativeDuration:0.20 animations:^{
            fromSnapshot.layer.transform = CATransform3DTranslate(fromSnapshot.layer.transform, 0.0, 0.0, -200);
            toViewController.view.layer.transform = CATransform3DTranslate(toViewController.view.layer.transform, 0.0, 0.0, 500);
        }];
        
        //Adjust the views horizontally to place them back on top of eachother
        [UIView addKeyframeWithRelativeStartTime:0.60 relativeDuration:0.20 animations:^{
            CATransform3D fromT = fromSnapshot.layer.transform;
            CATransform3D toT = toViewController.view.layer.transform;
            if (self.type == AnimationTypePresent) {
                fromT = CATransform3DTranslate(fromT, floorf(width), 0.0, 200.0);
                toT = CATransform3DTranslate(fromT, floorf(-(width*0.03)), 0.0, 0.0);
            } else if (self.type == AnimationTypeDismiss) {
                fromT = CATransform3DTranslate(fromT, floorf(-width), 0.0, 200.0);
                toT = CATransform3DTranslate(fromT, floorf(width*0.03), 0.0, 0.0);
            }
            fromSnapshot.layer.transform = fromT;
            toViewController.view.layer.transform = toT;
        }];
        
        //Move the 'to' view to its final position
        [UIView addKeyframeWithRelativeStartTime:0.80 relativeDuration:0.20 animations:^{
            toViewController.view.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {
        [fromSnapshot removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.3;
}

@end
