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
#import "TKGameCardData.h"
#import "TKRoleData.h"
#import "TKSkillData.h"

@interface TKGloble : NSObject

@property (nonatomic, unsafe_unretained) CGFloat globleWidth;
@property (nonatomic, unsafe_unretained) CGFloat globleHeight;

@property (nonatomic, strong) NSArray *roles;
@property (nonatomic, strong) NSArray *skills;
@property (nonatomic, strong) NSArray *normalcards;

//所有武将中获得武将信息(特定武将)
- (TKRoleData *)roleWithName:(NSString *)name;
//技能(single)
- (TKSkillData *)skillWithName:(NSString *)name;
//找到指定的牌
- (TKGameCardData *)cardWithCardID:(NSUInteger)cardID;

TK_SINGLETION_h(TKGloble)

- (AppDelegate *)delegate;
- (void)setUpGameDatas;

@end
