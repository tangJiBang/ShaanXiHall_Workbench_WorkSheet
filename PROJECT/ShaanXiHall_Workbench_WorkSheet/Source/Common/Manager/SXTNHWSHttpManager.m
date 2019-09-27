//
//  SXTNHWSHttpManager.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/24.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSHttpManager.h"

#import <BocoJTI/com_boco_bmdp_eoms_service_commonsheet_ICommonSheetProvideSrv.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_base_MsgHeader.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryalluserinfosrv_InquiryAllUserInfo.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryalluserinfosrv_InquiryAllUserInfoSrvRequest.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryalluserinfosrv_InquiryAllUserInfoSrvResponse.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryallroleinfosrv_InquiryAllRoleInfo.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryallroleinfosrv_InquiryAllRoleInfoSrvRequest.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryallroleinfosrv_InquiryAllRoleInfoSrvResponse.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryallsubroleinfosrv_InquiryAllSubRoleInfoSrvRequest.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryallsubroleinfosrv_InquiryAllSubRoleInfoSrvResponse.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryallsubroleinfosrv_InquiryAllSubRoleInfo.h>
#import <BocoJTI/com_boco_bmdp_eoms_service_newcommon_INewCommon.h>
#import <BocoJTIRetrofit/BocoJTIRetrofit.h>
#import <YYModel/YYModel.h>
#import <BocoBusiness/BocoBusiness.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>

@implementation SXTNHWSHttpManager

HABM_DEFINE_SINGLETON(SXTNHWSHttpManager)

- (void)getUserDeptInfo:(NSDictionary *) param
                success:(SXTNHWSHttpSuccessHandler) success
                failure:(SXTNHWSHttpFailureHandler) failure
{
    com_boco_bmdp_eoms_entity_base_MsgHeader * msgHeader = [[com_boco_bmdp_eoms_entity_base_MsgHeader alloc] init];
    msgHeader.opUserId = Dictory_NullOrNo(param, @"userId");
    msgHeader.opUserName = @"";
    msgHeader.proviceCode = @"SX";
    msgHeader.serCaller = @"MPS";
    msgHeader.serSupplier = @"EOMS";
    msgHeader.pageSize = @(1000);
    msgHeader.opTime = [NSDate date];
    msgHeader.currentPageIndex = 0;
    com_boco_bmdp_eoms_entity_commonsheet_inquiryalluserinfosrv_InquiryAllUserInfoSrvRequest * requset =
    [[com_boco_bmdp_eoms_entity_commonsheet_inquiryalluserinfosrv_InquiryAllUserInfoSrvRequest alloc] init];
    requset.operateUserId = Dictory_NullOrNo(param, @"userId");
    [[com_boco_bmdp_eoms_service_commonsheet_ICommonSheetProvideSrv inquiryAllUserInfoSrvWithparam0:msgHeader param1:requset] startWithCompletionBlockWithSuccess:^(id request, com_boco_bmdp_eoms_entity_commonsheet_inquiryalluserinfosrv_InquiryAllUserInfoSrvResponse * responseObject) {
        if (String_Equal(responseObject.serviceFlag, @"TRUE")) {
            com_boco_bmdp_eoms_entity_commonsheet_inquiryalluserinfosrv_InquiryAllUserInfo * userInfo = responseObject.outputCollectionList.firstObject;
            if (success) {
                success(responseObject,userInfo);
            }
        }else{
            [HDProgressHUDManager hideLoadingAnimation];
            SXTNHWSShowAlerView(responseObject.serviceMessage);
        }
    } failure:^(id request, NSError *error) {
        if (failure) {
            failure(error);
        }
        SXTNHWSShowAlerView(error.localizedDescription);
    }];

}

- (void)getUserRoleInfo:(NSDictionary *) param
                success:(SXTNHWSHttpSuccessHandler) success
                failure:(SXTNHWSHttpFailureHandler) failure
{
    com_boco_bmdp_eoms_entity_base_MsgHeader * msgHeader = [[com_boco_bmdp_eoms_entity_base_MsgHeader alloc] init];
    msgHeader.opUserId = Dictory_NullOrNo(param, @"userId");
    msgHeader.opUserName = @"";
    msgHeader.proviceCode = @"SX";
    msgHeader.serCaller = @"MPS";
    msgHeader.serSupplier = @"EOMS";
    msgHeader.pageSize = @(1000);
    msgHeader.opTime = [NSDate date];
    msgHeader.currentPageIndex = 0;
    com_boco_bmdp_eoms_entity_commonsheet_inquiryallroleinfosrv_InquiryAllRoleInfoSrvRequest * requset =
    [[com_boco_bmdp_eoms_entity_commonsheet_inquiryallroleinfosrv_InquiryAllRoleInfoSrvRequest alloc] init];
    requset.operateUserId = Dictory_NullOrNo(param, @"userId");
    [[com_boco_bmdp_eoms_service_commonsheet_ICommonSheetProvideSrv inquiryAllRoleInfoSrvWithparam0:msgHeader param1:requset] startWithCompletionBlockWithSuccess:^(id request, com_boco_bmdp_eoms_entity_commonsheet_inquiryallroleinfosrv_InquiryAllRoleInfoSrvResponse * responseObject) {
        if (String_Equal(responseObject.serviceFlag, @"TRUE")) {
            com_boco_bmdp_eoms_entity_commonsheet_inquiryallroleinfosrv_InquiryAllRoleInfo * userInfo = responseObject.outputCollectionList.firstObject;
            if (success) {
                success(responseObject,userInfo);
            }
        }else{
            [HDProgressHUDManager hideLoadingAnimation];
            SXTNHWSShowAlerView(responseObject.serviceMessage);
        }
    } failure:^(id request, NSError *error) {
        if (failure) {
            failure(error);
        }
        SXTNHWSShowAlerView(error.localizedDescription);
    }];

}
- (void)sendNewSheet:(NSDictionary *) param
             success:(SXTNHWSHttpSuccessHandler) success
             failure:(SXTNHWSHttpFailureHandler) failure
{
    [HDProgressHUDManager showLoadingAnimationWithMessage:@"派单中..."];
    NSDictionary * tempParam = @{@"opType":Dictory_NullOrNo(param, @"opType"),
                                 @"operateRoleId":Dictory_NullOrNo(param, @"operateRoleId"),
                                 @"operateType":Dictory_NullOrNo(param, @"operateType"),
                                 @"operateUserId":Dictory_NullOrNo(param, @"operateUserId"),
                                 @"operateDeptId":Dictory_NullOrNo(param, @"operateDeptId"),
                                 @"operaterContact":Dictory_NullOrNo(param, @"operaterContact"),
                                 @"operateTime":Dictory_NullOrNo(param, @"operateTime"),
                                 @"hiddenSourceLevel":Dictory_NullOrNo(param, @"hiddenSourceLevel"),
                                 @"hiddenSourceSubLevel":Dictory_NullOrNo(param, @"hiddenSourceSubLevel"),
                                 @"hiddenSourceCity":Dictory_NullOrNo(param, @"hiddenSourceCity"),
                                 @"hiddenSourceCountry":Dictory_NullOrNo(param, @"hiddenSourceCountry"),
                                 @"hiddenSourceType":Dictory_NullOrNo(param, @"hiddenSourceType"),
                                 @"hiddenClassifyOne":Dictory_NullOrNo(param, @"hiddenClassifyOne"),
                                 @"hiddenClassifyTwo":Dictory_NullOrNo(param, @"hiddenClassifyTwo"),
                                 @"hiddenClassifyThree":Dictory_NullOrNo(param, @"hiddenClassifyThree"),
                                 @"hiddenDealLimited":Dictory_NullOrNo(param, @"hiddenDealLimited"),
                                 @"hiddenLocationRoom":Dictory_NullOrNo(param, @"hiddenLocationRoom"),
                                 @"hiddenDesc":Dictory_NullOrNo(param, @"hiddenDesc"),
                                 @"title":Dictory_NullOrNo(param, @"title")
                                 };
    [[com_boco_bmdp_eoms_service_newcommon_INewCommon CommonCallWithparam0:tempParam.yy_modelToJSONString]
     startWithCompletionBlockWithSuccess:^(id request, id responseObject) {
         [HDProgressHUDManager hideLoadingAnimation];
         NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
         if (!err) {
             if (String_Equal(Dictory_NullOrNo(data, @"serviceFlag"), @"TRUE")) {
                 if (success) {
                     success(responseObject,Dictory_NullOrNo(data, @"serviceFlag"));
                 }
             }else{
                 [HDProgressHUDManager hideLoadingAnimation];
                 SXTNHWSShowAlerView(Dictory_NullOrNo(data, @"serviceMessage"));
             }
         }else{
             [HDProgressHUDManager hideLoadingAnimation];
             SXTNHWSShowAlerView(@"解析返回数据失败");
         }
    } failure:^(id request, NSError *error) {
        [HDProgressHUDManager hideLoadingAnimation];
        SXTNHWSShowAlerView(error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getDictionarys:(NSDictionary *) param
               success:(SXTNHWSHttpSuccessHandler) success
               failure:(SXTNHWSHttpFailureHandler) failure
{
    NSDictionary * tempParam = @{@"parentDictId":Dictory_NullOrNo(param, @"parentDictId"),
                                 @"opType":Dictory_NullOrNo(param, @"opType")
                                 };
    [[com_boco_bmdp_eoms_service_newcommon_INewCommon CommonCallWithparam0:tempParam.yy_modelToJSONString]
     startWithCompletionBlockWithSuccess:^(id request, id responseObject) {
         
         NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
         if (!err) {
             if (String_Equal(Dictory_NullOrNo(data, @"serviceFlag"), @"TRUE")) {
                 if (success) {
                     success(responseObject,Dictory_NullOrNo(data, @"datalist"));
                 }
             }else{
                 SXTNHWSShowAlerView(Dictory_NullOrNo(data, @"serviceMessage"));
             }
         }else{
             SXTNHWSShowAlerView(@"解析返回数据失败");
         }
     } failure:^(id request, NSError *error) {
         SXTNHWSShowAlerView(error.localizedDescription);
         if (failure) {
             failure(error);
         }
     }];

}

- (void)getAreas:(NSDictionary *) param
         success:(SXTNHWSHttpSuccessHandler) success
         failure:(SXTNHWSHttpFailureHandler) failure
{
    NSDictionary * tempParam = @{@"parentAreaId":Dictory_NullOrNo(param, @"parentAreaId"),
                                 @"opType":Dictory_NullOrNo(param, @"opType")
                                 };
    [[com_boco_bmdp_eoms_service_newcommon_INewCommon CommonCallWithparam0:tempParam.yy_modelToJSONString]
     startWithCompletionBlockWithSuccess:^(id request, id responseObject) {
         
         NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
         if (!err) {
             if (String_Equal(Dictory_NullOrNo(data, @"serviceFlag"), @"TRUE")) {
                 if (success) {
                     success(responseObject,Dictory_NullOrNo(data, @"datalist"));
                 }
             }else{
                 SXTNHWSShowAlerView(Dictory_NullOrNo(data, @"serviceMessage"));
             }
         }else{
             SXTNHWSShowAlerView(@"解析返回数据失败");
         }
     } failure:^(id request, NSError *error) {
         if (failure) {
             failure(error);
         }
         SXTNHWSShowAlerView(error.localizedDescription);
     }];

}

- (void)getRoleId:(NSDictionary *) param
          success:(SXTNHWSHttpSuccessHandler) success
          failure:(SXTNHWSHttpFailureHandler) failure
{
    NSDictionary * tempParam = @{@"roleId":Dictory_NullOrNo(param, @"roleId"),
                                 @"opType":Dictory_NullOrNo(param, @"opType")
                                 };
    [[com_boco_bmdp_eoms_service_newcommon_INewCommon CommonCallWithparam0:tempParam.yy_modelToJSONString]
     startWithCompletionBlockWithSuccess:^(id request, id responseObject) {
         
         NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
         if (!err) {
             if (String_Equal(Dictory_NullOrNo(data, @"serviceFlag"), @"TRUE")) {
                 if (success) {
                     success(responseObject,Dictory_NullOrNo(data, @"datalist"));
                 }
             }else{
                 [HDProgressHUDManager hideLoadingAnimation];
                 SXTNHWSShowAlerView(Dictory_NullOrNo(data, @"serviceMessage"));
             }
         }else{
             [HDProgressHUDManager hideLoadingAnimation];
             SXTNHWSShowAlerView(@"解析返回数据失败");
         }
     } failure:^(id request, NSError *error) {
         if (failure) {
             failure(error);
         }
         SXTNHWSShowAlerView(error.localizedDescription);
     }];

}

- (void)getSubRoleId:(NSDictionary *) param
             success:(SXTNHWSHttpSuccessHandler) success
             failure:(SXTNHWSHttpFailureHandler) failure
{
    com_boco_bmdp_eoms_entity_base_MsgHeader * msgHeader = [[com_boco_bmdp_eoms_entity_base_MsgHeader alloc] init];
    msgHeader.opUserId = Dictory_NullOrNo(param, @"userId");
    msgHeader.opUserName = @"";
    msgHeader.proviceCode = @"SX";
    msgHeader.serCaller = @"MPS";
    msgHeader.serSupplier = @"EOMS";
    msgHeader.pageSize = @(1000);
    msgHeader.opTime = [NSDate date];
    msgHeader.currentPageIndex = 0;
    com_boco_bmdp_eoms_entity_commonsheet_inquiryallsubroleinfosrv_InquiryAllSubRoleInfoSrvRequest * requset =
    [[com_boco_bmdp_eoms_entity_commonsheet_inquiryallsubroleinfosrv_InquiryAllSubRoleInfoSrvRequest alloc] init];
    requset.operateUserId = Dictory_NullOrNo(param, @"userId");
    [[com_boco_bmdp_eoms_service_commonsheet_ICommonSheetProvideSrv inquiryAllSubRoleInfoSrvWithparam0:msgHeader param1:requset] startWithCompletionBlockWithSuccess:^(id request, com_boco_bmdp_eoms_entity_commonsheet_inquiryallsubroleinfosrv_InquiryAllSubRoleInfoSrvResponse * responseObject) {
        if (String_Equal(responseObject.serviceFlag, @"TRUE")) {
            com_boco_bmdp_eoms_entity_commonsheet_inquiryallsubroleinfosrv_InquiryAllSubRoleInfo * subInfo = responseObject.outputCollectionList.firstObject;
            if (success) {
                success(responseObject,subInfo);
            }
        }else{
            [HDProgressHUDManager hideLoadingAnimation];
            SXTNHWSShowAlerView(responseObject.serviceMessage);
        }
    } failure:^(id request, NSError *error) {
        if (failure) {
            failure(error);
        }
        SXTNHWSShowAlerView(error.localizedDescription);
    }];
}
@end
