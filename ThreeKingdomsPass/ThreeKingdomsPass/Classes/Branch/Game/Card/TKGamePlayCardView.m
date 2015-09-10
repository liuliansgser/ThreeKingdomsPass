//
//  TKGamePlayCardView.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/10.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKGamePlayCardView.h"
#import "TKGloble.h"
#import "TKGame.h"
#import "TKGameCardView.h"

@interface CardBackGroundView : UIImageView

@end

@implementation CardBackGroundView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"card_background_image.jpg"];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.f;
    }
    return self;
}

@end

@interface TKGamePlayCardView ()

@end

@implementation TKGamePlayCardView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        self.userInteractionEnabled = YES;
        [self _createItems];
        
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(getCard:)];
        [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
        [self addGestureRecognizer:swipeGesture];
    }
    return self;
}

- (void)_createItems
{
    for (NSUInteger i = 0; i < 11; i++) {
        CardBackGroundView *view = [[CardBackGroundView alloc] initWithFrame:CGRectMake(i*(0.2f), i*(-0.7f), TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT)];
        [self addSubview:view];
    }
}

- (void)getCard:(UISwipeGestureRecognizer *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(userGetCard)]){
        [self.delegate userGetCard];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
