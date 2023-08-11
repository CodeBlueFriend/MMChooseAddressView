//
//  NSString+MMNormal.m
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/10.
//

#import "NSString+MMNormal.h"

@implementation NSString (MMNormal)


// 根据汉字获取拼音首字母
+(NSString *)pinyinFirstLetterFromChinese:(NSString *)chinese {
   
    
    //多音字 重庆 朝阳 长安
    if([chinese isEqualToString:@"重"] ||[chinese isEqualToString:@"朝"] ||[chinese isEqualToString:@"长"]  ){
        return @"c";
    }
    

    CFStringRef cfString = (__bridge CFStringRef)chinese;
    CFMutableStringRef mutableString = CFStringCreateMutableCopy(NULL, 0, cfString);
    CFStringTransform(mutableString, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(mutableString, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinyin = (__bridge_transfer NSString *)mutableString;
    NSString *firstLetter = [pinyin substringToIndex:1];
    return firstLetter;
}


@end
