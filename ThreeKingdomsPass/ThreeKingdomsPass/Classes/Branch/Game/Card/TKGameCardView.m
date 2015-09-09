//
//  TKGameCardView.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKGameCardView.h"

@interface TKGameCardView ()

@property (nonatomic, weak, readonly) TKGameCardData *data;

@end

@implementation TKGameCardView

- (id)initWithFrame:(CGRect)frame WithCardData:(TKGameCardData *)data
{
    _data = data;
    
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_data.image]];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.f;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
