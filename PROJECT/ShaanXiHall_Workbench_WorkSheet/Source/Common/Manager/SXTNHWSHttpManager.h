//
//  SXTNHWSHttpManager.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/24.
//  Copyright © 2019 Boco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXTNHWSMacros.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SXTNHWSHttpSuccessHandler)(id,id);
typedef void(^SXTNHWSHttpFailureHandler)(NSError *);

@interface SXTNHWSHttpManager : NSObject

HABM_ASSIGN_SINGLETON(SXTNHWSHttpManager)

#pragma mark 登录
/**
 *获取用户部门信息
 *@param param 参数
 *@param success 成功回调
 *@param failure 失败回调
 */
- (void)getUserDeptInfo:(NSDictionary *) param
                success:(SXTNHWSHttpSuccessHandler) success
                failure:(SXTNHWSHttpFailureHandler) failure;

/**
 *获取用户角色信息
 *@param param 参数
 *@param success 成功回调
 *@param failure 失败回调
 */
- (void)getUserRoleInfo:(NSDictionary *) param
                success:(SXTNHWSHttpSuccessHandler) success
                failure:(SXTNHWSHttpFailureHandler) failure;

#pragma mark 工单操作
/**
 *新建工单、派单
 *@param param 参数
 *@param success 成功回调
 *@param failure 失败回调
 */
- (void)sendNewSheet:(NSDictionary *) param
             success:(SXTNHWSHttpSuccessHandler) success
             failure:(SXTNHWSHttpFailureHandler) failure;

#pragma mark 字典值查询
/**
 *字典值查询
 *@param param 参数
 *@param success 成功回调
 *@param failure 失败回调
 */
- (void)getDictionarys:(NSDictionary *) param
               success:(SXTNHWSHttpSuccessHandler) success
               failure:(SXTNHWSHttpFailureHandler) failure;

/**
 *地市、区县查询
 *@param param 参数
 *@param success 成功回调
 *@param failure 失败回调
 */
- (void)getAreas:(NSDictionary *) param
         success:(SXTNHWSHttpSuccessHandler) success
         failure:(SXTNHWSHttpFailureHandler) failure;

/**
 *角色查询
 *@param param 参数
 *@param success 成功回调
 *@param failure 失败回调
 */
- (void)getRoleId:(NSDictionary *) param
          success:(SXTNHWSHttpSuccessHandler) success
          failure:(SXTNHWSHttpFailureHandler) failure;

/**
 *子角色查询
 *@param param 参数
 *@param success 成功回调
 *@param failure 失败回调
 */
- (void)getSubRoleId:(NSDictionary *) param
             success:(SXTNHWSHttpSuccessHandler) success
             failure:(SXTNHWSHttpFailureHandler) failure;

@end

NS_ASSUME_NONNULL_END
