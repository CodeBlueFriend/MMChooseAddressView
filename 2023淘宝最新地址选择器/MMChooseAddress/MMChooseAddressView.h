//
//  MMChooseAddressView.h
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/7.
//

#import <UIKit/UIKit.h>
#import "MMHeader.h"

NS_ASSUME_NONNULL_BEGIN


@protocol MMChooseAddressViewDelegate <NSObject>


-(void)mmChooseAddressViewDidSelectedArr:(NSMutableArray *)selectedArr;

@end
@interface MMChooseAddressView : UIView


@property (nonatomic, weak) id<MMChooseAddressViewDelegate>delegate;


-(void)reloadUI;

-(void)show;

/*
 从外部传入 code 集合  逗号间隔 code1,code2,code3
 */
-(void)setCodesString:(NSString *)codes;



@end

NS_ASSUME_NONNULL_END
