//
//  SXTNHWSBaseController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/4.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSBaseController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSMainViewController.h"
#import "SXTNHWSDetailsController.h"
#import "SXTNHWSListController.h"
#import "SXTNHWSNewWorkSheetController.h"
#import "SXTNHWSHistoryController.h"
#import "SXTNHWSHistoryDetailsController.h"

#import <Masonry/Masonry.h>
#import <HaidoraRefresh/HaidoraRefresh.h>

@interface SXTNHWSBaseController ()

@end

@implementation SXTNHWSBaseController

#pragma mark
#pragma mark Init

#pragma mark
#pragma mark Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareBaseForData];
    [self prepareBaseForView];
    [self prepareBaseForAction];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



#pragma mark
#pragma mark PrepareConfig

- (void)prepareBaseForData
{
    //默认数据开始页面为0
    self.page = 0;
    //初始化数据存储数组
    self.dataArr = [NSMutableArray array];
}

- (void)prepareBaseForView
{
    SXTNHWSWeakSelf;
    self.view.backgroundColor = self.baseTable.backgroundColor;
//    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    //初始化table
    [self.view addSubview:self.baseTable];
//    if ([self isMemberOfClass:[SXTNHWSDetailsController class]]) {
//        [self.baseTable mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.equalTo(weakSelf.view);
//            make.right.equalTo(weakSelf.view);
//            if (@available(iOS 11.0, *)) {
//                make.top.equalTo(weakSelf.view).offset(NavigationBarHeight + StatusBarHeight);
//                make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-50-TabbarSafeBottomMargin);
//            } else {
//                make.top.equalTo(weakSelf.view).offset(NavigationBarHeight + StatusBarHeight);
//                make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-50-TabbarSafeBottomMargin);
//            }
//        }];
//    }else if([self isMemberOfClass:[SXTNHWSListController class]]){
//        [self.baseTable mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.equalTo(weakSelf.view);
//            make.right.equalTo(weakSelf.view);
//            if (@available(iOS 11.0, *)) {
//                make.top.equalTo(weakSelf.view).offset(NavigationBarHeight + StatusBarHeight);
//                make.bottom.equalTo(weakSelf.view).offset(TabbarSafeBottomMargin);
//            } else {
//                make.top.equalTo(weakSelf.view.mas_top).offset(NavigationBarHeight + StatusBarHeight);
//                make.bottom.equalTo(weakSelf.view.mas_bottom).offset(TabbarSafeBottomMargin);
//            }
//        }];
//    }else{
//        [self.baseTable mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.equalTo(weakSelf.view);
//            make.right.equalTo(weakSelf.view);
//            if (@available(iOS 11.0, *)) {
//                make.top.equalTo(weakSelf.view).offset(NavigationBarHeight + StatusBarHeight);
//                make.bottom.equalTo(weakSelf.view).offset(0);
//            } else {
//                make.top.equalTo(weakSelf.view.mas_top).offset(NavigationBarHeight + StatusBarHeight);
//                make.bottom.equalTo(weakSelf.view.mas_bottom).offset(0);
//            }
//        }];
//    }
    if ([self isMemberOfClass:[SXTNHWSDetailsController class]]) {
        [self.baseTable mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-50-TabbarSafeBottomMargin);
        }];
    }else{
        [self.baseTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
    }


}

- (void)prepareBaseForAction
{
    
}

#pragma mark
#pragma mark XXXDelegate

#pragma mark
#pragma mark Event Response
- (void)SXTNHSBaseRefresh
{
    //下拉刷新
    [self.baseTable triggerPullToRefresh];
}

#pragma mark
#pragma mark Getter/Setter
- (UITableView *)baseTable
{
    if (!_baseTable) {
        if ([self isKindOfClass:[SXTNHWSListController class]] ||
            [self isKindOfClass:[SXTNHWSMainViewController class]] ||
            [self isKindOfClass:[SXTNHWSNewWorkSheetController class]] ||
            [self isKindOfClass:[SXTNHWSHistoryController class]] ||
            [self isKindOfClass:[SXTNHWSHistoryDetailsController class]]
            ) {
            _baseTable = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStylePlain];
        }else{
            _baseTable = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStyleGrouped];
        }
        _baseTable.tableFooterView = [UIView new];
        if ([_baseTable respondsToSelector:@selector(setSeparatorInset:)]) {
            [_baseTable setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_baseTable respondsToSelector:@selector(setLayoutMargins:)]) {
            [_baseTable setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _baseTable;
}

@end
