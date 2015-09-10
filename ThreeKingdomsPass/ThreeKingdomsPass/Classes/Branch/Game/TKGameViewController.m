//
//  TKGameViewController.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/8/25.
//  Copyright (c) 2015年 liulian. All rights reserved.
//

#import "TKGameViewController.h"
#import "TKGloble.h"
#import "UIControl+BlocksKit.h"
#import "TKGame.h"
#import "TKGameUserHandCardsScrollView.h"
#import "TKGamePlayCardView.h"

@interface TKGameViewController () <TKGamePlayCardViewDelegate>

@property (nonatomic, strong) TKGameUserHandCardsScrollView *handCardsView;

@end

@implementation TKGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TK_GAME.playCards = [NSMutableArray arrayWithArray:[TK_GAME shuffleTheCardsWithCardsArray:TK_GAME.normalcards]];
    
    [self _createFunctionItems];
    
    [self _createUserHandsView];
    
    [self _createPlayCardView];
    
}

- (void)_createFunctionItems
{
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backGroundImageView.image = [UIImage imageNamed:@"game_background.jpg"];
    backGroundImageView.userInteractionEnabled = YES;
    backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backGroundImageView];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGameView:)];
    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [backGroundImageView addGestureRecognizer:swipeGestureLeft];
    
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGameView:)];
    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [backGroundImageView addGestureRecognizer:swipeGestureRight];
    
    CGFloat startButtonFontSize = TK_SCREEN_5S(15.f);
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(0, 0, startButtonFontSize*3, startButtonFontSize*2);
    [startButton setTitle:@"投降" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont fontWithName:TK_TraditionalTFF size:startButtonFontSize];
    [startButton bk_addEventHandler:^(UIButton *sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
}

- (void)swipeGameView:(UISwipeGestureRecognizer *)sender
{    
    CGFloat contentSize = _handCardsView.contentSize.width;
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft: {
            if ((_handCardsView.contentOffset.x+_handCardsView.frame.size.width) > contentSize) return;
            [_handCardsView setContentOffset:CGPointMake((_handCardsView.contentOffset.x+12*(TK_CARD_USERHAND_WIDTH+1.f)), 0) animated:YES];
        }
            break;
        case UISwipeGestureRecognizerDirectionRight: {
            if (_handCardsView.contentOffset.x <= 0) return;
            [_handCardsView setContentOffset:CGPointMake((_handCardsView.contentOffset.x-12*(TK_CARD_USERHAND_WIDTH+1.f)), 0) animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)_createUserHandsView
{
    _handCardsView = [[TKGameUserHandCardsScrollView alloc] initWithFrame:CGRectMake(0, TK_SCREEN_HEIGHT-TK_CARD_USERHAND_HEIGHT-2.f, TK_SCREEN_WIDTH, TK_CARD_USERHAND_HEIGHT+2.f)];
    [self.view addSubview:_handCardsView];
    
    NSMutableArray *cards = [NSMutableArray array];
    for (NSUInteger i = 0; i < 8; i++) {
        [cards addObject:TK_GAME.playCards[i]];
    }
    [_handCardsView updateItemsWithCards:[NSMutableArray arrayWithArray:cards]];
}

- (void)_createPlayCardView
{
    TKGamePlayCardView *play = [[TKGamePlayCardView alloc] initWithFrame:CGRectMake(0, 0, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT)];
    play.center = self.view.center;
    play.delegate = self;
    [self.view addSubview:play];
}

- (void)userGetCard
{
    [_handCardsView addCardData:TK_GAME.playCards[30]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
