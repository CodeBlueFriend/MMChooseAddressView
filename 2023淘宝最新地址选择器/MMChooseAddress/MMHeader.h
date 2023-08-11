//
//  MMHeader.h
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/7.
//

#ifndef MMHeader_h
#define MMHeader_h
#import "MMChooseAddressView.h"
#import "UIView+MMNormal.h"
#import "NSString+MMNormal.h"
#import "MMChooseAddressCell.h"
#import "MMAddressSelectedView.h"
#import "MJExtension.h"
#import "UIView+Frame.h"

#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define kPFFont(s) [UIFont fontWithName:@"PingFangSC-Regular" size:s]
#define MM_kBoldFont(s) [UIFont fontWithName:@"PingFangSC-Semibold" size:s]

#define kColor333333 [UIColor colorWithHexString:@"333333"]
#define ClearColor [UIColor clearColor]
#define WhiteColor [UIColor whiteColor]




#define ValidStr(f) (f!=nil && ![f isKindOfClass:[NSNull class]] && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define MM_SafeStr(f) (ValidStr(f) ? f:@"")


#if DEBUG

#define DLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else

#define DLog(FORMAT, ...) nil
#endif

#endif /* MMHeader_h */



