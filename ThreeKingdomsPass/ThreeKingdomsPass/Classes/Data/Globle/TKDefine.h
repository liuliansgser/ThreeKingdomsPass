//
//  TKDefine.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/8/19.
//  Copyright (c) 2015年 liulian. All rights reserved.
//

#ifndef ThreeKingdomsPass_TKDefine_h
#define ThreeKingdomsPass_TKDefine_h

//single
#define TK_SINGLETION_h(__clazz) \
+ (instancetype)sharedInstance;

#define TK_SINGLETION_m(__clazz) \
+ (instancetype)sharedInstance \
{\
static dispatch_once_t once; \
static id __singletion;\
dispatch_once(&once,^{__singletion = [[self alloc] init];});\
return __singletion;\
}

#define TK_SINGLETION(__clazz) [__clazz sharedInstance]

//screen
#define TK_SCREEN_WIDTH TK_SINGLETION(TKGloble).globleWidth
#define TK_SCREEN_HEIGHT TK_SINGLETION(TKGloble).globleHeight

//delegate
#define TK_DELEGATE [TK_SINGLETION(TKGloble) delegate]

//font
#define TK_TraditionalTFF @"HiraMinProN-W6"
#define TK_HanSansTFF @"SourceHanSansCN-Medium"

//color
#define RGBINT(num) [UIColor                          \
colorWithRed: (float)((num>>16)&0xff) / 0xff        \
green: (float)((num>>8)&0xff)  / 0xff        \
blue: (float)((num)&0xff)     / 0xff        \
alpha: 1.0]                                  \

#define RGBHEX( num ) RGBINT( 0x##num )


#endif
