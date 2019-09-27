//
//  SXTNHWSFileManager.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/12.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSFileManager.h"

#import <BocoBusiness/BocoBusiness.h>

#define otherFilePath [NSString stringWithFormat:@"%@/SXTNHWS_File/%@", [self getDirPath],[BocoUserAgent sharedInstance].currentUser.userId]

@interface SXTNHWSFileManager ()

@property(nonatomic, strong)NSFileManager * fileManager;

@end

@implementation SXTNHWSFileManager

HABM_DEFINE_SINGLETON(SXTNHWSFileManager)

- (BOOL)createDirectoryAtPath:(NSString *)path
{
    if (![self.fileManager fileExistsAtPath:path]) {
        [self.fileManager createDirectoryAtPath:path
                    withIntermediateDirectories:YES
                                     attributes:nil
                                          error:nil];
        return YES;
    }
    return NO;
}

- (NSString *)getDirPath
{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"%@", path);
    return path;
}

- (NSInteger)writeFile:(NSData *)data
            sanBoxName:(NSString *)name
                  type:(NSInteger)type
{
    BOOL isPathSuc =  [self createDirectoryAtPath:otherFilePath];
    if (isPathSuc) {
        NSLog(@"创建附件基础文件夹成功");
    }else{
        NSLog(@"创建附件基础文件夹失败、已经存在");
    }
    NSError *err = nil;
    NSArray *files = [self.fileManager contentsOfDirectoryAtPath:otherFilePath error:&err];
    NSString *fileName = name;
    if ([self stringIsInArray:files WithString:name]) {
        if (type == 0) {
            return 2;
        } else if (type == 1) {
            fileName = name;
        } else {
            fileName = [NSString stringWithFormat:@"%@_%@.%@",name.stringByDeletingPathExtension,[SXTNHWSHelper getCurrentDateWithDate:[NSDate date]],name.pathExtension];
        }
    }
    
    
    //生成文件夹路径
    //    NSString *dirPath = [MyTools filePathInDocuntsWithFile:kDirShare];
    //查看文件夹路径存在不,如果不存在创建文件夹,如果创建不成功返回no
    //    if (![MyTools directoryExist:dirPath]) {
    //        if (![MyTools createDirectory:dirPath]) {
    //            return 0;
    //        }
    //    }
    
    
    //判断是否有重名文件
    //    NSLog(@"%@",files);
    //    NSString *fileName = name;
    //    if ([MyTools stringIsInArray:files WithString:name]) {
    //        if (type == 0) {
    //            return 2;
    //        } else if (type == 1) {
    //            fileName = name;
    //        } else {
    //            fileName = [NSString stringWithFormat:@"%@_%@.%@",name.stringByDeletingPathExtension,[DateTools stringFromDate:[NSDate date] withFormat:@"yyyyMMddHHmmss"],name.pathExtension];
    //        }
    //    }
    
    //拼接路径
    NSString * tempFilePath = [otherFilePath stringByAppendingPathComponent:fileName];
    BOOL isSuc = [data writeToFile:tempFilePath atomically:YES];
    if (isSuc) {
        [SXTNHWSHelper showHUDText:@"文件分享成功" complection:^{}];
    }else{
        [SXTNHWSHelper showHUDText:@"文件分享失败,写入失败" complection:^{}];
    }
    return isSuc;
}

- (BOOL)stringIsInArray:files WithString:name
{
    for (NSString * file in files) {
        //        NSString * tempFilePath = [NSString stringWithFormat:@"%@/%@",otherFilePath,file];
        if ([file isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)getAllDocumentFilesFromDirectory
{
    NSMutableArray * array = [NSMutableArray array];
    NSError *error = nil;
    NSArray * fileList = [self.fileManager contentsOfDirectoryAtPath:otherFilePath error:&error];
    for (NSString * file in fileList) {
        NSString * tempfFilePath = [NSString stringWithFormat:@"%@/%@",otherFilePath,file];
        if ([self.fileManager fileExistsAtPath:tempfFilePath]) {
//            SDTWFileModel * model = [SDTWFileModel new];
//            model.data = [NSData dataWithContentsOfFile:tempfFilePath];
//            model.path = tempfFilePath;
//            model.name = file;
//            [array addObject:model];
        }
    }
    
    return array;
}

- (BOOL)removeAllDocumentFiles
{
    BOOL isSuc =[self.fileManager
                 removeItemAtPath:[NSString stringWithFormat:@"%@", otherFilePath]
                 error:nil];
    if (isSuc) {
        NSLog(@"移除所有回复文件成功");
    }else{
        NSLog(@"移除所有回复文件失败");
    }
    return isSuc;
    
}

#pragma mark setter/getter
- (NSFileManager *)fileManager
{
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}


@end
