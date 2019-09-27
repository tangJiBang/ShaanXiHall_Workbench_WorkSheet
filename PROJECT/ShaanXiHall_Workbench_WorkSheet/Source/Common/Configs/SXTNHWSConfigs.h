//
//  SXTNHWSConfigs.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/1.
//  Copyright © 2019 Boco. All rights reserved.
//

#import<Foundation/Foundation.h>

#import "SXTNHWSMacros.h"
#import "SXTNHWSEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXTNHWSConfigs : NSObject

HABM_ASSIGN_SINGLETON(SXTNHWSConfigs)

/**
 *  工单操作历史类型
 */
@property (nonatomic, strong) NSDictionary *hitoryOperateType;

/**
 *  工单操作类型
 */
@property (nonatomic, strong) NSArray *operateName;

/**
 *  操作对应类，不同的操作创建不同的vc来呈现
 */
@property (nonatomic, strong) NSArray *operateAction;

/**
 *  涉及产品厂家
 */
@property (nonatomic, strong) NSArray *manufacturerName;

@end

NS_ASSUME_NONNULL_END
