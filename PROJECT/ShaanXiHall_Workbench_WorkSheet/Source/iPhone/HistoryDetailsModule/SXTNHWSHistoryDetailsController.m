//
//  SXTNHWSHistoryDetailsController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/1.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSHistoryDetailsController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSConfigs.h"

#import <HaidoraRefresh/HaidoraRefresh.h>
#import <BocoFormManager/BocoFormManager.h>
#import <BocoBusiness/BocoBusiness.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>
#import <YYModel/YYModel.h>
#import <Masonry/Masonry.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>

@interface SXTNHWSHistoryDetailsController ()

<
HDTableViewManagerDelegate
>

@property(nonatomic, strong)HDTableViewManager * tableManager;
@property(nonatomic, strong)HDTableViewSection * section0;
@property(nonatomic, strong)BocoInfoItem * item00;
@property(nonatomic, strong)BocoInfoItem * item01;
@property(nonatomic, strong)BocoInfoItem * item02;
@property(nonatomic, strong)BocoInfoItem * item03;
@property(nonatomic, strong)BocoInfoItem * item04;
@property(nonatomic, strong)BocoInfoItem * item05;
@property(nonatomic, strong)BocoInfoItem * item06;

@end

@implementation SXTNHWSHistoryDetailsController

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

}

- (void)prepareForView
{
    [self configSection0];
}


- (void)prepareForAction
{

}

- (void)configSection0
{
    _section0 = [HDTableViewSection section];
    
    _item00 = [BocoInfoItem item];
    _item00.infoMainTitle = @"操作名称:";
    _item00.infoSubTitle = Dictory_NullOrNo([SXTNHWSConfigs sharedInstance].hitoryOperateType, Dictory_NullOrNo(self.dataDict, @"OPERATETYPE"));
    _item01 = [BocoInfoItem item];
    _item01.infoMainTitle = @"操作人:";
    _item01.infoSubTitle = Dictory_NullOrNo(self.dataDict, @"OPERATEUSERID");
    _item02 = [BocoInfoItem item];
    _item02.infoMainTitle = @"操作人部门:";
    _item02.infoSubTitle = Dictory_NullOrNo(self.dataDict, @"OPERATEDEPTID");
    _item03 = [BocoInfoItem item];
    _item03.infoMainTitle = @"操作人电话:";
    _item03.infoSubTitle = Dictory_NullOrNo(self.dataDict, @"");
    _item04 = [BocoInfoItem item];
    _item04.infoMainTitle = @"操作时间:";
    _item04.infoSubTitle = Dictory_NullOrNo(self.dataDict, @"OPERATETIME");
    _item05 = [BocoInfoItem item];
    _item05.infoMainTitle = @"操作人角色:";
    _item05.infoSubTitle = Dictory_NullOrNo(self.dataDict, @"OPERATEROLEID");

    [_section0.items addObjectsFromArray:@[_item00, _item01, _item02, _item03, _item05, _item04]];
    [self.tableManager addSection:_section0];
}
#pragma mark
#pragma mark HDTableViewManagerDelegate

#pragma mark
#pragma mark Event Response


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

#pragma mark
#pragma mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
