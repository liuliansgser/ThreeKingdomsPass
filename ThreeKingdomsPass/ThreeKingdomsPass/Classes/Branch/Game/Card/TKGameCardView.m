//
//  TKGameCardView.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKGameCardView.h"
#import "TKGloble.h"

@interface TKGameCardView ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, unsafe_unretained) CGPoint startOffset;

@property (nonatomic, unsafe_unretained) NSTimeInterval lastMoveTime;// 上次移动的时间
@property (nonatomic, strong) NSTimer *moveTimer; // 计时开始调整位置

@end

@implementation TKGameCardView

- (void)dealloc {
    _panGesture = nil;
    _moveTimer = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.f;
        self.isTap = NO;
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCard:)];
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCardView:)];
        
        [_tapGesture requireGestureRecognizerToFail:_panGesture];
        
        [self addGestureRecognizer:_tapGesture];
        [self addGestureRecognizer:_panGesture];
    }
    return self;
}

// 重置碰撞检测区域
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    // 更新碰撞区域
    self.crashTestRect = CGRectInset(self.frame, 20.f, 10.f);
}

- (void)setCardData:(TKGameCardData *)data
{
    _data = data;
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_data.image]];
}

- (void)tapCard:(UITapGestureRecognizer *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tapCardView:)]){
        [self.delegate tapCardView:self];
    }
}

- (void)panCardView:(UIPanGestureRecognizer *)sender
{
    __weak TKGameCardView *me = self;
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            [UIView animateWithDuration:0.25 animations:^{
                [me.superview bringSubviewToFront:me];
                me.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                me.lastMoveTime = [NSDate timeIntervalSinceReferenceDate];
                CGPoint beginPosition = [sender locationInView:me.superview];
                me.startOffset = CGPointMake(me.center.x-beginPosition.x, me.center.y-beginPosition.y);
            }];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint currentPosition = [sender locationInView:me.superview];
            
            if (fabs((currentPosition.x+me.startOffset.x) - me.center.x) > TK_CARD_MOVETIME_MIN || fabs((currentPosition.y+me.startOffset.y) - me.center.y) > TK_CARD_MOVETIME_MIN) {
                [self _timerAction:_moveTimer];
            }
            
            me.center = CGPointMake(currentPosition.x+me.startOffset.x, currentPosition.y+me.startOffset.y);
            me.lastMoveTime = [NSDate timeIntervalSinceReferenceDate];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStatePossible:{
            [UIView animateWithDuration:0.25 animations:^{
                me.transform = CGAffineTransformMakeScale(1.0, 1.0);
                if(me.delegate && [me.delegate respondsToSelector:@selector(dragCardViewEnd:)]){
                    [me.delegate dragCardViewEnd:me];
                }
            } completion:^(BOOL finished) {
                me.startOffset = CGPointZero;
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)_timerAction:(NSTimer *)timer {
    if(self.delegate && [self.delegate respondsToSelector:@selector(dragCardViewChange:)]){
        [self.delegate dragCardViewChange:self];
    }
    if ([_moveTimer isValid]) {
        [_moveTimer invalidate];
        self.moveTimer = nil;
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
