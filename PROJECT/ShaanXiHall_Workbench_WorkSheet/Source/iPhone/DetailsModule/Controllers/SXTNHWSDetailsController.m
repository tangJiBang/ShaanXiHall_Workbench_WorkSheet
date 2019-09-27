//
//  SXTNHWSDetailsController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/4.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSDetailsController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSConfigs.h"
#import "NSObject+SXTNHWS.h"
#import "SXTNHWSBottomOperateView.h"
#import "SXTNHWSHistoryController.h"
#import "SXTNHWSAcceptController.h"
#import "SXTNHWSDealCompleteController.h"
#import "SXTNHWSTurntoSendController.h"
#import "SXTNHWSBaseOperationController.h"
#import "ShaanxiTransmissionNetworkHiddenWorkSheetConstants.h"

#import <HaidoraRefresh/HaidoraRefresh.h>
#import <BocoFormManager/BocoFormManager.h>
#import <BocoJTIRetrofit/BocoJTIRetrofit.h>
#import <BocoBusiness/BocoBusiness.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>
#import <YYModel/YYModel.h>
#import <Masonry/Masonry.h>
#import <objc/runtime.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import <BocoJTI/com_boco_bmdp_eoms_service_newcommon_INewCommon.h>

@interface SXTNHWSDetailsController ()

<
HDTableViewManagerDelegate,
SXTNHWSBottomOperateDelegate
>

@property(nonatomic, strong)HDTableViewManager * tableManager;
@property(nonatomic, strong)HDTableViewSection * section0;
@property(nonatomic, strong)HDTableViewSection * section1;
@property(nonatomic, strong)HDTableViewSection * section2;
@property(nonatomic, strong)BocoInfoItem * item00;
@property(nonatomic, strong)BocoInfoItem * item01;
@property(nonatomic, strong)BocoInfoItem * item02;
@property(nonatomic, strong)BocoInfoItem * item03;
@property(nonatomic, strong)BocoInfoItem * item04;
@property(nonatomic, strong)BocoInfoItem * item05;
@property(nonatomic, strong)BocoInfoItem * item06;

@property(nonatomic, strong)BocoInfoItem * item10;
@property(nonatomic, strong)BocoInfoItem * item11;
@property(nonatomic, strong)BocoInfoItem * item12;
@property(nonatomic, strong)BocoInfoItem * item13;
@property(nonatomic, strong)BocoInfoItem * item14;
@property(nonatomic, strong)BocoInfoItem * item15;
@property(nonatomic, strong)BocoInfoItem * item16;
@property(nonatomic, strong)BocoInfoItem * item17;
@property(nonatomic, strong)BocoInfoItem * item18;
@property(nonatomic, strong)BocoInfoItem * item19;
@property(nonatomic, strong)BocoInfoItem * item110;
@property(nonatomic, strong)BocoInfoItem * item111;

@property(nonatomic, strong)BocoInfoItem * item20;
@property(nonatomic, strong)BocoInfoItem * item21;
@property(nonatomic, strong)BocoInfoItem * item22;
@property(nonatomic, strong)BocoInfoItem * item23;
@property(nonatomic, strong)BocoInfoItem * item24;
@property(nonatomic, strong)BocoInfoItem * item25;
@property(nonatomic, strong)BocoInfoItem * item26;
@property(nonatomic, strong)BocoInfoItem * item27;
@property(nonatomic, strong)BocoInfoItem * item28;
@property(nonatomic, strong)BocoInfoItem * item29;

@property(nonatomic, strong)SXTNHWSBottomOperateView * bottomView;
@property(nonatomic, strong)NSDictionary * detailsDic;
@property(nonatomic, strong)NSArray * currentOperationArr;

@end

@implementation SXTNHWSDetailsController

#pragma mark Init

#pragma mark
#pragma mark Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self prepareForData];
    [self prepareForView];
    [self prepareForAction];
    [self.baseTable triggerPullToRefresh];
}

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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark
#pragma mark PrepareConfig

- (void)prepareForData
{
    SXTNHWSWeakSelf;
    NSDictionary * param = @{
                             @"taskId":Dictory_NullOrNo(self.dictModel, @"TASKID"),
                             @"operateUserId":[BocoUserAgent sharedInstance].currentUser.userId?[BocoUserAgent sharedInstance].currentUser.userId:@"",
                             @"mainId":Dictory_NullOrNo(self.dictModel, @"MAINID"),
                             @"sheetId":Dictory_NullOrNo(self.dictModel, @"SHEETID"),
                             @"opType":@"shaan_op002"
                             };
    [[com_boco_bmdp_eoms_service_newcommon_INewCommon CommonCallWithparam0:param.yy_modelToJSONString]
     startWithCompletionBlockWithSuccess:^(id request, id responseObject) {
         
         NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
         [weakSelf stopRefresh];
         if (!err) {
             if (String_Equal(Dictory_NullOrNo(data, @"serviceFlag"), @"TRUE")) {
                 if([data.allKeys containsObject:@"datalist"]){
                     [weakSelf reloadWithData:Dictory_NullOrNo(data, @"datalist")];
                 }else{
                     SXTNHWSShowAlerView(@"工单没有详情内容");
                 }
             }else{
                 SXTNHWSShowAlerView(Dictory_NullOrNo(data, @"serviceMessage"));
             }
         }else{
             SXTNHWSShowAlerView(@"数据解析失败");
         }
     }
     failure:^(id request, NSError *error) {
         [weakSelf stopRefresh];
         SXTNHWSShowAlerView(error.localizedDescription);
     }];
}

- (void)prepareForView
{
    SXTNHWSWeakSelf;
    [self.view addSubview:self.bottomView];
    self.baseTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,10.0f)];
    self.view.backgroundColor = self.baseTable.backgroundColor;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-TabbarSafeBottomMargin);//iphonex
        make.height.mas_equalTo(50.0f);
    }];
    
    [self configSection0];
    [self configSection1];
    [self configSection2];
}


- (void)prepareForAction
{
    SXTNHWSWeakSelf;
    [self.baseTable addPullToRefreshWithActionHandler:^{
        [weakSelf prepareForData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshDetails)
                                                 name:kShaanxiTransmissionNetworkHiddenWorkSheetNotifactionDetails
                                               object:nil];
}

- (void)configSection0
{
    _section0 = [HDTableViewSection section];
    
    _item00 = [BocoInfoItem item];
    _item00.infoMainTitle = @"工单流水号:";
    _item01 = [BocoInfoItem item];
    _item01.infoMainTitle = @"工单状态:";
    _item02 = [BocoInfoItem item];
    _item02.infoMainTitle = @"工单主题:";
    _item03 = [BocoInfoItem item];
    _item03.infoMainTitle = @"建单人:";
    _item04 = [BocoInfoItem item];
    _item04.infoMainTitle = @"建单人部门:";
    _item05 = [BocoInfoItem item];
    _item05.infoMainTitle = @"建单人联系方式:";
    _item06 = [BocoInfoItem item];
    _item06.infoMainTitle = @"建单人当前角色:";
    
    [_section0.items addObjectsFromArray:@[_item00, _item01, _item02, _item03, _item04, _item05, _item06]];
    [self.tableManager addSection:_section0];
}

- (void)configSection1
{
    _section1 = [HDTableViewSection section];
    
    _item10 = [BocoInfoItem item];
    _item10.infoMainTitle = @"隐患来源一级:";
    _item11 = [BocoInfoItem item];
    _item11.infoMainTitle = @"隐患地市:";
    _item12 = [BocoInfoItem item];
    _item12.infoMainTitle = @"隐患分级:";
    _item13 = [BocoInfoItem item];
    _item13.infoMainTitle = @"隐患一级分类:";
    _item14 = [BocoInfoItem item];
    _item14.infoMainTitle = @"隐患二级分类:";
    _item15 = [BocoInfoItem item];
    _item15.infoMainTitle = @"隐患三级分类:";
    _item16 = [BocoInfoItem item];
    _item16.infoMainTitle = @"处理时限:";
    _item17 = [BocoInfoItem item];
    _item17.infoMainTitle = @"地理位置/机房名称:";
    _item18 = [BocoInfoItem item];
    _item18.infoMainTitle = @"隐患描述:";
    _item19 = [BocoInfoItem item];
    _item19.infoMainTitle = @"入库时间:";//隐患审核通过的时间
    _item110 = [BocoInfoItem item];
    _item110.infoMainTitle = @"隐患来源二级:";
    _item111 = [BocoInfoItem item];
    _item111.infoMainTitle = @"隐患区县:";

    [_section1.items addObjectsFromArray:@[_item10, _item110,_item11, _item111,_item12, _item13,
                                           _item14, _item15,_item16,_item17, _item18, _item19
                                           ]];
    [self.tableManager addSection:_section1];
}

- (void)configSection2
{
    _section2 = [HDTableViewSection section];
    
//    _item20 = [BocoInfoItem item];
//    _item20.infoMainTitle = @"入库时间:";
    _item21 = [BocoInfoItem item];
    _item21.infoMainTitle = @"过程管控要求:";
    _item22 = [BocoInfoItem item];
    _item22.infoMainTitle = @"过程管控记录:";
    _item23 = [BocoInfoItem item];
    _item23.infoMainTitle = @"实际隐患一级分类:";
    _item24 = [BocoInfoItem item];
    _item24.infoMainTitle = @"实际隐患二级分类:";
    _item25 = [BocoInfoItem item];
    _item25.infoMainTitle = @"实际隐患三级分类:";
    _item26 = [BocoInfoItem item];
    _item26.infoMainTitle = @"隐患实施主体:";
    _item27 = [BocoInfoItem item];
    _item27.infoMainTitle = @"项目名称:";
    _item28 = [BocoInfoItem item];
    _item28.infoMainTitle = @"涉及产品厂家:";
    _item29 = [BocoInfoItem item];
    _item29.infoMainTitle = @"辅助性材料:";
    
    [_section2.items addObjectsFromArray:@[_item21, _item22, _item23, _item24, _item25, _item26,
                                           _item27, _item28, _item29
                                           ]];

    [self.tableManager addSection:_section2];
}
#pragma mark
#pragma mark HDTableViewManagerDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth - 20, 30)];
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = FONT15;
    titleLbl.backgroundColor = SXTNHWS_FloatColor(0.80f, 0.80f, 0.80f);
    titleLbl.layer.cornerRadius = 5.0f;
    titleLbl.layer.masksToBounds = YES;
    titleLbl.text = section == 0?@"   工单基本信息":(section == 1?@"  隐患信息":@"  实际隐患信息");
    [headView addSubview:titleLbl];
    return headView;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section > 1) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }
//}

#pragma mark SXTNHWSBottomOperateDelegate

- (void)SXTNHWSBottomOperateSelectedBtnItemType:(SXTNHWSBottomOperateType)type
{
    switch (type) {
            case SXTNHWSBottomOperateRefresh:
        {
            [self.baseTable triggerPullToRefresh];
        }
            break;
            case SXTNHWSBottomOperateHistory:
        {
            SXTNHWSHistoryController * histotyVc = [[SXTNHWSHistoryController alloc] init];
            histotyVc.navigationItem.title = @"流转历史";
            histotyVc.dictModel = self.dictModel;
            [self.navigationController pushViewController:histotyVc animated:YES];
        }
            break;
            case SXTNHWSBottomOperateOperate:
        {
            [self alertOperate];
        }
        default:
        {
        }
            break;
    }
}

#pragma mark
#pragma mark Event Response

- (void)SXTNHWSBaseRefresh
{
    [super SXTNHWSBaseRefresh];
}

- (void)stopRefresh
{
    [self.baseTable stopPullRefresh];
}

- (void)reloadWithData:(NSArray *) datalist
{
    NSDictionary * dict = datalist.firstObject;
    self.detailsDic = dict;
    self.item00.infoSubTitle = Dictory_NullOrNo(dict, @"SHEETID");
    self.item01.infoSubTitle = String_Equal(Dictory_NullOrNo(dict, @"TASKSTATUS"), @"2")?@"待处理":@"已接单";
    self.item02.infoSubTitle = Dictory_NullOrNo(dict, @"TITLE");
    self.item03.infoSubTitle = Dictory_NullOrNo(dict, @"SENDUSERID");
    self.item04.infoSubTitle = Dictory_NullOrNo(dict, @"SENDDEPTID");
    self.item05.infoSubTitle = Dictory_NullOrNo(dict, @"SENDCONTACT");
    self.item06.infoSubTitle = Dictory_NullOrNo(dict, @"SENDROLEID");

    self.item10.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENSOURCELEVEL");
    self.item110.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENSOURCESUBLEVEL");
    self.item11.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENSOURCECITY");
    self.item111.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENSOURCECOUNTRY");
    self.item12.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENSOURCETYPE");
    self.item13.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENCLASSIFYONE");
    self.item14.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENCLASSIFYTWO");
    self.item15.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENCLASSIFYTHREE");
    self.item16.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENDEALLIMITED");
    self.item17.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENLOCATIONROOM");
    self.item18.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENDESC");
    self.item19.infoSubTitle = Dictory_NullOrNo(dict, @"AUDITTASKLINK101TIME");

//    self.item20.infoSubTitle = Dictory_NullOrNo(dict, @"");
    self.item21.infoSubTitle = Dictory_NullOrNo(dict, @"CONTROLDEMAND");
    self.item22.infoSubTitle = Dictory_NullOrNo(dict, @"CONTROLRECORD");
    self.item23.infoSubTitle = Dictory_NullOrNo(dict, @"LINKCLASSIFYONE");
    self.item24.infoSubTitle = Dictory_NullOrNo(dict, @"LINKCLASSIFYTWO");
    self.item25.infoSubTitle = Dictory_NullOrNo(dict, @"LINKCLASSIFYTHREE");
    self.item26.infoSubTitle = Dictory_NullOrNo(dict, @"HIDDENDEALTASKROLE");
    self.item27.infoSubTitle = Dictory_NullOrNo(dict, @"PROJECTNAME");
    self.item28.infoSubTitle = Dictory_NullOrNo(dict, @"PRODUCTFACTROY");
    self.item29.infoSubTitle = Dictory_NullOrNo(dict, @"ASSISTMATERIALS");
    
    [self.baseTable reloadData];
}

- (void)refreshDetails
{
    [self.baseTable triggerPullToRefresh];
}

- (void)alertOperate
{
    SXTNHWSWeakSelf;
    NSArray * operaNamesArr = [self getOperaNameArr];
    if (operaNamesArr.count == 0) return;
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择将要进行的操作" preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString * operateName in operaNamesArr) {
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:operateName
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                            NSNumber *operateNameType = (NSNumber*)[weakSelf.currentOperationArr
                                                                                                    enumerateKeyForValue:operateName];
                                                            NSString *actionName = [[SXTNHWSConfigs sharedInstance].operateAction enumerateValueForKey:operateNameType];
                                                            Class actionClass = NSClassFromString(actionName);
                                                            if (actionClass) {
                                                                SXTNHWSBaseOperationController *actionVC = [[actionClass alloc] init];
                                                                actionVC.navigationItem.title = operateName;
                                                                actionVC.operationType = [operateNameType integerValue];
                                                                actionVC.listModel = weakSelf.dictModel;
                                                                actionVC.detailsDic = weakSelf.detailsDic;
                                                                [weakSelf.navigationController pushViewController:actionVC animated:YES];
                                                            }
                                                            
                                                        }];
        [alertVc addAction:action];
    }
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              
                                                          }];
    [alertVc addAction:cancelAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (NSArray *)getOperaNameArr
{
    
    
    NSMutableArray * array = [NSMutableArray array];
    NSMutableArray * tempArr = [NSMutableArray array];
    NSString * operateTypeStr = Dictory_Null(_detailsDic, @"OPERATETYPELIST");
    NSArray * strArr = [operateTypeStr componentsSeparatedByString:@","];
    if (strArr.count > 0 && operateTypeStr.length > 0) {
        for (NSString * operateStr in strArr) {
            NSString * operateName = [[SXTNHWSConfigs sharedInstance].operateName enumerateValueForKey:@([operateStr integerValue])];
            [array addObject:operateName];
            [tempArr addObject:[[NSObject alloc] initWithKey:@([operateStr integerValue]) value:operateName]];
            
        }
        self.currentOperationArr = [tempArr mutableCopy];
        return [array mutableCopy];
    }
    return nil;
}

#pragma mark
#pragma mark Getter/Setter
- (HDTableViewManager *)tableManager
{
    if (!_tableManager) {
        _tableManager = [HDTableViewManager fm_manager];
        _tableManager.delegate = self;
        self.baseTable.dataSource = _tableManager;
        self.baseTable.delegate = _tableManager;
    }
    return _tableManager;
}

- (SXTNHWSBottomOperateView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[SXTNHWSBottomOperateView alloc] initWithFrame:CGRectZero
                                                       withDelegate:self
                                                             action:^(SXTNHWSBottomOperateType type) {
                                                                 
                                                             }];
        _bottomView.backgroundColor = self.baseTable.backgroundColor;
    }
    return _bottomView;
}
#pragma mark
#pragma mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
