//
//  SXTNHWSHelper.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXTNHWSHelper : NSObject

/**
 *弹出提示文本
 *@param text 提示文字
 *@param compleciton 提示完成回调
 */
+ (void)showHUDText:(NSString *) text
        complection:(MBProgressHUDCompletionBlock) compleciton;

/**
 *获取当前时间
 *@param date 当前日期
 *@return NSString 格式化后的当前日期
 */
+ (NSString *)getCurrentDateWithDate:(NSDate *) date;

/**
 *获取当前时间前n分钟时间
 *@param minutes 分钟数
 *@return NSString 格式化后的当前日期
 */
+ (NSString *)getCurrentDateWithDateMinutes:(NSInteger) minutes;

/**
 *获取活动controller
 *@return controller 当前活动controller
 */
+ (UIViewController *)activityViewController;

/**
 *获取当前日期时间戳
 *@return NSString 时间戳字符串
 */
+(NSString *)getNowTimeTimestamp;

/**
 *获取当前日期之后n个月的时间戳
 *@param number 之后几个月具体数字 1 、2、3
 *@return NSString 时间戳字符串
 */
+(NSString *)getNowTimeTimestampAfterMonth:(NSInteger) number;

/**
 *根据时间戳格式化日期
 *@param str 时间戳
 *@return NSString 日期字符串
 */
+ (NSString *)getDateStringWithTimestampStr:(NSString *)str;

#pragma mark
#pragma mark -图片处理

/** 返回colorImage */
+ (UIImage *)createImageWithColor:(UIColor *) color;

/** 添加图片水印 */
+ (UIImage *)watermarkImage:(UIImage *)img
                   withName:(NSString *)name
                  leftMargn:(NSInteger)margn;

/** 修改图片大小 */
+ (UIImage*) OriginImage:(UIImage *)image
             scaleToSize:(CGSize)size;
/**比例修改图片大小(容量)*/

+ (NSData *)zipImageSizeWithImage:(UIImage *)image;

#pragma mark
#pragma mark 数据处理
/**
 *  将model模型类转化为字典值
 */
+ (NSDictionary *)dicFromObject:(NSObject *) object;


#pragma mark
#pragma mark 弹窗提示
/**
 *弹窗提示
 *@param title 标题
 *@param message 内容
 *@param sure 确定回调
 *@param cancel 取消回调
 */
+ (void)showAlertControllerTitle:(NSString *) title
                         message:(NSString *) message
                            sure:(void (^)()) sure
                         cancel:(void (^)()) cancel;
@end

NS_ASSUME_NONNULL_END
