//
//  NSString+Additions.m
//
//  Created by dorayo on 14/11/1.
//  Copyright (c) 2014年 dorayo.com. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

@end

@implementation NSString (URLEncode)

- (NSString *)urlStringByEncodeToPercentEscape
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)urlStringByDecodeFromPercentEscape
{
    NSMutableString *decodedString = [NSMutableString stringWithString:self];
    [decodedString replaceOccurrencesOfString:@"+"
                                   withString:@" "
                                      options:NSLiteralSearch
                                        range:NSMakeRange(0, [decodedString length])];
    
    return [decodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end

@implementation NSString (DocumentPath)

+ (NSString *)pathStringByAppending:(NSString *)str
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    return [docPath stringByAppendingPathComponent:str];
}

@end

@implementation NSString (FileName)

- (NSString *)fileNameByAppend:(NSString *)append
{
    // 1. 获取不带扩展名的文件名
    NSString *baseName = [self stringByDeletingPathExtension];
    
    // 2. 在baseName上追加字符串
    baseName = [baseName stringByAppendingString:append];
    
    // 3. 取出扩展名
    NSString *extension = [self pathExtension];
    
    // 4. 拼接成新的文件名
    return [baseName stringByAppendingPathExtension:extension];
}

@end

#pragma mark - Personal Infos Validation
@implementation NSString (PersonalInfoValidation)

+(BOOL)isMatchesRegularExpression:(NSString *)string byExpression:(NSString *)regex

{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:string];
    
}

-(BOOL)isValidMobilePhone{
    //检查是否为手机号
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    NSString *telFormat = @"^1(3\\d|4[57]|5[0-35-9]|7[06-8]|8\\d)\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telFormat];
    BOOL isTel = [predicate evaluateWithObject:self];
    return isTel;
}

- (MobilePhoneNumberType)mobilePhoneNumberType
{
    NSString *CMRegex = @"^1(34[0-8]|(3[5-9]|47|5[0-27-9]|78|8[2-478])[0-9])[0-9]{7}$";
    NSString *CURegex = @"^1(3[0-2]|45|5[56]|76|8[56])[0-9]{8}$";
    
    if (![NSString isMatchesRegularExpression:self byExpression:CMRegex]) {
        NSLog(@"Unkown Mobile Phone Number Type!");
        return MobilePhoneNumberTypeUnknown;
    }
    
    MobilePhoneNumberType type = MobilePhoneNumberTypeUnknown;
    
    if ([NSString isMatchesRegularExpression:self byExpression:CMRegex]) {
        NSLog(@"China Mobile");
        type = MobilePhoneNumberTypeCM;
    } else if ([NSString isMatchesRegularExpression:self byExpression:CURegex]) {
        NSLog(@"China Unicom");
        type = MobilePhoneNumberTypeCU;
    } else {
        NSLog(@"China Telecom");
        type = MobilePhoneNumberTypeCT;
    }
    
    return type;
}

- (BOOL)isValidIdentityId{
    //判断位数
    if ([self length] != 15 && [self length] != 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if ([self length] == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++) {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    NSString *sProvince = [carid substringToIndex:2];
    if ([dic objectForKey:sProvince] == nil) {
        return NO;
    }
    
    //判断年月日是否有效
    //年份
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    //月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    //日
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

- (BOOL)isValidEmailAddress
{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]{3,}@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    return [NSString isMatchesRegularExpression:self byExpression:emailRegex];
}

- (BOOL)isLegalRealName
{
    //长度
    NSInteger length = self.length;
    if (length>4 || length<2) { // 真实姓名2到4位
        return NO;
    }
    
    //是否全是汉字
    NSString *regex = @"[\u4e00-\u9fa5]{1,10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:self]) {
        return NO;
    }
    
    //    BOOL isAllChinese = YES;
    //    for(NSInteger i = 0; i < [content length]; i++) {
    //        NSInteger a = [content characterAtIndex:i];
    //        if( a > 0x4e00 && a < 0x9fff) {
    //        } else {
    //            isAllChinese = NO;
    //        }
    //    }
    //    return isAllChinese;
    return YES;
}

- (BOOL)isAccordWithRegex:(NSString *)regex{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

@end

@implementation NSString (Size)


+(CGSize)sizeForText:(NSString *)text maxWidth:(CGFloat)maxWidth fontSize:(CGFloat)size{
    NSDictionary *attri = @{NSFontAttributeName : [UIFont systemFontOfSize:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
    return rect.size;
}

@end

@implementation NSString (Translate)

//汉字转大写拼音
+ (NSString *) pinyinFromChinese:(NSString*)sourceString {
    
    NSMutableString *source = [sourceString mutableCopy];
    
    if(source && sourceString.length>0)
        
    {
        
        CFRange range = CFRangeMake(0, source.length);
        
        CFStringTransform((__bridge CFMutableStringRef)source, &range, kCFStringTransformMandarinLatin, NO);
        
        CFStringTransform((__bridge CFMutableStringRef)source, &range, kCFStringTransformStripDiacritics, NO);
        
        NSMutableString *pinyin = [NSMutableString stringWithString:[source uppercaseString]];
        
        for (int i = 0; i < pinyin.length; i++) {
            int temp = [pinyin characterAtIndex:i];
            
            if ((temp < 65 && temp != 32) || temp > 122 || (temp > 90 && temp < 97)) {
                return nil;
            }
        }
        
        return pinyin;
        
    }else{
        return nil;
    }
    
}


+(NSString *) utf8ToUnicode:(NSString *)string

{
    
    NSUInteger length = [string length];
    
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
    for (int i = 0;i < length; i++)
        
    {
        
        unichar _char = [string characterAtIndex:i];
        
        //判断是否为英文和数字
        if (_char >= 32 && _char <= 126) {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }
        
        if (_char <= '9' && _char >= '0')
            
        {
            
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
        }
        
        else if(_char >= 'a' && _char <= 'z')
            
        {
            
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
            
            
        }
        
        else if(_char >= 'A' && _char <= 'Z')
            
        {
            
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
            
            
        }
        
        else
            
        {
            
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
            
        }
        
    }
    
    return s;
    
}


+ (instancetype)getValidStringWithObject:(id)obj {
    /**
     *  nil->(null)
     *  NSNull-><null>
     */
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = obj;
        if (strValue && ![strValue isEqualToString:@"<null>"]
            && ![strValue isEqualToString:@"(null)"]
            && ![strValue isEqualToString:@""]
            && ![strValue isEqualToString:@"null"]) {
            return strValue;
        } else {
            return @"";
        }
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", obj];
    } else {
        return @"";
    }
}


@end

