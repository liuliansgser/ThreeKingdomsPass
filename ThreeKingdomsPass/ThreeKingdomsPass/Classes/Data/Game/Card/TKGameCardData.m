//
//  TKGameCardData.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKGameCardData.h"

@implementation TKGameCardData

- (id)initWithCardData:(NSDictionary *)data
{
    if (self = [super init]) {
        
        NSNumber *cardID = [data objectForKey:@"cardID"];
        _cardID = [cardID integerValue];
        _name = [data objectForKey:@"name"];
        _depict = [data objectForKey:@"depict"];
        NSNumber *color = [data objectForKey:@"color"];
        _color = [color integerValue];
        NSNumber *count = [data objectForKey:@"count"];
        _count = [count integerValue];
        NSNumber *type = [data objectForKey:@"type"];
        _type = [type integerValue];
        _image = [data objectForKey:@"name"];
        _oiginal = [data objectForKey:@"oiginal"];
        _soundman = [data objectForKey:@"soundman"];
        _soundwomen = [data objectForKey:@"soundwomen"];
        
        if ([_name isEqualToString:@"雷杀"] || [_name isEqualToString:@"火杀"])
            _isElementKill = YES;
        
        if ([_name isEqualToString:@"乐不思蜀"] || [_name isEqualToString:@"闪电"] || [_name isEqualToString:@"兵粮寸断"]) {
            _isDelay = YES;
        }
        
        _range = 0;
        if (_type == CardTypeWeapon) {
            NSNumber *range = [data objectForKey:@"range"];
            _range = [range integerValue];
        }
    }
    return self;
}

- (NSString *)showColor
{
    switch (self.color) {
        case CardColorSpade:
            return @"黑桃";
            break;
        case CardColorHeart:
            return @"红桃";
            break;
        case CardColorClub:
            return @"草花";
            break;
        case CardColorDiamond:
            return @"方块";
            break;
            
        default:
            break;
    }
}

- (NSString *)showCount
{
    if (self.count == 1) return @"A";
    else if (self.count == 11) return @"J";
    else if (self.count == 12) return @"Q";
    else if (self.count == 13) return @"K";
    else return [NSString stringWithFormat:@"%lu",(unsigned long)self.count];
}

- (void)showCardInfomation
{
    NSLog(@"[%@][%@] [%@]\n",self.showColor,self.showCount,self.name);
}

@end
