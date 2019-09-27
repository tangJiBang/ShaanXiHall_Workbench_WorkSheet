//
//  SXTNHWSDealCompleteController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/8.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSDealCompleteController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSHelper.h"
#import "SXTNHWSHttpManager.h"
#import "HDTableViewItem+SXTNHWS.h"
#import "SXTNHWSCompleteController.h"

#import <BocoFormManager/BocoFormManager.h>
#import <BocoJTIRetrofit/BocoJTIRetrofit.h>
#import <BocoBusiness/BocoBusiness.h>
#import <YYModel/YYModel.h>
#import <HaidoraActionView/HDActionView.h>
#import <BocoRolePicker/BocoRolePicker.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import <BocoJTI/com_boco_bmdp_eoms_service_newcommon_INewCommon.h>

@interface SXTNHWSDealCompleteController ()

<
BocoRolePickerDelegate
>

@property(nonatomic, strong)HDTableViewSection * section1;
@property(nonatomic, strong)BocoLongTextItem * item10;
@property(nonatomic, strong)BocoLongTextItem * item11;
@property(nonatomic, strong)BocoButtonItem * item12;
@property(nonatomic, strong)BocoButtonItem * item13;
@property(nonatomic, strong)BocoButtonItem * item14;
@property(nonatomic, strong)BocoInfoItem * item15;
@property(nonatomic, strong)BocoTextItem * item16;
@property(nonatomic, strong)BocoButtonItem * item17;
@property(nonatomic, strong)BocoTextItem * item18;
@property(nonatomic, strong)BocoInfoItem * item19;
@property(nonatomic, strong)BocoTextItem * item20;

@property(nonatomic, strong)NSMutableArray * item12Arr;
@property(nonatomic, strong)NSMutableArray * item13Arr;
@property(nonatomic, strong)NSMutableArray * item14Arr;
@property(nonatomic, strong)NSMutableArray * item17Arr;

@property (nonatomic, strong)BocoRolePicker * rolePickerVC;
@property (nonatomic, strong)NSMutableArray * selectedRoles;
@property (nonatomic, strong)NSMutableArray * datas;
@property (nonatomic, strong)NSString * objectId;
@property (nonatomic, strong)NSString * objectName;
@end

@implementation SXTNHWSDealCompleteController

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
    self.item12Arr = [NSMutableArray array];
    self.item13Arr = [NSMutableArray array];
    self.item14Arr = [NSMutableArray array];
    self.item17Arr = [NSMutableArray array];
}

- (void)prepareForView
{
    [self configSectionOne];
}

- (void)prepareForAction
{
    SXTNHWSWeakSelf;
    self.item12.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item12Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":@"1016602",@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item12Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };
    self.item13.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item12.buttonTitle || !weakSelf.item12.dictId) {
            [SXTNHWSHelper showHUDText:@"请先选择隐患一级分类" complection:^{}];
            return ;
        }
        if (!weakSelf.item13Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":weakSelf.item12.dictId,@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item13Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };
    self.item14.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item13.buttonTitle || !weakSelf.item13.dictId) {
            [SXTNHWSHelper showHUDText:@"请先选择隐患二级分类" complection:^{}];
            return ;
        }
        if (!weakSelf.item14Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":weakSelf.item13.dictId,@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item14Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };
    self.item17.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item17Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":@"1016604",@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item17Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };
    self.item19.tableViewDidSelectRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
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
    self.item10.title = @"过程管控要求:*";
    
    self.item11 = [BocoLongTextItem item];
    self.item11.cellHeight = 100.0f;
    self.item11.title = @"过程管控记录:*";
    
    self.item12 = [BocoButtonItem item];
    self.item12.infoMainTitle = @"实际隐患一级分类:*";
    self.item13 = [BocoButtonItem item];
    self.item13.infoMainTitle = @"实际隐患二级分类:*";
    self.item14 = [BocoButtonItem item];
    self.item14.infoMainTitle = @"实际隐患三级分类:*";
    
    self.item15 = [BocoInfoItem item];
    self.item15.infoMainTitle = @"隐患实施主体:*";
    self.item15.infoSubTitle = Dictory_NullOrNo(self.detailsDic, @"HIDDENDEALTASKROLE");
    self.item16 = [BocoTextItem item];
    self.item16.title = @"项目名称:";
    self.item16.placeholdertext = @"请输入项目名称";
    self.item17 = [BocoButtonItem item];
    self.item17.infoMainTitle = @"涉及产品厂家:*";
    self.item20 = [BocoTextItem item];
    self.item20.title = @"其他厂家:*";
    self.item20.placeholdertext = @"请输入请他厂家";
    self.item18 = [BocoTextItem item];
    self.item18.title = @"辅助性材料:";//暂时不加,2019-08-13询问需求后暂时不加
    self.item18.placeholdertext = @"请输入辅助性材料";
    self.item19 = [BocoInfoItem item];
    self.item19.infoMainTitle = @"派往对象:*";
    self.item19.accessoryHiden = NO;
    [self.section1.items addObjectsFromArray:@[self.item10, self.item11, self.item12, self.item13, self.item14,
                                               self.item15, self.item16, self.item17]];
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
             [SXTNHWSHelper showHUDText:@"未查询到数据" complection:^{}];
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
    [self dealComplete];
}
- (void)dealComplete
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
                             @"opType":@"shaan_op005",
                             @"controlDemand":self.item10.textTitle,//过程管控要求
                             @"controlRecord":self.item11.textTitle,//过程管控记录
                             @"linkClassifyOne":self.item12.dictId,//实际隐患一级分类
                             @"linkClassifyTwo":self.item13.dictId,//实际隐患二级分类
                             @"linkClassifyThree":self.item14.dictId,//实际隐患三级分类
                             @"linkExtend1":Dictory_NullOrNo(self.detailsDic, @"HIDDENDEALTASKROLEID"),//隐患实施主体。隐患处理环节，处理角色
                             @"projectName":self.item16.text?self.item16.text:@"",//项目名称
                             @"productFactroy":self.item17.dictId,//涉及产品厂家
                             @"otherFactroy":self.item20.text?self.item20.text:@"",//其他厂家
//                             @"attachInfo":@"",//辅助性材料
//                             @"sendObject":self.objectId?self.objectId:@""
                             };
    NSMutableDictionary * tempParam = [NSMutableDictionary dictionaryWithDictionary:param];
    if (![self.section1.items containsObject:self.item20]) {
        [tempParam removeObjectForKey:@"otherFactroy"];
    }
    [HDProgressHUDManager showLoadingAnimationWithMessage:@"处理完成中..."];
    [[com_boco_bmdp_eoms_service_newcommon_INewCommon CommonCallWithparam0:tempParam.yy_modelToJSONString]
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

#pragma mark 配置多选字典值
- (NSArray *)configDictNamesWithDatas:(NSArray *) array
{
    NSMutableArray * tempArray = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        NSString * dictId = Dictory_NullOrNo(dict, @"DICTID");
        if (dictId.length > 0) {
            [tempArray addObject:Dictory_NullOrNo(dict, @"DICTNAME")];
        }
    }
    return [NSArray arrayWithArray:tempArray];
}

- (void)configDictIdToItemWithDictName:(NSString *) dictName
                              withItem:(BocoButtonItem *)item
{
    if (item == self.item12) {
        [self.item13Arr removeAllObjects];
        self.item13.buttonTitle = @"";
        [self.item14Arr removeAllObjects];
        self.item14.buttonTitle = @"";
        
    }
    if (item == self.item13) {
        [self.item14Arr removeAllObjects];
        self.item14.buttonTitle = @"";
    }
    if (item == self.item17) {
        if (String_Equal(dictName, @"其他")) {
            if (![self.section1.items containsObject:self.item20]) {
                [self.section1.items insertObject:self.item20 atIndex:[self.section1.items indexOfObject:self.item17] + 1];
            }
        }else{
            if ([self.section1.items containsObject:self.item20]) {
                [self.section1.items removeObject:self.item20];
            }
        }
    }
    NSArray * itemArr = [self configItemArrWithitem:item];
    for (NSDictionary * dict in itemArr) {
        if (String_Equal(dictName, Dictory_NullOrNo(dict, @"DICTNAME"))) {
            item.dictId = Dictory_NullOrNo(dict, @"DICTID");
            break;
        }
    }
}

- (void)showDictNamesWithItem:(BocoButtonItem *) item
{
    SXTNHWSWeakSelf;
    NSArray * itemArr = [self configItemArrWithitem:item];
    NSArray * dictNames = [self configDictNamesWithDatas:itemArr];
    if (!dictNames) {
        [SXTNHWSHelper showHUDText:@"未获取到字典值" complection:^{}];
        return;
    }
    [[HDActionView sharedInstance] setPopupPosition:HDActionViewPopupPositionMiddle];
    [HDActionView showSheetWithTitle:@"请选择"
                          itemTitles:dictNames
                      selectedHandle:^(NSInteger index) {
                          item.buttonTitle = dictNames[index];
                          [weakSelf configDictIdToItemWithDictName:dictNames[index] withItem:item];
                          [weakSelf.baseTable reloadData];
                      }];
    
}

- (NSArray *)configItemArrWithitem:(BocoButtonItem *)item
{
    if (item == self.item12) {
        return self.item12Arr;
    }else if (item == self.item13)
    {
        return self.item13Arr;
    }else if (item == self.item14)
    {
        return self.item14Arr;
    }else if (item == self.item17)
    {
        return self.item17Arr;
    }else{
        return nil;
    }
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
        weakSelf.item19.infoSubTitle = weakSelf.objectName;
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
