//
//  TKSkillData.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/11.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKSkillData.h"

@implementation TKSkillData

- (id)initWithSkillData:(NSDictionary *)data
{
    if (self = [super init]) {
        _name = [data objectForKey:@"name"];
        _depict = [data objectForKey:@"depict"];
        NSNumber *skilltype = [data objectForKey:@"skilltype"];
        _skilltype = [skilltype integerValue];
    }
    return self;
}

@end
