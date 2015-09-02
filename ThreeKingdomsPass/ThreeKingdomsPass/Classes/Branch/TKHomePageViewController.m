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

@interface TKHomePageViewController ()

@property (nonatomic, strong) FBShimmeringView *shimmeringView;

@end

@implementation TKHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backGroundImageView.image = [UIImage imageNamed:@"background.jpg"];
    backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backGroundImageView];
    
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
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TK_SCREEN_WIDTH, 44.f)];
    navigationLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont fontWithName:TK_HanSansTFF size:20.f];
    navigationLabel.textColor = [UIColor whiteColor];
    
    NSRange range = NSMakeRange(2, 1);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"三國殺闖關版", nil)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:TK_TraditionalTFF size:30.f] range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHEX(f54343) range:range];
    [attributedString addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:range];
    navigationLabel.attributedText = attributedString;
    
    _shimmeringView.contentView = navigationLabel;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat width = 135.f;
    _shimmeringView.frame = CGRectMake((TK_SCREEN_WIDTH-width)/2, 0, width, 44.f);
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
