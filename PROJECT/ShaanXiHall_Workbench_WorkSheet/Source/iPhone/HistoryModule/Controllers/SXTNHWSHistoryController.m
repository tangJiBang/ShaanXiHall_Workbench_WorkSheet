//
//  SXTNHWSHistoryController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSHistoryController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSHistoryCell.h"
#import "SXTNHWSHistoryDetailsController.h"

#import <HaidoraRefresh/HaidoraRefresh.h>
#import <BocoFormManager/BocoFormManager.h>
#import <BocoJTIRetrofit/BocoJTIRetrofit.h>
#import <BocoBusiness/BocoBusiness.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>
#import <YYModel/YYModel.h>
#import <Masonry/Masonry.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import <BocoJTI/com_boco_bmdp_eoms_service_newcommon_INewCommon.h>

@interface SXTNHWSHistoryController ()

<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation SXTNHWSHistoryController

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
    SXTNHWSWeakSelf;
    NSDictionary * param = @{
                             @"operateUserId":[BocoUserAgent sharedInstance].currentUser.userId?[BocoUserAgent sharedInstance].currentUser.userId:@"",
                             @"mainId":Dictory_NullOrNo(self.dictModel, @"MAINID"),
                             @"opType":@"shaan_op009"
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
                 [weakSelf reloadWithData:Dictory_NullOrNo(data, @"datalist")];
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
    self.baseTable.delegate = self;
    self.baseTable.dataSource = self;
    [self.baseTable registerClass:[SXTNHWSHistoryCell class] forCellReuseIdentifier:IDENTFIER];
}

- (void)prepareForAction
{
    SXTNHWSWeakSelf;
    [self.baseTable addPullToRefreshWithActionHandler:^{
        [weakSelf prepareForData];
    }];
}

#pragma mark
#pragma mark XXXDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXTNHWSHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:IDENTFIER];
    cell.dataModel  = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SXTNHWSHistoryDetailsController * detailsVc = [[SXTNHWSHistoryDetailsController alloc] init];
    detailsVc.navigationItem.title = @"流转历史详情";
    detailsVc.dataDict = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detailsVc animated:YES];
}
#pragma mark
#pragma mark Event Response
- (void)stopRefresh
{
    [self.baseTable stopPullRefresh];
}

- (void)reloadWithData:(NSArray *)array
{
    if (self.dataArr.count) {
        [self.dataArr removeAllObjects];
    }
    [self.dataArr addObjectsFromArray:array];
    [self.baseTable reloadData];
}
#pragma mark
#pragma mark Getter/Setter
@end
