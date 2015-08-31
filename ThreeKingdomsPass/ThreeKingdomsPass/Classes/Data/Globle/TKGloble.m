//
//  TKGloble.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/8/19.
//  Copyright (c) 2015年 liulian. All rights reserved.
//

#import "TKGloble.h"

@implementation TKGloble

TK_SINGLETION_m(TKGloble)

- (id)init {
    if (self = [super init]) {
        ;
    }
    return self;
}

- (AppDelegate *)delegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
