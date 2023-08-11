//
//  UIView+Frame.h
//  EMeal_Cook
//
//  Created by Wujg on 15/7/16.
//  Copyright (c) 2015年 Wujg. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define kScreen_Height  [UIScreen mainScreen].bounds.size.height
//
//#define kScreen_Width   [UIScreen mainScreen].bounds.size.width




@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGFloat width_w;
@property (nonatomic, assign) CGFloat height_h;


@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

@end
