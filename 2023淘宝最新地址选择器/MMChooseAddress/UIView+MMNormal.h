//
//  UIView+MMNormal.h
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MMNormal)



/**普通设置圆角的方法**/
- (void)mm_setNormalCornerRadious:(CGFloat)radious;

- (void)mm_setPartCornerRadious:(CGFloat)cornerRadius  borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth forRoundingCorners:(UIRectCorner)reactCorner;


@end

NS_ASSUME_NONNULL_END
