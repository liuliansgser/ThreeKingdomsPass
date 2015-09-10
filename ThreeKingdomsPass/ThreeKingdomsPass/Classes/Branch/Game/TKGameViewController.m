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

@interface TKGameViewController ()

@property (nonatomic, strong) TKGameUserHandCardsScrollView *handCardsView;

@end

@implementation TKGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TK_GAME.playCards = [NSMutableArray arrayWithArray:[TK_GAME shuffleTheCardsWithCardsArray:TK_GAME.normalcards]];
    
    [self _createFunctionItems];
    
    [self _createUserHandsView];
    
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
            [_handCardsView setContentOffset:CGPointMake((_handCardsView.contentOffset.x+8*(TK_CARD_USERHAND_WIDTH+1.f)), 0) animated:YES];
        }
            break;
        case UISwipeGestureRecognizerDirectionRight: {
            if (_handCardsView.contentOffset.x <= 0) return;
            [_handCardsView setContentOffset:CGPointMake((_handCardsView.contentOffset.x-8*(TK_CARD_USERHAND_WIDTH+1.f)), 0) animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)_createUserHandsView
{
    CGFloat rightwidth = 135.f;
    CGFloat leftwidth = 95.f;
    
    _handCardsView = [[TKGameUserHandCardsScrollView alloc] initWithFrame:CGRectMake(leftwidth, TK_SCREEN_HEIGHT-TK_CARD_USERHAND_HEIGHT, TK_SCREEN_WIDTH-leftwidth-rightwidth, TK_CARD_USERHAND_HEIGHT)];
    [self.view addSubview:_handCardsView];
    
    NSMutableArray *cards = [NSMutableArray array];
    for (NSUInteger i = 0; i < 10; i++) {
        [cards addObject:TK_GAME.playCards[i]];
    }
    [_handCardsView updateItemsWithCards:[NSMutableArray arrayWithArray:cards]];
    
    UIImageView *userView = [[UIImageView alloc] initWithFrame:CGRectMake(0, TK_SCREEN_HEIGHT-leftwidth, leftwidth, leftwidth)];
    userView.backgroundColor = [UIColor clearColor];
    userView.image = [UIImage imageNamed:@"game_background_left.jpg"];
    userView.userInteractionEnabled = YES;
    [self.view addSubview:userView];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(TK_SCREEN_WIDTH-rightwidth, TK_SCREEN_HEIGHT-rightwidth, rightwidth, rightwidth)];
    iconView.backgroundColor = [UIColor clearColor];
    iconView.image = [UIImage imageNamed:@"game_background_right.jpg"];
    iconView.userInteractionEnabled = YES;
    [self.view addSubview:iconView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
