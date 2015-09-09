//
//  TKGameCardView.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKGameCardData.h"

@interface TKGameCardView : UIImageView

- (id)initWithFrame:(CGRect)frame WithCardData:(TKGameCardData *)data;

@end
