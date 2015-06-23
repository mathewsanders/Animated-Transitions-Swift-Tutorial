//
//  ScaleAnimation.h
//  VCTransitions
//
//  Created by Tyler Tillage on 9/2/13.
//  Copyright (c) 2013 CapTech. All rights reserved.
//

#import "BaseAnimation.h"

@interface ScaleAnimation : BaseAnimation <UIViewControllerInteractiveTransitioning>

@property (nonatomic, assign, getter = isInteractive) BOOL interactive;
@property (nonatomic, assign) UINavigationController *navigationController;
@property (nonatomic, strong) UIView *viewForInteraction;

-(instancetype)initWithNavigationController:(UINavigationController *)controller;
-(void)handlePinch:(UIPinchGestureRecognizer *)pinch;

@end
