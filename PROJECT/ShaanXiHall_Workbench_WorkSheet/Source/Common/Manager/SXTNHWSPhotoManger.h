//
//  SXTNHWSPhotoManger.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/12.
//  Copyright © 2019 Boco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SXTNHWSMacros.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SXTNHWSPhotoBlock)(id);


@interface SXTNHWSPhotoManger : NSObject

HABM_ASSIGN_SINGLETON(SXTNHWSPhotoManger)

/**
 *选图片
 *@param finish 回调
 */
- (void)SXTNHWSAlbumPhoto:(SXTNHWSPhotoBlock) finish;

/**
 *拍照
 *@param finish 回调
 */
- (void)SXTNHWSTakePhoto:(SXTNHWSPhotoBlock) finish;

@end

NS_ASSUME_NONNULL_END
