//
//  MMAddressSelectedView.h
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/8.
//

#import <UIKit/UIKit.h>
#import "MMAddressDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MMAddressSelectedViewDelegate <NSObject>

-(void)mmAddressSelectedViewDidTouch:(MMAddressDataModel *)model;


@end
@interface MMAddressSelectedView : UIView

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UIView *centerPoint;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIImageView *rightImgV;


@property (nonatomic, strong) MMAddressDataModel *model;

@property (nonatomic, weak) id<MMAddressSelectedViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
