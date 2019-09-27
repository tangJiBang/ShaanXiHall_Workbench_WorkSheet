//
//  SXTNHWSFileManager.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/12.
//  Copyright © 2019 Boco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SXTNHWSMacros.h"
#import "SXTNHWSHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXTNHWSFileManager : NSObject


HABM_ASSIGN_SINGLETON(SXTNHWSFileManager)

#pragma
#pragma mark 文件操作

/**
 *将文件写入到本地沙盒
 *@param data 文件二进制数据
 *@param name 文件名称
 *@param type type: 0:尝试写入,如果重名返回重名  1:替换 2:重命名写入
 *@return NSInteger       return : 0:失败,1:成功,2:有重名
 */
- (NSInteger)writeFile:(NSData *) data
            sanBoxName:(NSString *) name
                  type:(NSInteger) type;

/**
 *获取本地沙盒文件
 *@return NSArray 返回文件路径和名称
 */
- (NSArray *)getAllDocumentFilesFromDirectory;


/**
 *移除所有回复附件
 *@return BOOL 成功与否
 */
- (BOOL)removeAllDocumentFiles;

@end

NS_ASSUME_NONNULL_END
