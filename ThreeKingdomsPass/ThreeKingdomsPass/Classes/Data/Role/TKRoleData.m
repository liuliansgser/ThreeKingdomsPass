//
//  TKRoleData.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/11.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKRoleData.h"
#import "TKSkillData.h"
#import "TKGloble.h"

@implementation TKRoleData

- (id)initWithRoleData:(NSDictionary *)data
{
    if (self = [super init]) {
        
        _roleID = [data objectForKey:@"roleID"];
        _name = [data objectForKey:@"name"];
        NSNumber *camp = [data objectForKey:@"camp"];
        _camp = [camp integerValue];
        NSNumber *HPupperlimit = [data objectForKey:@"HPupperlimit"];
        _HPupperlimit = [HPupperlimit integerValue];
        _HPnow = _HPupperlimit;
        _isAI = YES;
        
        _skills = [NSMutableArray array];
        _skillsname = [NSMutableArray array];
        NSArray *skills = [data objectForKey:@"skills"];
        for (NSDictionary *dic in skills) {
            TKSkillData *skill = [[TKGloble sharedInstance] skillWithName:[dic objectForKey:@"name"]];
            if (skill) {
                [_skills addObject:skill];
                [_skillsname addObject:skill.name];
            }
        }
        
        _handcards = [NSMutableArray array];
        _dicides = [NSMutableArray array];
        _equipment = [TKRoleEquipment new];
    }
    return self;
}

@end
