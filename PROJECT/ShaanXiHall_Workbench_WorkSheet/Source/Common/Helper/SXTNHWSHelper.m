//
//  SXTNHWSHelper.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSHelper.h"
#import "SXTNHWSMacros.h"
#import <YYModel/YYModel.h>

@implementation SXTNHWSHelper

+ (void)showHUDText:(NSString *) text complection:(MBProgressHUDCompletionBlock) compleciton{
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    hud.mode = MBProgressHUDModeText;
//    hud.detailsLabel.text = text;
//    hud.margin = 10.f;
//    hud.offset = CGPointMake(0, (ScreenHeight - 64.0f) / 2.0f - 50.0f);
//    hud.animationType = MBProgressHUDAnimationZoomOut;
//    hud.label.font = [UIFont systemFontOfSize:12];
//    hud.removeFromSuperViewOnHide = YES;
//    [hud hideAnimated:YES afterDelay:2.0f];
    //修改为0.9.2兼容
    hud.detailsLabelText = text;
    hud.labelFont = [UIFont systemFontOfSize:12];
    hud.xOffset = CGPointMake(0, ([UIScreen mainScreen].bounds.size.height - 64.0f) / 2.0f - 50.0f).x;
    hud.yOffset = CGPointMake(0, ([UIScreen mainScreen].bounds.size.height - 64.0f) / 2.0f - 50.0f).y;
    
    //    hud.detailsLabel.text = text;
    hud.margin = 10.f;
    //    hud.offset = CGPointMake(0, (SCREEN_HEIGHT - 64.0f) / 2.0f - 50.0f);
    hud.animationType = MBProgressHUDAnimationZoomOut;
    //    hud.label.font = [UIFont systemFontOfSize:12];
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2.0f];
    //    [hud hideAnimated:YES afterDelay:2.0f];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (compleciton) {
            compleciton();
        }
    });
    
}

+ (NSString *)getCurrentDateWithDate:(NSDate *) date
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:date];
}

+ (NSString *)getCurrentDateWithDateMinutes:(NSInteger) minutes
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] - minutes * 10 * 3600;
    NSDate * UTCDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [SXTNHWSHelper getCurrentDateWithDate:UTCDate];
}

+(NSString *)getNowTimeTimestamp{
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", timestamp];//转为字符型;
    return timeString;
}

+(NSString *)getNowTimeTimestampAfterMonth:(NSInteger) number
{
    NSString * nowTimestamp = [SXTNHWSHelper getNowTimeTimestamp];
    NSTimeInterval nowTimestampIn = [nowTimestamp doubleValue];
    return [NSString stringWithFormat:@"%0.f",nowTimestampIn + number * 30 * 24 * 3600];
    
}

+ (NSString *)getDateStringWithTimestampStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue];//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

//返回colorImage
+ (UIImage*) createImageWithColor:(UIColor *) color{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}


//图片添加水印
+ (UIImage *)watermarkImage:(UIImage *)img withName:(NSString *)name
                  leftMargn:(NSInteger)margn
{
    NSString *mark = name;
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    NSDictionary *attr = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:35], //设置字体
                           NSForegroundColorAttributeName : SXTNHWS_Color(80, 180, 240) //设置字体颜色
                           };
    [mark drawInRect:CGRectMake(margn, 0, w, h - 10) withAttributes:attr]; //左上角
    //    [mark drawInRect:CGRectMake(w - 80, 10, 80, 32) withAttributes:attr];            //右上角
    //    [mark drawInRect:CGRectMake(w - 80, h - 32 - 10, 80, 32) withAttributes:attr];   //右下角
    //    [mark drawInRect:CGRectMake(0, h - 32 - 10, 80, 32) withAttributes:attr];        //左下角
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
}
//修改图片大小
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}
+ (NSData *)zipImageSizeWithImage:(UIImage *)image
{
    NSData * data = UIImageJPEGRepresentation(image, 1);
    
    CGFloat size = data.length / 1000.0f /  1000.0f;
    if (size < 0.1) {
        return data;
    }else{
        NSData * zipData = UIImageJPEGRepresentation(image, 0.1 / size);
        return zipData;
    }
    
}

+ (UIViewController*)activityViewController {
    return [SXTNHWSHelper topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [SXTNHWSHelper topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [SXTNHWSHelper topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [SXTNHWSHelper topViewControllerWithRootViewController:presentedViewController];
    } else {
        
        return rootViewController;
    }
}

+ (NSDictionary *)jsonDic:(NSString *)jsonStr
{
    if (jsonStr) {
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if (!err) {
            return dic;
        }else{
            return nil;
        }
    }
    return nil;
}

+ (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
            
        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //数组或字典,本项目用于转化的model模型属性全是NSString,所以不需要此判断
            //            [dic setObject:[self arrayOrDicWithObject:(NSArray*)value] forKey:name];
            
        } else if (value == nil) {
            //null
            //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
            
        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
    }
    
    return [dic copy];
}

+ (void)showAlertControllerTitle:(NSString *)title
                         message:(NSString *)message
                            sure:(void (^)())sure
                          cancel:(void (^)())cancel
{
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:title
                                                                      message:message
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        if (sure) {
                                                            sure();
                                                        }
                                                    }];
    [alertVc addAction:action];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              if (cancel) {
                                                                  cancel();
                                                              }
                                                          }];
    [alertVc addAction:cancelAction];
    [[SXTNHWSHelper activityViewController] presentViewController:alertVc
                                                         animated:YES
                                                       completion:nil];

}
@end
