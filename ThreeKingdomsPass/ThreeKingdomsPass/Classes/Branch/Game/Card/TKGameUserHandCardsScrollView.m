//
//  TKGameUserHandCardsScrollView.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKGameUserHandCardsScrollView.h"
#import "TKGloble.h"
#import "TKGameCardView.h"
#import "NSArray+BlocksKit.h"

@interface TKGameUserHandCardsScrollView () <TKGameCardViewDelegate>

@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) TKRoleData *role;

@end

@implementation TKGameUserHandCardsScrollView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:.2f alpha:.8f];
        self.showsHorizontalScrollIndicator = NO;
        self.clipsToBounds = NO;
        self.views = [NSMutableArray array];
        self.isDropStatus = NO;
    }
    return self;
}

- (void)setUpRole:(TKRoleData *)role
{
    self.role = role;
}

- (void)updateItemsWithCards
{
    for (TKGameCardView *cardView in self.subviews) {
        if ([cardView isKindOfClass:[TKGameCardView class]]) {
            [cardView removeFromSuperview];
        }
    }
    
    [self.role.handcards enumerateObjectsUsingBlock:^(TKGameCardData *data, NSUInteger idx, BOOL *stop) {
        TKGameCardView *cardView = [[TKGameCardView alloc] initWithFrame:CGRectMake(1.f+idx*(TK_CARD_USERHAND_WIDTH+1.f), 1.f, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT)];
        [cardView setCardData:data];
        cardView.delegate = self;
        cardView.tag = idx+100;
        [self addSubview:cardView];
        [self.views addObject:cardView];
        
    }];
    self.contentSize = CGSizeMake(1.f+[self.role.handcards count]*(TK_CARD_USERHAND_WIDTH+1.f), 0);
}

- (void)addSingleCardData:(TKGameCardData *)data
{
    CGRect start = CGRectMake(1.f+[self.role.handcards count]*(TK_CARD_USERHAND_WIDTH+1.f)+TK_CARD_USERHAND_WIDTH/2, 1.f-TK_CARD_USERHAND_HEIGHT/2, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT);
    CGRect end = CGRectMake(1.f+[self.role.handcards count]*(TK_CARD_USERHAND_WIDTH+1.f), 1.f, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT);
    
    TKGameCardView *cardView = [[TKGameCardView alloc] initWithFrame:start];
    [cardView setCardData:data];
    cardView.transform = CGAffineTransformMakeRotation(M_PI_2/2);
    cardView.delegate = self;
    cardView.tag = [self.role.handcards count]+100;
    [self addSubview:cardView];
    
    [self.views addObject:cardView];
    
    [self _updateContentSize];
    
    [UIView animateWithDuration:0.25 animations:^{
        cardView.transform = CGAffineTransformMakeRotation(0);
        cardView.frame = end;
    } completion:^(BOOL finished) {
        [self.role getCardFromPlayCardsWithCount:1];
    }];
}

- (void)tapCardView:(TKGameCardView *)view
{
    NSArray *tap = [self.views bk_select:^BOOL(TKGameCardView *view) {
        return view.isTap;
    }];
    NSInteger n = [tap count];
    for(NSInteger i = 0; i < n; i++){
        TKGameCardView *cardView = (TKGameCardView *)tap[i];
        [UIView animateWithDuration:0.25 delay:0.03*i options:UIViewAnimationOptionCurveEaseOut animations:^{
            cardView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            cardView.isTap = NO;
        }];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        view.transform = view.isTap?CGAffineTransformIdentity:CGAffineTransformMakeTranslation(0, -10);
        view.isTap = !view.isTap;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dragCardViewChange:(TKGameCardView *)view
{
    NSInteger insertIndex = view.tag;
    NSInteger isDrag = 0;
    [self _calculateDragArea:&isDrag andInsertIndex:&insertIndex forCardView:view];
    [self _adjustAreaItem:view insertIndex:insertIndex];
}

- (void)_calculateDragArea:(NSInteger *)areaNum andInsertIndex:(NSInteger *)insertIndex forCardView:(TKGameCardView *)view
{
    *insertIndex = [self _confirmTheInsertIndexWithArray:[self.views copy] forCardView:view];
    *areaNum = -1;
}

- (NSInteger)_confirmTheInsertIndexWithArray:(NSArray *)array forCardView:(TKGameCardView *)view
{
    NSInteger insertIndex = array.count;
    for (NSInteger i = 0;i < array.count; i++) {
        TKGameCardView *card = (TKGameCardView *)array[i];
        if (CGRectIntersectsRect(view.frame, card.crashTestRect)) {
            insertIndex = i;
            break;
        }
    }
    
    return insertIndex;
}

- (void)_adjustAreaItem:(TKGameCardView *)view insertIndex:(NSInteger)insertIndex
{
    if (view.tag == insertIndex) {
        return;
    }
    
    NSMutableArray *views = self.views;
    NSMutableArray *cards = self.role.handcards;
    
    NSObject *objTemp = [self.role.handcards objectAtIndex:(view.tag-100)];
    [views removeObjectAtIndex:(view.tag-100)];
    [cards removeObjectAtIndex:(view.tag-100)];
    if (insertIndex >= views.count) {
        [views addObject:view];
        [cards addObject:objTemp];
    }else{
        [views insertObject:view atIndex:insertIndex];
        [cards insertObject:objTemp atIndex:insertIndex];
    }
    
    NSInteger exceptionIndex = [views indexOfObject:view];
    [views enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(TKGameCardView *)obj setTag:-1];
    }];
    view.tag = exceptionIndex;
    [self _layoutExceptIndex:exceptionIndex];
}

- (void)_layoutExceptIndex:(NSInteger)exceptIndex
{
    NSInteger n = [self.role.handcards count];
    for(NSInteger i = 0; i < n; i++){
        TKGameCardView *cardView = (TKGameCardView *)self.views[i];
        cardView.tag = i+100;
        cardView.transform = CGAffineTransformIdentity;
        cardView.isTap = NO;
        CGRect rect = CGRectMake(1.f+i*(TK_CARD_USERHAND_WIDTH+1.f), 1.f, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT);
    
        if (exceptIndex == i) {
            //重置碰撞区域
            cardView.crashTestRect = CGRectInset(rect, 20.f, 10.f);
            continue;
        }
        [UIView animateWithDuration:0.25 delay:0.03*i options:UIViewAnimationOptionCurveEaseOut animations:^{
            cardView.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)_layoutDropIndex:(NSInteger)dropIndex
{
    NSInteger n = [self.role.handcards count];
    for(NSInteger i = dropIndex; i < n; i++){
        TKGameCardView *cardView = (TKGameCardView *)self.views[i];
        cardView.tag = i+100;
        cardView.transform = CGAffineTransformIdentity;
        cardView.isTap = NO;
        CGRect rect = CGRectMake(1.f+i*(TK_CARD_USERHAND_WIDTH+1.f), 1.f, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT);
        
        if (dropIndex == i) {
            //重置碰撞区域
            cardView.crashTestRect = CGRectInset(rect, 20.f, 10.f);
            continue;
        }
        [UIView animateWithDuration:0.25 delay:0.03*i options:UIViewAnimationOptionCurveEaseOut animations:^{
            cardView.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)dragCardViewEnd:(TKGameCardView *)view
{
    if (self.isDropStatus) {
        //弃牌
        if (fabs(CGRectGetMinY(view.frame)) >= TK_SCREEN_HEIGHT/4.f) {
            [self.views removeObjectAtIndex:(view.tag-100)];
            [self.role.handcards removeObjectAtIndex:(view.tag-100)];
            [self _layoutDropIndex:(view.tag-100)];
            [view removeFromSuperview];
            [self _updateContentSize];
            [self.role dropCard:[[TKGloble sharedInstance] cardWithCardID:view.data.cardID]];
            return;
        }
    }
    
    NSUInteger index = view.tag;
    CGRect rect = CGRectMake(1.f+(index-100)*(TK_CARD_USERHAND_WIDTH+1.f), 1.f, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT);
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)_updateContentSize
{
    self.contentSize = CGSizeMake(1.f+[self.role.handcards count]*(TK_CARD_USERHAND_WIDTH+1.f), 0);
    NSUInteger page = [self.role.handcards count]/12;
    if (([self.role.handcards count])%12 == 0) page--;
    CGFloat x = (12*(TK_CARD_USERHAND_WIDTH+1.f))*page;
    [self setContentOffset:CGPointMake(x, 0) animated:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
