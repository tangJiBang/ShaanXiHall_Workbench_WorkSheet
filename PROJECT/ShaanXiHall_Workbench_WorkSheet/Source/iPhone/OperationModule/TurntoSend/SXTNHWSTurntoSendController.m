//
//  SXTNHWSTurntoSendController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/8.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSTurntoSendController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSHelper.h"
#import "SXTNHWSHttpManager.h"
#import "HDTableViewItem+SXTNHWS.h"
#import "SXTNHWSCompleteController.h"

#import <BocoFormManager/BocoFormManager.h>
#import <BocoJTIRetrofit/BocoJTIRetrofit.h>
#import <BocoBusiness/BocoBusiness.h>
#import <YYModel/YYModel.h>
#import <BocoRolePicker/BocoRolePicker.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import <BocoJTI/com_boco_bmdp_eoms_service_newcommon_INewCommon.h>

@interface SXTNHWSTurntoSendController ()

<
BocoRolePickerDelegate
>

@property(nonatomic, strong)HDTableViewSection * section1;
@property(nonatomic, strong)BocoLongTextItem * item10;
@property(nonatomic, strong)BocoLongTextItem * item11;
@property(nonatomic, strong)BocoLongTextItem * item12;
@property(nonatomic, strong)BocoInfoItem * item13;

@property (nonatomic, strong)BocoRolePicker * rolePickerVC;
@property (nonatomic, strong)NSMutableArray * selectedRoles;
@property (nonatomic, strong)NSMutableArray * datas;
@property (nonatomic, strong)NSString * objectId;
@property (nonatomic, strong)NSString * objectName;
@end

@implementation SXTNHWSTurntoSendController

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
    [self configSectionOne];
}

- (void)prepareForAction
{
    SXTNHWSWeakSelf;
    self.item13.tableViewDidSelectRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
        [weakSelf presentViewController:[[UINavigationController alloc]initWithRootViewController:weakSelf.rolePickerVC]
                               animated:YES
                             completion:nil];
    };
}

- (void)configSectionOne
{
    self.section1 = [HDTableViewSection section];
    
    self.item10 = [BocoLongTextItem item];
    self.item10.cellHeight = 100.0f;
    self.item10.title = @"处理意见:*";
    
    self.item11 = [BocoLongTextItem item];
    self.item11.cellHeight = 100.0f;
    self.item11.title = @"转派说明:*";
    
    self.item12 = [BocoLongTextItem item];
    self.item12.cellHeight = 100.0f;
    self.item12.title = @"备注:*";

    self.item13 = [BocoInfoItem item];
    self.item13.accessoryHiden = NO;
    self.item13.infoMainTitle = @"派往对象:*";
    
    [self.section1.items addObjectsFromArray:@[self.item10, self.item11, self.item12, self.item13]];
    [self.tableManager addSection:self.section1];
}

#pragma mark
#pragma mark XXXDelegate
#pragma mark BocoRolePickerDelegate
//是否可下转
- (BOOL)bocoRolePicker:(BocoRolePicker *)rolePicker
canTransferForCurrentModel:(id<BocoRoleModelProtocol>)roleModel
{
    return NO;
}
//
- (void)bocoRolePicker:(BocoRolePicker *)rolePicker
  dataForTransferModel:(id<BocoRoleModelProtocol>)roleModel
{
    [self getEmosTeamPerson:@"8903"];
}
//是否可选
- (BOOL)bocoRolePicker:(BocoRolePicker *)rolePicker
canSelectForCurrentModel:(id<BocoRoleModelProtocol>)roleModel
{
    return YES;
}
#pragma mark
#pragma mark Event Response
- (void)getEmosTeamPerson:(NSString *) roleId
{
    SXTNHWSWeakSelf;
    NSDictionary * param = @{@"roleId":roleId,
                             @"opType":@"shaan_op007"
                             };
    [[SXTNHWSHttpManager sharedInstance]
     getRoleId:param
     success:^(id _Nonnull responseObject, NSArray * _Nonnull array) {
         if (array.count) {
             [weakSelf reloadRoleListData:array];
         }else{
             
         }
     }
     failure:^(NSError * _Nonnull error) {
         
     }];
}

- (void)reloadRoleListData:(NSArray *)response
{
    NSMutableArray *datas = [NSMutableArray array];
    for (NSDictionary *roleInfo in response) {
        BocoRoleModel *role = [[BocoRoleModel alloc]init];
        role.neId = roleInfo[@"ID"];
        role.neName = roleInfo[@"SUBROLENAME"];
        role.parentId = roleInfo[@"ROLEID"];
        role.neType = @"-1";
        [datas addObject:role];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:BocoRolePickerDatasReadyNotification
                                                        object:nil
                                                      userInfo:@{BocoRolePickerDatasKey : datas}];
}

- (void)SXTNHWSBaseOperateCommitSure
{
    [super SXTNHWSBaseOperateCommitSure];
    //处理完成
    [self turntoSend];
}
- (void)turntoSend
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
                             @"opType":@"shaan_op006",
//                             @"operateTime":[SXTNHWSHelper getCurrentDateWithDate:[NSDate date]],
                             @"dealSuggestion":self.item10.textTitle,
                             @"transferReasn":self.item11.textTitle,
                             @"remark":self.item12.textTitle,
                             @"sendObject":self.objectId?self.objectId:@""
                             };
    [HDProgressHUDManager showLoadingAnimationWithMessage:@"转派中..."];
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
- (BocoRolePicker *)rolePickerVC{
    __weak typeof(self) weakSelf = self;
    if (!_rolePickerVC) {
        _rolePickerVC = [[BocoRolePicker alloc] init];
        _rolePickerVC.multiSelect = NO;
        _rolePickerVC.isNeedCheck = NO;
        _rolePickerVC.selectedItems = self.selectedRoles;
        _rolePickerVC.delegate = self;
        _rolePickerVC.title = @"选择派发对象";
    }
    _rolePickerVC.noDataAlert = ^{
        [HDAlertViewManager alertWithTitle:@"提示" message:@"请选择派发对象!" cancelTitle:@"确定"];
    };
    _rolePickerVC.dataCallback = ^(NSArray *datas){
        [weakSelf.selectedRoles removeAllObjects];
        [weakSelf.selectedRoles addObjectsFromArray:datas];
        NSMutableArray * idArr = [NSMutableArray array];
        NSMutableArray * nameArr = [NSMutableArray array];
        for (BocoRoleModel *model in datas) {
            [idArr addObject:model.neId];
            [nameArr addObject:model.neName];
        }
        weakSelf.objectId = [idArr componentsJoinedByString:@","];
        weakSelf.objectName = [nameArr componentsJoinedByString:@","];
        weakSelf.item13.infoSubTitle = weakSelf.objectName;
        [weakSelf.baseTable reloadSections:[NSIndexSet indexSetWithIndex:[weakSelf.tableManager.sections indexOfObject:weakSelf.section1]] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    return _rolePickerVC;
}

- (NSMutableArray *)selectedRoles
{
    if (!_selectedRoles) {
        _selectedRoles = [NSMutableArray array];
    }
    return _selectedRoles;
}

- (NSMutableArray *)datas
{
    if(!_datas){
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
