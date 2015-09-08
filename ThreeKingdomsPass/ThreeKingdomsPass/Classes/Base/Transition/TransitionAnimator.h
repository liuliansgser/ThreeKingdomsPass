//
//  TransitionAnimator.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/8.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Standard random float code
 @param min
 @param max
 @result random number between min and max
 */
#define RANDOM_FLOAT(MIN,MAX) (((CGFloat)arc4random() / 0x100000000) * (MAX - MIN) + MIN);

@interface TransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, unsafe_unretained) BOOL presenting;

@end
