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
    backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backGroundImageView];
    
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

- (void)_createUserHandsView
{
    _handCardsView = [[TKGameUserHandCardsScrollView alloc] initWithFrame:CGRectMake(0.f, TK_SCREEN_HEIGHT-TK_CARD_USERHAND_HEIGHT, TK_SCREEN_WIDTH, TK_CARD_USERHAND_HEIGHT)];
    [self.view addSubview:_handCardsView];
    
    NSMutableArray *cards = [NSMutableArray array];
    for (NSUInteger i = 0; i < 10; i++) {
        [cards addObject:TK_GAME.playCards[i]];
    }
    [_handCardsView updateItemsWithCards:[NSMutableArray arrayWithArray:cards]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
