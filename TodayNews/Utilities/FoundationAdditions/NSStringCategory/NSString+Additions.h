//
//  NSString+Additions.h
//
//  Created by dorayo on 14/11/1.
//  Copyright (c) 2014年 dorayo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Additions)

@end

@interface NSString (URLEncode)
- (NSString *)urlStringByEncodeToPercentEscape;
- (NSString *)urlStringByDecodeFromPercentEscape;
@end

@interface NSString (DocumentPath)
+ (NSString *)pathStringByAppending:(NSString *)str;
@end

@interface NSString (FileName)
- (NSString *)fileNameByAppend:(NSString *)append;
@end

#pragma mark - Personal Infos Validation

// 手机号类型：移动、联通、电信、未知手机号
typedef NS_ENUM(NSInteger, MobilePhoneNumberType){
    MobilePhoneNumberTypeCM=1,
    MobilePhoneNumberTypeCT,
    MobilePhoneNumberTypeCU,
    MobilePhoneNumberTypeUnknown=-1L
};

@interface NSString (PersonalInfoValidation)
// 手机号
/**
 *  判断字符串是否为手机号
 *
 *  @return 是/否
 */
- (BOOL)isValidMobilePhone;
- (MobilePhoneNumberType)mobilePhoneNumberType;

/**
 *  判断字符串是否为合法身份证号
 *
 *  @param Id 身份证号码
 *
 *  @return 是/否
 */
- (BOOL)isValidIdentityId;

// Email
- (BOOL)isValidEmailAddress;

/**
 *  判断字符串是否为真实姓名
 *
 *  @param name 姓名
 *
 *  @return 是/否
 */
- (BOOL)isLegalRealName;

/**
 * 判断字符串是否符合正则表达式规则
 * @param string 字符串
 * @return 是/否
 */
- (BOOL)isAccordWithRegex:(NSString *)regex;

@end

@interface NSString (Size)
/*
 * 返回字符串高度
 */
+ (CGSize)sizeForText:(NSString *)text maxWidth:(CGFloat)maxWidth fontSize:(CGFloat)size;
@end

@interface NSString (Translate)
/**
 *  从给定的对象中获取有效字符串
 *
 *  @param obj 源数据
 *
 *  @return 返回获取到的字符串对象
 */
+ (instancetype)getValidStringWithObject:(id)obj;

/**
 *  汉字转大写拼音
 *
 *  @param sourceString 汉字
 *
 *  @return 大写拼音
 */
+ (NSString *) pinyinFromChinese:(NSString*)sourceString;

+(NSString *) utf8ToUnicode:(NSString *)string;
@end
