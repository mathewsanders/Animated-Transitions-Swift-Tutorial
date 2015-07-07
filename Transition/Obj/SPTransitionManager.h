//
//  SPTransitionManager.h
//  Transition
//
//  Created by unfilet on 6/19/15.
//  Copyright (c) 2015 Mat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPTransitionManager : NSObject<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
+ (instancetype)sharedInstance;
@end
