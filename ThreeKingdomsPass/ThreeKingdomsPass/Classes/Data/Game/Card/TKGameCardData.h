//
//  TKGameCardData.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CardColorSpade,
    CardColorHeart,
    CardColorClub,
    CardColorDiamond
} CardColor;

typedef enum : NSUInteger {
    CardTypeBasic,
    CardTypeTrick,
    CardTypeWeapon,
    CardTypeArmor,
    CardTypeDHorse,
    CardTypeAHorse
} CardType;

@interface TKGameCardData : NSObject

@property (nonatomic, unsafe_unretained, readonly) NSUInteger cardID;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *depict;
@property (nonatomic, unsafe_unretained, readonly) CardColor color;
@property (nonatomic, strong, readonly) NSString *showColor;
@property (nonatomic, unsafe_unretained, readonly) NSUInteger count;
@property (nonatomic, strong, readonly) NSString *showCount;
@property (nonatomic, unsafe_unretained, readonly) CardType type;
@property (nonatomic, strong, readonly) NSString *image;
@property (nonatomic, strong, readonly) NSString *oiginal;
@property (nonatomic, strong, readonly) NSString *soundman;
@property (nonatomic, strong, readonly) NSString *soundwomen;

//基本牌
@property (nonatomic, unsafe_unretained) BOOL isElementKill;

//锦囊牌
@property (nonatomic, unsafe_unretained) BOOL isDelay;

//武器距离
@property (nonatomic, unsafe_unretained) NSInteger range;

- (id)initWithCardData:(NSDictionary *)data;

//debug
- (void)showCardInfomation;

@end
