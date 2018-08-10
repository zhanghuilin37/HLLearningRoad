//
//  LRTools.m
//  demo
//
//  Created by Zhl on 16/7/1.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "LRTools.h"
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
@implementation LRTools
/**
 *  生成前后两种颜色的属性文本
 *
 *  @param str         原字符串
 *  @param firstColor  前部颜色
 *  @param secondColor 后部颜色
 *  @param index       后部颜色的首字母的index
 *
 *  @return 两种颜色的属性文本
 */
+(NSAttributedString*)hl_manageStr:(NSString*)str WithFirstColor:(UIColor*)firstColor andSecondColor:(UIColor *)secondColor andSeparateIndex:(NSInteger)index{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange firstRange = {0,index};
    NSRange secondRange = {index,attString.length-index};
    [attString addAttribute:NSForegroundColorAttributeName value:firstColor range:firstRange];
    [attString addAttribute:NSForegroundColorAttributeName value:secondColor range:secondRange];
    return attString;
}
/**
 *  获取随机颜色
 *
 *  @return UIColor
 */
+(UIColor *)hl_colorWithRandom{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
    
}



/**
 *
 *  产生颜色图片
 *
 *  @param color uicolor
 *
 *  @return uiimage
 */
+ (UIImage *)hl_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



/**
 *  十六进制颜色转换成
 *
 *  @param stringToConvert // 例如： @"#123456"
 
 *
 *  @return UIColor
 */
+ (UIColor *)hl_colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    NSInteger r = (hex >> 16) & 0xFF;
    NSInteger g = (hex >> 8) & 0xFF;
    NSInteger b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

//弹出提示对话框
+(void)hl_showAlertViewWithString:(NSString *)string
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
}
/**
 *  获取字符串的Size
 *
 *  @param words 字符串
 *  @param font  字体大小
 *  @param cSize 最大的size
 *
 *  @return CGSize
 */
+(CGSize)hl_getFontSizeWithString:(NSString *)words font:(UIFont *)font constrainSize:(CGSize)cSize
{
    CGSize size = CGSizeMake(0, 0);
    if (words != nil) {
        if ([self hl_isIOS7OrLater]) {
            
            size = [words boundingRectWithSize:CGSizeMake(cSize.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
            
        }
        else
        {
            
            size = [words boundingRectWithSize:CGSizeMake(cSize.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
            
        }
        
    }
    
    return size;
    
}


/**
 *  判断系统版本号
 *
 *  @return BOOL
 */
+(BOOL)hl_isIOS7OrLater
{
    BOOL isIOS7 = NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        isIOS7 = YES;
    }
    
    //#ifndef __CPBao_OS_SDK_V7__
    //    isIOS7 = NO;
    //#endif
    
    return isIOS7;
}



/**
 *  MD5加密
 *
 *  @param stamp 时间戳
 *  @param token userToken
 *
 *  @return 加密后的串
 */
+(NSString *)hl_getMD5StringWithStamp:(NSString *)stamp token:(NSMutableString *)token
{
    if (stamp == nil) {
        NSDate *date = [NSDate date];
        NSDateFormatter *dataformatter=[[NSDateFormatter alloc]init];
        [dataformatter setDateFormat:@"yyyyMMddHHmmss"];
        stamp = [dataformatter stringFromDate:date];
    }
    NSMutableString *md5String = [[NSMutableString alloc] init];
    [md5String appendString:token];
    //创建数字与串之间的对应关系
    NSArray *numArray = [NSArray arrayWithObjects:@"#:",@":@",@"@~",@"~-",@"-%",@"%&",@"&*",@"*<",@"<>",@">#", nil];
    
    //获取时间戳的倒数第三位
    NSString *key = nil;
    if (stamp != nil && [stamp length] == 14) {
        key = [stamp substringWithRange:NSMakeRange([stamp length] - 3, 1)];
    }
    
    //token拼接倒数第三位对应的串
    [md5String appendString:numArray[[key integerValue]]];
    
    //针对这个字符串   做stamp 后两位次数再加20次的md5循环
    
    
    NSInteger times = 20 + [[stamp substringWithRange:NSMakeRange([stamp length] - 2, 2)] integerValue];
    
    for (int i = 0; i < times; i ++) {
        md5String = (NSMutableString *)[self hl_md5:md5String];
    }
    
    return md5String;
}
+ (NSString *)hl_md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    
    //    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //    return (NSString *)result;
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
/**
 *  跳转浏览器
 *
 *  @param url url
 */
+(void) hl_jumpSafariWithUrl:(NSString*) url
{
    NSLog(@"url = %@", url);
    //    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSString* textURL = [url stringByReplacingOccurrencesOfString:@"%0A" withString:@""];
    NSLog(@"jumpSafariWithUrl = %@", url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jumpSafariWithUrl en === %@", url);
    
    NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",url]];
    [[UIApplication sharedApplication] openURL:cleanURL];
}
/**
 *  是否包含指定字符（ios8以后有官方方法）
 *
 *  @param str          母串
 *  @param sourceString 要查找的字符串
 *
 *  @return BOOL
 */
+(BOOL)hl_containString:(NSString *)str sourceString:(NSString *)sourceString
{
    BOOL isContain = NO;
    if ((sourceString != nil) && (str != nil)) {
        if (!([sourceString rangeOfString:str].location == NSNotFound)) {
            isContain = YES;
        }
    }
    
    return isContain;
}

/**
 *  生成新尺寸图片
 *
 *  @param image 原image
 *  @param size  新尺寸
 *
 *  @return UIImage
 */
+(UIImage*) hl_OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

/**
 *  通过NSDictionary 生成 json串
 *
 *  @param prettyPrint
 *  @param dic
 *
 *  @return 字符串
 */
+(NSString*)hl_jsonStringWithPrettyPrint:(BOOL) prettyPrint dic:(NSDictionary *)dic
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

/**
 *  通过字典生成 带等号的字符串
 *
 *  @param dic dic
 *
 *  @return 转换后的串
 */
+(NSString *)hl_jsonEqualWithDic:(NSDictionary *)dic
{
    NSArray *array = [dic allKeys];
    NSMutableString *jsonStr = [[NSMutableString alloc] init];
    
    for (NSString *key in array) {
        NSString *value = dic[key];
        [jsonStr appendFormat:@"%@=%@&",key,value];
    }
    
    [jsonStr deleteCharactersInRange:NSMakeRange([jsonStr length] - 1, 1)];
    return jsonStr;
}



//三位一个，加逗号
+ (NSString *)hl_countNumAndChangeformat:(NSString *)nums{
    NSString *num = [NSString stringWithFormat:@"%.2f",[nums doubleValue]];
    NSRange range = [num rangeOfString:@"."];
    NSString *str1 = [num substringFromIndex:range.location];
    NSString *str = [num substringToIndex:range.location];
    NSMutableString *string = [NSMutableString stringWithString:str];
    NSMutableString *newstring = [NSMutableString stringWithString:str];
    int x = ([newstring length] % 3);
    int j = 0;
    for(int i =0; i < [newstring length]; i++)
    {
        if (i != 0) {
            
            if ((x == 0) & (i % 3 == 0)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
            if ((x == 1) & (i % 3 == 1)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
            if ((x == 2) & (i % 3 == 2)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
        }
        j++;
    }
    return [NSString stringWithFormat:@"%@%@",string,str1];
    //    return string;
}


/**
 *  呼叫电话
 *
 *  @param num 手机号码
 */
+ (void)hl_callTelphoneWithNum:(NSString *)num {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",num];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
/**
 *  发短信
 *
 *  @param num 手机号码
 */
+(void)hl_sendMessageWithNum:(NSString *)num{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"sms://%@",num];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    
}
/**
 *  获取DocumentPath
 *
 *  @return NSString
 */
+(NSString*)hl_getDocumentPath {
    //Creates a list of directory search paths.-- 创建搜索路径目录列表。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //常量NSDocumentDirectory表面我们正在查找的Document目录路径，
    //常量NSUserDomainmask表明我们希望将搜索限制于我们应用程序的沙盒中。
    return [paths objectAtIndex:0];
    //这样我们就可以得到该数组的第一值，也仅此一值，因为每一个应用程序只有一个Document文件夹。
}




/**
 *  根据时间字符串返回与当前时间的时间差
 *
 *  @param theDate 目标时间
 *
 *  @return NSTimeInterval 时间差
 */
+ (NSTimeInterval)hl_intervalSinceNow:(NSString *)theDate
{
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d = [date dateFromString:theDate];
    
    NSTimeInterval late = [d timeIntervalSince1970];
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    
    NSTimeInterval cha = late-now;
    
    return cha;
}


/**
 *  1灰色  2  3  4 反色
 *
 *  @param
 *
 *  @return 图片置灰
 */
+(UIImage*) hl_grayscale:(UIImage*)anImage type:(char)type {
    CGImageRef  imageRef;
    imageRef = anImage.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    
    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            
            switch (type) {
                case 1:
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                    
                case 2://
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                    
                case 3://
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                    
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
            
        }
    }
    
    
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}
//获取时间戳
+(NSString *)hl_getStamp
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dataformatter=[[NSDateFormatter alloc]init];
    [dataformatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *locationString=[dataformatter stringFromDate:date];
    return locationString;
    
}
//两个日期之间相差的天数
+(NSInteger)hl_numberOfDaysBetween:(NSString *)start and:(NSString *)end
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //    [f setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [f setDateFormat:@"yyyy-MM-dd"];
    
    //只计算日  不计算时分秒
    NSDate *startDate = [f dateFromString:[start substringToIndex:10]];
    NSDate *endDate = [f dateFromString:[end substringToIndex:10]];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    
    return [components day];
}

//获取当前时间
+(NSString *)hl_getCurrentTimeWithFormatStr:(NSString*)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//+(NSString*)getClearWebUrl
//{
//    
//    /*
//     * 参数data={"cookie": ,"token": ,"v": ,"pt": ,"tmp": ,"encToken": ,"other": {}}
//     */
//    
//    NSMutableDictionary* json = [[NSMutableDictionary alloc] init];
//    NSString *cookie = [self getHWCookie];
//    [json setObject:cookie forKey:@"cookie"];
//    
//    NSString *token = [self getUserToken];
//    if (token == nil) {
//        token = @"";
//    }
//    [json setObject:token forKey:@"token"];
//    
//    [json setObject:LR_VERSION_CODE forKey:@"v"];
//    [json setObject:@"ios" forKey:@"pt"];
//    [json setObject:[self getStamp] forKey:@"tmp"];
//    NSString *encToken= [self getMD5StringWithStamp:[self getStamp] token:[NSMutableString stringWithString:token]];
//    if (encToken == nil) {
//        encToken = @"";
//    }
//    [json setObject:encToken forKey:@"encToken"];
//    NSError *error;
//    NSData* jsonDate = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
//    
//    NSString* paramsString = [[NSString alloc] initWithData:jsonDate encoding:NSUTF8StringEncoding];
//    return paramsString;
//}
//通过事件响应者链获取视图的控制器
+ (UIViewController *)hl_getViewControllerWithView:(UIView *)view {
    UIResponder *next = view.nextResponder;
    
    do {
        
        //判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}
//去掉换行符

+(NSString *)hl_replaceBRString:(NSString *)url
{
    NSMutableString *responseString = [NSMutableString stringWithString:url];
    NSString *search = @"\n";
    NSString *replace = @"";
    
    NSRange substr = [responseString rangeOfString:search];
    
    while (substr.location != NSNotFound) {
        [responseString replaceCharactersInRange:substr withString:replace];
        substr = [responseString rangeOfString:search];
    }
    
    return responseString;
}

//手机号码验证
+(BOOL)hl_validateMobile:(NSString *)mobile
{
    
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSLog(@"%d",[phoneTest evaluateWithObject:mobile]);
    
    //    if ([phoneTest evaluateWithObject:mobile] == NO) {
    //        UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alerView show];
    //    }
    
    
    //     return [phoneTest evaluateWithObject:mobile];
    
    if (mobile != nil && [mobile length] == 11) {
        return YES;
        
    }
    return NO;
}

//身份证号
+ (BOOL) hl_validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//汉字转拼音
+(NSString *)hl_pinyinWithText:(NSString *)hanziText
{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:@""];
    
    if ([hanziText length]) {
        ms = [[NSMutableString alloc] initWithString:hanziText];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        }
    }
    [ms replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, ms.length)];
    return [ms lowercaseString];
}

//判断输入字符是否在26个字母里

+(BOOL)hl_isAlphabetContainsChar:(NSString *)str
{
    
    if (str != nil && str.length == 1) {
        NSArray *alphabetArray = [NSArray arrayWithObjects:                         @"a",@"b",@"c",@"d",@"e",@"f",@"g",
                                  @"h",@"i",@"j",@"k",@"l",@"m",@"n",
                                  @"o",@"p",@"q",@"r",@"s",@"t",
                                  @"u",@"v",@"w",@"x",@"y",@"z",nil];
        if ([alphabetArray containsObject:str]) {
            return YES;
        }
    }
    
    return NO;
}

+(NSString *)hl_decodeFromPercentEscapeString:(NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    [outputStr replaceOccurrencesOfString:@"\n"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//获取字母表数组
+(NSArray *)hl_getAlphaBetNumbers
{
    NSArray *array=@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
    return array;
    
}

+(NSDate *)hl_getCurrentDate
{
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSDate *)hl_dateWithString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *endDate = [dateFormatter dateFromString:dateString];
    
    return endDate;
}


/**
 *  创建矩形渐变图层
 *
 *  @param frame      渐变图层的frame
 *  @param startColor 起始颜色（设置起止颜色的时候可以设置颜色的透明度达到透明度渐变的效果）
 *  @param endColor   终止颜色
 *  @param kind       渐变类型
 *                    GradientLayerKindLeftRight = 1,//左-右
 *                    GradientLayerKindUpDown,       //上-下
 *                    GradientLayerKindLBRT,         //左下-右上
 *                    GradientLayerKindLTRB          //左上-右下
 *  @return 渐变色layer
 */
- (CALayer*)hl_getGradientLayerWithFrame:(CGRect)frame StartColor:(UIColor *)startColor endColor:(UIColor*)endColor andKind:(GradientLayerKind)kind{
    //渐变图层
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = frame;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[startColor CGColor],(id)[endColor CGColor], nil]];
    /*
     (0,0)* * * * * * *(1,0)
     *           |
     *           |
     *           |
     *           |
     *           |
     (0,1)*----------- (1,1)
     */
    if (kind == GradientLayerKindUpDown) {
        [gradientLayer setLocations:@[@0,@1]];
        
        [gradientLayer setStartPoint:CGPointMake(0.5, 0)];
        
        [gradientLayer setEndPoint:CGPointMake(0.5, 1)];
    }else if (kind == GradientLayerKindLeftRight){
        [gradientLayer setLocations:@[@0,@1]];
        
        [gradientLayer setStartPoint:CGPointMake(0, 0.5)];
        
        [gradientLayer setEndPoint:CGPointMake(1, 0.5)];
    }else if (kind == GradientLayerKindLTRB){
        [gradientLayer setLocations:@[@0,@1]];
        
        [gradientLayer setStartPoint:CGPointMake(0, 0)];
        
        [gradientLayer setEndPoint:CGPointMake(1, 1)];
    }else if (kind == GradientLayerKindLBRT){
        [gradientLayer setLocations:@[@0,@1]];
        
        [gradientLayer setStartPoint:CGPointMake(0, 1)];
        
        [gradientLayer setEndPoint:CGPointMake(1, 0)];
    }
    
    return gradientLayer;
}
//获取当前控制器
+(UINavigationController *)hl_getCurrentNav
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.rootNav;
    
}
/**
 *  获取匹配的字符串
 *
 *  @param str 原字符串
 *
 *  @return NSArray<NSTextCheckingResult *> *
 */
-(NSArray<NSTextCheckingResult *> *)hl_getBBSLetterSubStrRangeArrWithStr:(NSString *)str{
    /*
            .               匹配除换行符以外的任意字符
            \w              数字，字母，下划线，汉字等
            \s              匹配任意的空白符包括空格，制表符(Tab)，换行符，中文全角空格等。
            \d              匹配一位数字
            \b              匹配单词的开始或结束
            ^               以后面的为开头
            $               以前面的为结尾

            -               不是元字符，只匹配它本身
            *               前边的内容可以连续重复使用任意次（包括0次）以使整个表达式得到匹配
            +               前边的内容可以连续重复使用1次或1次以上以使整个表达式得到匹配
            ?               重复0或一次
            {n}             重复n次
            {n,}            重复n次或更多次
            {n,m}           重复n到m次
            \               在匹配特殊字符时要用的转移字符，包括\本身
            |               或者
            \u4E00-\u9FA5   中文
     */
    //[...]表情
    NSString *emopattern=@"\\[[\u4e00-\u9fa5\\w]+\\]" ;
    //#...#话题
    NSString *toppattern =  @"#[^#]+#";
    //@...@ @"@[\u4e00-\u9fa5\\w]+"
    NSString *atpattern = @"@+";
    //url
    NSString *urlpattern = @"http://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
    NSString *urlpattern1 = @"https://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",emopattern,toppattern,atpattern,urlpattern,urlpattern1];
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *results = [regular matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    return results;
}
/**
 *  在View上添加虚线（横向或纵向）
 *
 *  @param view  要添加虚线的view
 *  @param point 起始点
 *  @param size  size.width:虚线的 宽度      size.height:线粗
 *  @param isHorizontal 是否是水平方向
 */
+(void)drawLineInView:(UIView*)view fromPoint:(CGPoint)point lineSize:(CGSize)size isHorizontal:(BOOL)isHorizontal{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    line.clipsToBounds = YES;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:line.bounds];
    [shapeLayer setPosition:CGPointMake(line.bounds.size.width/2.0, line.bounds.size.height/2.0)];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[rgb(100, 100, 100, 1) CGColor]];
    
    // 0.2f设置虚线的宽度（粗细）
    [shapeLayer setLineWidth:2.0f];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:2],
      [NSNumber numberWithInt:2],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (isHorizontal) {
        CGPathAddLineToPoint(path, NULL, line.frame.size.width,0);
    }else{
        CGPathAddLineToPoint(path, NULL, 0, line.frame.size.height);
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    shapeLayer.masksToBounds = YES;
    [[line layer] addSublayer:shapeLayer];
    [view addSubview:line];
}

#pragma mark - 设置view的圆角
//通过设置layer 切圆角，是最常用的，也是最耗性能的
+ (void)setLayerCutCirculayWithView:(UIView *) view roundedCornersSize:(CGFloat )cornersSize{
    view.layer.masksToBounds = YES;
    // 设置圆角半径
    view.layer.cornerRadius = cornersSize;
    
}

// 通过layer和bezierPath 设置圆角
+ (void)setLayerAndBezierPathCutCircularWithView:(UIView *) view roundedCornersSize:(CGFloat )cornersSize{
    
    // 创建BezierPath 并设置角 和 半径 这里只设置了 左上 和 右上
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornersSize, cornersSize)];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    layer.frame = view.bounds;
    
    layer.path = path.CGPath;
    
    view.layer.mask = layer;
    
}

//通过Graphics 和 BezierPath 设置圆角（推荐）

+ (void)setGraphicsCutCirculayWithView:(UIImageView *) view roundedCornersSize:(CGFloat )cornersSize
{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1.0);
    
    [[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornersSize] addClip];
    
    [view drawRect:view.bounds];
    
    view.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束
    
    UIGraphicsEndImageContext();
    
}



#pragma mark ---------------------------------------------快捷创建控件
+(UIButton *)hl_buttonWithType:(UIButtonType)type frame:(CGRect)frame title:(NSString *)title target:(NSObject*)objc action:(SEL)sel event:(UIControlEvents)event{
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:objc action:sel forControlEvents:event];
    return btn;
}
@end
