//
//  MMAddressDataModel.h
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMAddressDataModel : NSObject


@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *firstLetter;//第一个字母

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, strong) NSArray *children;

/*
 交互使用 是否选中高亮
 */
@property (nonatomic, assign) CGFloat selected;


@end

NS_ASSUME_NONNULL_END
