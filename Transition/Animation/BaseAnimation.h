//
//  BaseAnimation.h
//  VCTransitions
//
//  Created by Tyler Tillage on 8/20/13.
//  Copyright (c) 2013 CapTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    AnimationTypePresent,
    AnimationTypeDismiss
} AnimationType;

@interface BaseAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) AnimationType type;

@end
