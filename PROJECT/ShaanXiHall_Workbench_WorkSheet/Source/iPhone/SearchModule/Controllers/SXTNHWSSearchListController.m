//
//  SXTNHWSSearchListController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/9.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSSearchListController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSListCell.h"
#import "SXTNHWSHelper.h"
#import "SXTNHWSDetailsController.h"
#import "ShaanxiTransmissionNetworkHiddenWorkSheetConstants.h"

#import <YYModel/YYModel.h>
#import <BocoBusiness/BocoBusiness.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>
#import <HaidoraRefresh/HaidoraRefresh.h>
#import <SDAutoLayout/SDAutoLayout.h>

@interface SXTNHWSSearchListController ()

<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation SXTNHWSSearchListController

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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark
#pragma mark PrepareConfig

- (void)prepareForData
{
}

- (void)prepareForView
{
    self.baseTable.delegate = self;
    self.baseTable.dataSource = self;
    self.baseTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,CGFLOAT_MIN)];
    [self.baseTable registerClass:[SXTNHWSListCell class] forCellReuseIdentifier:IDENTFIER];
}

- (void)prepareForAction
{

}

#pragma mark
#pragma mark XXXDelegate
-(void)tableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.searchArr[indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath
                                       model:model
                                     keyPath:@"dataModel"
                                   cellClass:[SXTNHWSListCell class]
                            contentViewWidth:ScreenWidth - magrn * 2];
    //    return 120.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXTNHWSListCell * cell = [tableView dequeueReusableCellWithIdentifier:IDENTFIER];
    cell.dataModel = self.searchArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SXTNHWSDetailsController * detailsVc = [[SXTNHWSDetailsController alloc] init];
    detailsVc.navigationItem.title = @"工单详情";
    detailsVc.dictModel = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detailsVc animated:YES];
}
#pragma mark
#pragma mark Event Response

- (void)SXTNHWSBaseRefresh
{
    [super SXTNHWSBaseRefresh];
}
#pragma mark
#pragma mark Getter/Setter
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
