//
//  NSString+MMNormal.h
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MMNormal)


// 根据汉字获取拼音首字母
+(NSString *)pinyinFirstLetterFromChinese:(NSString *)chinese;



@end

NS_ASSUME_NONNULL_END
