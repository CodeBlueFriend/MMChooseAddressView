//
//  UIView+MMNormal.m
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/7.
//

#import "UIView+MMNormal.h"

@implementation UIView (MMNormal)

/**普通设置圆角的方法**/
- (void)mm_setNormalCornerRadious:(CGFloat)radious
{
    self.layer.cornerRadius = radious;
    self.layer.masksToBounds = YES;
}

//设置部分圆角  是否设置边框自定
- (void)mm_setPartCornerRadious:(CGFloat)cornerRadius  borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth forRoundingCorners:(UIRectCorner)reactCorner
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:reactCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    CAShapeLayer *maskLayer= [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    
    if (borderWidth > 0) {
        CAShapeLayer *borderLayer = [[CAShapeLayer alloc]init];
        borderLayer.lineWidth = borderWidth;
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.frame = self.bounds;
        borderLayer.path = path.CGPath;
        
        [self.layer insertSublayer:borderLayer atIndex:0];
    }
    
    self.layer.mask = maskLayer;
    
}



@end
