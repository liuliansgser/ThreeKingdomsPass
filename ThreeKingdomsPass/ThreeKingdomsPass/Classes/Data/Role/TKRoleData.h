//
//  TKRoleData.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/11.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKRoleEquipment.h"

//国籍
typedef enum : NSUInteger {
    CampWeiGuo,
    CampShuGuo,
    CampWuGuo,
    CampQunXiong,
    CampOwn
} Camp;

//身份
typedef enum : NSUInteger {
    IdentityKing,
    IdentityLoyal,
    IdentityRebels,
    IdentityMole,
} Identity;

@interface TKRoleData : NSObject

//base
@property (nonatomic, strong, readonly) NSString *roleID;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, unsafe_unretained, readonly) BOOL isMan;
@property (nonatomic, unsafe_unretained) Camp camp;
@property (nonatomic, unsafe_unretained) Identity identity;
@property (nonatomic, unsafe_unretained) NSUInteger HPupperlimit;
@property (nonatomic, unsafe_unretained) NSInteger HPnow;
@property (nonatomic, strong, readonly) NSString *showIdentity;
@property (nonatomic, unsafe_unretained) BOOL isAI;

//game
@property (nonatomic, unsafe_unretained) NSInteger position;        //位置
@property (nonatomic, unsafe_unretained) NSInteger actionposition;  //行动位置

//skills
@property (nonatomic, strong) NSMutableArray *skills;
@property (nonatomic, strong, readonly) NSMutableArray *skillsname;       //判断触发技能用

//cards
@property (nonatomic, strong) NSMutableArray *handcards;    //手牌区
@property (nonatomic, strong) NSMutableArray *dicides;      //判定区
@property (nonatomic, strong) TKRoleEquipment *equipment;     //装备区

- (id)initWithRoleData:(NSDictionary *)data;

@end
