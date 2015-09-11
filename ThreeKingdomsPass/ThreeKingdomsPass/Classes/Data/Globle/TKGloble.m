//
//  TKGloble.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/8/19.
//  Copyright (c) 2015年 liulian. All rights reserved.
//

#import "TKGloble.h"
#import "NSArray+BlocksKit.h"

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

- (void)setUpGameDatas
{
    self.normalcards = [self _normalcards];
    self.skills = [self _skills];
    self.roles = [self _roles];
}

- (NSArray *)_normalcards
{
    if (!self.normalcards) {
        NSArray *normal = [[self _dataWithContentsOfFileWithName:@"card"] objectForKey:@"normal"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[normal count]];
        for (NSUInteger i = 0; i < [normal count]; i++) {
            TKGameCardData *cardData = [[TKGameCardData alloc] initWithCardData:normal[i]];
            if (cardData.name != nil) [array addObject:cardData];
        }
        return array;
    }
    return self.normalcards;
}

- (NSArray *)_roles
{
    if (!self.roles) {
        NSArray *normal = [[self _dataWithContentsOfFileWithName:@"role"] objectForKey:@"normal"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[normal count]];
        for (NSUInteger i = 0; i < [normal count]; i++) {
            TKRoleData *roleData = [[TKRoleData alloc] initWithRoleData:normal[i]];
            if (roleData.name != nil) [array addObject:roleData];
        }
        return array;
    }
    return self.roles;
}

- (NSArray *)_skills
{
    if (!self.skills) {
        NSArray *normal = [[self _dataWithContentsOfFileWithName:@"skill"] objectForKey:@"skill"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[normal count]];
        for (NSUInteger i = 0; i < [normal count]; i++) {
            TKSkillData *skillData = [[TKSkillData alloc] initWithSkillData:normal[i]];
            if (skillData.name != nil) [array addObject:skillData];
        }
        return array;
    }
    return self.skills;
}

- (NSDictionary *)_dataWithContentsOfFileWithName:(NSString *)name
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
                                                   pathForResource:name
                                                   ofType:@"pass"]
                                          options:NSDataReadingUncached
                                            error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingMutableContainers
                                                                 error:nil];
    return dictionary;
}

- (TKRoleData *)roleWithName:(NSString *)name
{
    NSArray *array = [self.roles bk_select:^BOOL(TKRoleData *role) {
        return [role.name isEqualToString:name];
    }];
    if ([array count] != 1) {
        NSLog(@"[roleWithName] 查询错误");
        return nil;
    }
    return array[0];
}

- (TKSkillData *)skillWithName:(NSString *)name
{
    NSArray *array = [self.skills bk_select:^BOOL(TKSkillData *skill) {
        return [skill.name isEqualToString:name];
    }];
    if ([array count] != 1) {
        NSLog(@"[skillWithName] 查询错误");
        return nil;
    }
    return array[0];
}

- (TKGameCardData *)cardWithCardID:(NSUInteger)cardID
{
    NSArray *array = [self.normalcards bk_select:^BOOL(TKGameCardData *card) {
        return card.cardID == cardID;
    }];
    if ([array count] != 1) {
        NSLog(@"[cardWithCardID] 查询错误");
        return nil;
    }
    return array[0];
}

@end
