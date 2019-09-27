//
//  SXTNHWSSearchController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/9.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSSearchController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSHelper.h"
#import "ShaanxiTransmissionNetworkHiddenWorkSheetConstants.h"
#import "SXTNHWSSearchListController.h"

#import <HaidoraAlertViewManager/HDAlertViewManager.h>
#import <HaidoraRefresh/HaidoraRefresh.h>
#import <BocoFormManager/BocoFormManager.h>
#import <HaidoraAlertViewManager/HDAlertViewManager.h>
#import <BocoJTI/com_boco_bmdp_eoms_service_newcommon_INewCommon.h>
#import <BocoJTIRetrofit/BocoJTIRetrofit.h>
#import <BocoBusiness/BocoBusiness.h>
#import <YYModel/YYModel.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import <Masonry/Masonry.h>

@interface SXTNHWSSearchController ()

<
HDTableViewManagerDelegate
>

@property(nonatomic, strong)HDTableViewManager * tableManager;
@property(nonatomic, strong)HDTableViewSection * section0;
@property(nonatomic, strong)BocoTextItem * item0;
@property(nonatomic, strong)BocoTextItem * item1;
@property(nonatomic, strong)UIButton * searchBtn;

@end

@implementation SXTNHWSSearchController

#pragma mark
#pragma mark Init

#pragma mark
#pragma mark Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self prepareForData];
    [self prepareForView];
    [self prepareForAction];
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
                             @"operateRoleId":Dictory_NullOrNo([BocoUserAgent sharedInstance].currentUser.reservedInfo, @"operateRoleId"),
                             @"operateUserId":[BocoUserAgent sharedInstance].currentUser.userId?[BocoUserAgent sharedInstance].currentUser.userId:@"",
                             @"currentPageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"pageSize":[NSString stringWithFormat:@"%d",10],
                             @"opType":@"shaan_op001"
                             };
    [[com_boco_bmdp_eoms_service_newcommon_INewCommon CommonCallWithparam0:param.yy_modelToJSONString]
     startWithCompletionBlockWithSuccess:^(id request, id responseObject) {
         
         NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
         if (!err) {
             [weakSelf reloadWithData:data];
         }else{
             SXTNHWSShowAlerView(@"数据解析失败");
         }
     }
     failure:^(id request, NSError *error) {
         SXTNHWSShowAlerView(error.localizedDescription);
     }];

}

- (void)prepareForView
{
    
    self.baseTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,CGFLOAT_MIN)];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    
    _section0 = [HDTableViewSection section];
    
    _item0 = [BocoTextItem item];
    _item0.placeholdertext = @"请输入工单主题";
    _item0.title = @"工单主题:";
    
    _item1 = [BocoTextItem item];
    _item1.placeholdertext = @"请输入工单流水号";
    _item1.title = @"工单流水号:";
    
    [_section0.items addObjectsFromArray:@[_item0, _item1]];
    [self.tableManager addSection:_section0];
    
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    [footView addSubview:self.searchBtn];
    self.baseTable.tableFooterView = footView;
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(magrn * 2);
        make.right.equalTo(footView).offset(-magrn * 2);
        make.height.mas_equalTo(30.0f);
        make.bottom.equalTo(footView).offset(-magrn);
    }];
}


- (void)prepareForAction
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(XZCWSBaseRefresh:)
                                                 name:kShaanxiTransmissionNetworkHiddenWorkSheetNotifactionSearchList
                                               object:nil];
}

#pragma mark
#pragma mark HDTableViewManagerDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

#pragma mark
#pragma mark Event Response
- (void)searchClicked:(UIButton *)sender
{
    if (_item0.text.length == 0 && _item1.text.length == 0) {
        [SXTNHWSHelper showHUDText:@"请输入工单主题或者工单流水号进行查询" complection:^{
            
        }];
        return;
    }
    [self prepareForData];
}

- (void)reloadWithData:(NSDictionary *) dic
{
    NSString * serviceFlag = Dictory_NullOrNo(dic, @"serviceFlag");
    if (String_Equal(serviceFlag, @"TRUE")) {
        NSArray * dataList = Dictory_responseObject(dic, @"datalist");
        if (self.dataArr.count > 0) {
            [self.dataArr removeAllObjects];
        }
        if (dataList.count > 0) {
            [self.dataArr addObjectsFromArray:dataList];
            SXTNHWSSearchListController * searchListVc = [[SXTNHWSSearchListController alloc] init];
            searchListVc.navigationItem.title = @"查询列表";
            searchListVc.searchArr = [self.dataArr mutableCopy];
            [self.navigationController pushViewController:searchListVc animated:YES];
        }else{
            SXTNHWSShowAlerView(@"没有查询到数据");
        }
    }else{
        SXTNHWSShowAlerView(Dictory_NullOrNo(dic, @"serviceMessage"));
    }
    
}

- (void)SXTNHWSBaseRefresh
{
    [super SXTNHWSBaseRefresh];
}

#pragma mark
#pragma mark Getter/Setter
- (HDTableViewManager *)tableManager
{
    if (!_tableManager) {
        _tableManager = [HDTableViewManager fm_manager];
        _tableManager.delegate = self;
        self.baseTable.dataSource = self.tableManager;
        self.baseTable.delegate = self.tableManager;
    }
    return _tableManager;
}

- (UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitle:@"查询" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = FONT13;
        [_searchBtn setTitleColor:SXTNHWS_FloatColor(0.35f, 0.71f, 0.98f) forState:UIControlStateNormal];
        _searchBtn.layer.cornerRadius = 5.0f;
        _searchBtn.layer.borderWidth = 1.0f;
        _searchBtn.layer.borderColor = SXTNHWS_FloatColor(0.35f, 0.71f, 0.98f).CGColor;
        //        [_searchBtn setImage:[UIImage imageNamed:@"gxjkr_main_refresh"] forState:UIControlStateNormal];
        _searchBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [_searchBtn addTarget:self action:@selector(searchClicked:) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.bounds = CGRectMake(0, 0, 32, 32);
    }
    return _searchBtn;
}

#pragma mark
#pragma mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
