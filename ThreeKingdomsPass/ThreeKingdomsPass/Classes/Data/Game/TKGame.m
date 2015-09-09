//
//  TKGame.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKGame.h"
#import "TKGameCardData.h"

@implementation TKGame

TK_SINGLETION_m(TKGloble)

- (id)init {
    if (self = [super init]) {
        self.normalcards = [self _normalcards];
    }
    return self;
}

- (NSArray *)_normalcards
{
    if (!self.normalcards) {
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"card"
                                                       ofType:@"pass"]
                                              options:NSDataReadingUncached
                                                error:nil];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
        NSArray *normal = [dictionary objectForKey:@"normal"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[normal count]];
        for (NSUInteger i = 0; i < [normal count]; i++) {
            TKGameCardData *cardData = [[TKGameCardData alloc] initWithCardData:normal[i]];
            if (cardData.name != nil) [array addObject:cardData];
        }
        return array;
    }
    return self.normalcards;
}

@end
