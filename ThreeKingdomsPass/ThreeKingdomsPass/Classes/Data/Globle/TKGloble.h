//
//  TKGloble.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/8/19.
//  Copyright (c) 2015年 liulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TKDefine.h"
#import "AppDelegate.h"

@interface TKGloble : NSObject

@property (nonatomic, unsafe_unretained) CGFloat globleWidth;
@property (nonatomic, unsafe_unretained) CGFloat globleHeight;

TK_SINGLETION_h(TKGloble)

- (AppDelegate *)delegate;

@end
