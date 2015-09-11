//
//  TKSkillData.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/11.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SkillTypeNormal,
    SkillTypeKing,
    SkillTypeLimit,
    SkillTypeAwaken,
    SkillTypeLock
} SkillType;

@interface TKSkillData : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *depict;
@property (nonatomic, unsafe_unretained) SkillType skilltype;

- (id)initWithSkillData:(NSDictionary *)data;

@end
