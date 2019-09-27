//
//  SXTNHWSMainViewController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by Dailingchi on 07/04/2019.
//  Copyright © 2019年 Boco. All rights reserved.
//

#import "SXTNHWSMainViewController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSMainCell.h"
#import "SXTNHWSNewWorkSheetController.h"
#import "SXTNHWSPageListController.h"
#import "SXTNHWSListController.h"

@interface SXTNHWSMainViewController ()

<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation SXTNHWSMainViewController

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
    [self.dataArr addObjectsFromArray:@[@{@"icon":@"",@"title":@"新建工单"},
                                        @{@"icon":@"",@"title":@"工单列表"}]];
}

- (void)prepareForView
{
    self.baseTable.delegate = self;
    self.baseTable.dataSource = self;
    [self.baseTable registerClass:[SXTNHWSMainCell class] forCellReuseIdentifier:IDENTFIER];
}

- (void)prepareForAction
{
    
}

#pragma mark
#pragma mark XXXDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXTNHWSMainCell * cell = [tableView dequeueReusableCellWithIdentifier:IDENTFIER];
    cell.model = self.dataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            SXTNHWSNewWorkSheetController * newWorkSheetVc = [[SXTNHWSNewWorkSheetController alloc] init];
            newWorkSheetVc.navigationItem.title = @"新建工单";
            [self.navigationController pushViewController:newWorkSheetVc animated:YES];
        }
            break;
        case 1:
        {
//            SXTNHWSPageListController * pageListVc = [[SXTNHWSPageListController alloc] init];
//            pageListVc.navigationItem.title = @"工单列表";
//            pageListVc.selectIndex = 0;
//            pageListVc.menuViewStyle = WMMenuViewStyleLine;
//            pageListVc.automaticallyCalculatesItemWidths = YES;
//            pageListVc.progressViewIsNaughty = NO;
            //    pageListVc.progressWidth = 15;
            //    pageListVc.progressWidth = ScreenWidth / 2.0f;
//            pageListVc.titleColorSelected = SXTNHWS_MAIN_COLOR;
//            pageListVc.titleColorNormal = SXTNHWS_FloatColor(0.20f,0.20f,0.20f);
//            [self.navigationController pushViewController:pageListVc animated:YES];
            
            SXTNHWSListController * listVc = [[SXTNHWSListController alloc] init];
            listVc.navigationItem.title = @"工单列表";
            [self.navigationController pushViewController:listVc animated:YES];
        }
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark
#pragma mark Event Response

#pragma mark
#pragma mark Getter/Setter

@end
