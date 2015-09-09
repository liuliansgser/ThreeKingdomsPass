//
//  TKHomePageViewController.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/8/19.
//  Copyright (c) 2015年 liulian. All rights reserved.
//

#import "TKHomePageViewController.h"
#import "TKGloble.h"
#import "FBShimmeringView.h"
#import "UIControl+BlocksKit.h"
#import "TKGameViewController.h"
#import "TransitionHorizontalLinesAnimator.h"

@interface TKHomePageViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) FBShimmeringView *shimmeringView;

@end

@implementation TKHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backGroundImageView.image = [UIImage imageNamed:@"background.jpg"];
    backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backGroundImageView];
    
    self.navigationController.delegate = self;
    
    [self _createBannerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createBannerView
{
    _shimmeringView = [[FBShimmeringView alloc] init];
    _shimmeringView.shimmering = YES;
    _shimmeringView.shimmeringBeginFadeDuration = 0.3;
    _shimmeringView.shimmeringOpacity = 0.3;
    _shimmeringView.shimmeringSpeed = 115;
    [self.view addSubview:_shimmeringView];
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TK_SCREEN_WIDTH, TK_SCREEN_5S(45.f))];
    navigationLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont fontWithName:TK_HanSansTFF size:TK_SCREEN_5S(20.f)];
    navigationLabel.textColor = [UIColor whiteColor];
    
    NSRange range = NSMakeRange(2, 1);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"三國殺闖關版", nil)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:TK_TraditionalTFF size:TK_SCREEN_5S(30.f)] range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHEX(f54343) range:range];
    [attributedString addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:range];
    navigationLabel.attributedText = attributedString;
    
    _shimmeringView.contentView = navigationLabel;
    
    CGFloat startButtonFontSize = TK_SCREEN_5S(15.f);
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(0, 0, startButtonFontSize*5, startButtonFontSize*2);
    startButton.center = self.view.center;
    [startButton setTitle:@"開始遊戲" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont fontWithName:TK_TraditionalTFF size:startButtonFontSize];
    [startButton bk_addEventHandler:^(UIButton *sender) {
        [self.navigationController pushViewController:[TKGameViewController new] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat width = TK_SCREEN_WIDTH/4.f;
    self.shimmeringView.frame = CGRectMake((TK_SCREEN_WIDTH-width)/2, 0, width, TK_SCREEN_5S(45.f));
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    NSObject <UIViewControllerAnimatedTransitioning> *animator;
    BOOL showGame = [toVC isKindOfClass:[TKGameViewController class]];
    animator = [[TransitionHorizontalLinesAnimator alloc] init];
    [(TransitionHorizontalLinesAnimator *)animator setPresenting:showGame];
    return animator;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
