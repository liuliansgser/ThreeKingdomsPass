//
//  TKHomePageViewController.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/8/19.
//  Copyright (c) 2015年 liulian. All rights reserved.
//

#import "TKHomePageViewController.h"
#import "TKGloble.h"

@interface TKHomePageViewController ()

@end

@implementation TKHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationItems
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TK_SCREEN_WIDTH, 44.f)];
    navigationLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont fontWithName:TK_HanSansTFF size:15.f];
    self.navigationItem.titleView = navigationLabel;
    
    NSRange range = NSMakeRange(2, 1);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"三國殺闖關版", nil)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:TK_TraditionalTFF size:20.f] range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHEX(f54343) range:range];
    navigationLabel.attributedText = attributedString;
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
