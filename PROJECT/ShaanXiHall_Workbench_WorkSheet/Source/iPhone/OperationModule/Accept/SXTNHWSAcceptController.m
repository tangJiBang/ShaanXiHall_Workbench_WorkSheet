//
//  SXTNHWSAcceptController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/8.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSAcceptController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSHelper.h"
#import "SXTNHWSCompleteController.h"

#import <BocoJTIRetrofit/BocoJTIRetrofit.h>
#import <BocoBusiness/BocoBusiness.h>
#import <YYModel/YYModel.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import <BocoJTI/com_boco_bmdp_eoms_service_newcommon_INewCommon.h>

@implementation SXTNHWSAcceptController

#pragma mark
#pragma mark Init

#pragma mark
#pragma mark Life Cycle


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareForData];
    [self prepareForView];
    [self prepareForAction];
    
}

#pragma mark
#pragma mark PrepareConfig

- (void)prepareForData
{
    
}

- (void)prepareForView
{

}

- (void)prepareForAction
{
    
}

#pragma mark
#pragma mark XXXDelegate

#pragma mark
#pragma mark Event Response

- (void)SXTNHWSBaseOperateCommitSure
{
    [super SXTNHWSBaseOperateCommitSure];
    //受理操作
    [self accept];
}

- (void)accept
{
    SXTNHWSWeakSelf;
    NSDictionary * param = @{
//                             @"operateRoleId":Dictory_NullOrNo(self.roleDict, @"ID"),
                             @"operateUserId":[BocoUserAgent sharedInstance].currentUser.userId?[BocoUserAgent sharedInstance].currentUser.userId:@"",
                             @"operateTime":[SXTNHWSHelper getCurrentDateWithDate:[NSDate date]],
                             @"operaterContact":[BocoUserAgent sharedInstance].currentUser.contact?[BocoUserAgent sharedInstance].currentUser.contact:@"",
                             @"operateDeptId":[BocoUserAgent sharedInstance].currentUser.deptId?[BocoUserAgent sharedInstance].currentUser.deptId:@"",
                             @"taskId":Dictory_NullOrNo(self.listModel, @"TASKID"),
                             @"sheetId":Dictory_NullOrNo(self.listModel, @"SHEETID"),
                             @"mainId":Dictory_NullOrNo(self.listModel, @"MAINID"),
                             @"opType":@"shaan_op003"
                             };
    [HDProgressHUDManager showLoadingAnimationWithMessage:@"受理中..."];
    [[com_boco_bmdp_eoms_service_newcommon_INewCommon CommonCallWithparam0:param.yy_modelToJSONString]
     startWithCompletionBlockWithSuccess:^(id request, id responseObject) {
         
         NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
         [HDProgressHUDManager hideLoadingAnimation];
         if (!err) {
             if (String_Equal(Dictory_NullOrNo(data, @"serviceFlag"), @"TRUE")) {
                 SXTNHWSCompleteController * completeVc = [[SXTNHWSCompleteController alloc] init];
                 completeVc.navigationItem.title = @"工单操作成功!";
                 completeVc.operationType = self.operationType;
                 [weakSelf.navigationController pushViewController:completeVc animated:YES];
             }else{
                 SXTNHWSShowAlerView(Dictory_NullOrNo(data, @"serviceMessage"));
             }
         }else{
             SXTNHWSShowAlerView(@"数据解析失败");
         }
     }
     failure:^(id request, NSError *error) {
         [HDProgressHUDManager hideLoadingAnimation];
         SXTNHWSShowAlerView(error.localizedDescription);
     }];
}

#pragma mark
#pragma mark Getter/Setter

@end
