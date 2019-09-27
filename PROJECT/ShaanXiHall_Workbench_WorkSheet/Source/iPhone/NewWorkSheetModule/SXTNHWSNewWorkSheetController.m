//
//  SXTNHWSNewWorkSheetController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/4.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSNewWorkSheetController.h"

#import "SXTNHWSHttpManager.h"
#import "HDTableViewItem+SXTNHWS.h"
#import "SXTNHWSHelper.h"

#import <BocoFormManager/BocoFormManager.h>
#import <HaidoraActionView/HDActionView.h>
#import <BocoBusiness/BocoBusiness.h>
#if __has_include(<SCLAlertView-Objective-C/SCLAlertView.h>)
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#else
#import <SCLAlertView_Objective_C/SCLAlertView.h>
#endif

@interface SXTNHWSNewWorkSheetController ()
<
HDTableViewManagerDelegate
>

@property(nonatomic, strong)HDTableViewManager * tableManager;
@property(nonatomic, strong)HDTableViewSection * section0;
@property(nonatomic, strong)BocoInfoItem * item00;
@property(nonatomic, strong)BocoInfoItem * item01;
@property(nonatomic, strong)BocoTextItem * item02;
@property(nonatomic, strong)BocoButtonItem * item03;
@property(nonatomic, strong)BocoButtonItem * item04;
@property(nonatomic, strong)BocoButtonItem * item05;
@property(nonatomic, strong)BocoButtonItem * item06;
@property(nonatomic, strong)BocoButtonItem * item07;
@property(nonatomic, strong)BocoButtonItem * item08;
@property(nonatomic, strong)BocoButtonItem * item09;
@property(nonatomic, strong)BocoInfoItem * item10;
@property(nonatomic, strong)BocoTextItem * item11;
@property(nonatomic, strong)BocoLongTextItem * item12;
@property(nonatomic, strong)BocoInfoItem * item13;
@property(nonatomic, strong)BocoButtonItem * item14;//查看接口和需求文档不同、隐患区域是隐患地市和隐患区县的结合,

@property(nonatomic, strong)NSMutableArray * item03Arr;
@property(nonatomic, strong)NSMutableArray * item04Arr;
@property(nonatomic, strong)NSMutableArray * item05Arr;
@property(nonatomic, strong)NSMutableArray * item06Arr;
@property(nonatomic, strong)NSMutableArray * item07Arr;
@property(nonatomic, strong)NSMutableArray * item08Arr;
@property(nonatomic, strong)NSMutableArray * item09Arr;
@property(nonatomic, strong)NSMutableArray * item14Arr;

@property(nonatomic, strong)UIButton * sendSheetBtn;
@end

@implementation SXTNHWSNewWorkSheetController

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
    //初始化数组
    self.item03Arr = [NSMutableArray array];
    self.item04Arr = [NSMutableArray array];
    self.item05Arr = [NSMutableArray array];
    self.item06Arr = [NSMutableArray array];
    self.item07Arr = [NSMutableArray array];
    self.item08Arr = [NSMutableArray array];
    self.item09Arr = [NSMutableArray array];
    self.item14Arr = [NSMutableArray array];
    //获取8091大角色下的子角色用于新建工单
    if (![[BocoUserAgent sharedInstance].currentUser.reservedInfo.allKeys containsObject:@"newOperateRoleId"]) {
        NSDictionary * param = @{@"roleId":@"8901",
                                 @"opType":@"shaan_op007"
                                 };
        [[SXTNHWSHttpManager sharedInstance]
         getRoleId:param
         success:^(id _Nonnull request, NSArray * _Nonnull array) {
             NSDictionary * dict = array.firstObject;
             [[BocoUserAgent sharedInstance].currentUser.reservedInfo setObject:Dictory_NullOrNo(dict, @"ID")
                                                                         forKey:@"newOperateRoleId"];
             [[BocoUserAgent sharedInstance].currentUser.reservedInfo setObject:Dictory_NullOrNo(dict, @"SUBROLENAME")
                                                                         forKey:@"newOperateRoleName"];
             [[BocoUserAgent sharedInstance] updateCurrentUser:[BocoUserAgent sharedInstance].currentUser];
         }
         failure:^(NSError * _Nonnull error) {
             
         }];
    }
}

- (void)prepareForView
{
    [self configSectionItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.sendSheetBtn];
}

- (void)prepareForAction
{
    SXTNHWSWeakSelf;
    self.item03.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item03Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":@"1016601",@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item03Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };
    self.item04.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item03.buttonTitle || !weakSelf.item03.dictId) {
            [SXTNHWSHelper showHUDText:@"请先选择隐患来源一级" complection:^{}];
            return ;
        }
        if (!weakSelf.item04Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":weakSelf.item03.dictId,@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item04Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };
    self.item06.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item06Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":@"1016603",@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item06Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };
    self.item07.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item07Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":@"1016602",@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item07Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };
    self.item08.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item07.buttonTitle || !weakSelf.item07.dictId) {
            [SXTNHWSHelper showHUDText:@"请先选择隐患一级分类" complection:^{}];
            return ;
        }
        if (!weakSelf.item08Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":weakSelf.item07.dictId,@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item08Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };
    self.item09.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item08.buttonTitle || !weakSelf.item08.dictId) {
            [SXTNHWSHelper showHUDText:@"请先选择隐患二级分类" complection:^{}];
            return ;
        }
        if (!weakSelf.item09Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getDictionarys:@{@"parentDictId":weakSelf.item08.dictId,@"opType":@"shaan_op010"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item09Arr addObjectsFromArray:array];
                 [weakSelf showDictNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showDictNamesWithItem:item];
        }
    };

    self.item05.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item05Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getAreas:@{@"parentAreaId":@"28",@"opType":@"comm_op007"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item05Arr addObjectsFromArray:array];
                 [weakSelf showAreaNamesWithItem:item];
                }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showAreaNamesWithItem:item];
        }
    };
    self.item14.buttonClickedHandlerWithValue = ^(BocoButtonItem *item, BocoButtonCell *cell) {
        if (!weakSelf.item05.buttonTitle || !weakSelf.item05.dictId) {
            [SXTNHWSHelper showHUDText:@"请先选择地市" complection:^{}];
            return ;
        }
        if (!weakSelf.item14Arr.count) {
            [[SXTNHWSHttpManager sharedInstance]
             getAreas:@{@"parentAreaId":weakSelf.item05.dictId,@"opType":@"comm_op007"}
             success:^(id _Nonnull request, NSArray * _Nonnull array) {
                 [weakSelf.item14Arr addObjectsFromArray:array];
                 [weakSelf showAreaNamesWithItem:item];
             }
             failure:^(NSError * _Nonnull error) {
                 
             }];
        }else{
            [weakSelf showAreaNamesWithItem:item];
        }
    };
}

- (void)configSectionItem
{
    self.section0 = [HDTableViewSection section];
    
    self.item00 = [BocoInfoItem item];
    self.item00.infoMainTitle = @"工单编号:";
    
    self.item01 = [BocoInfoItem item];
    self.item01.infoMainTitle = @"状态:";
    
    self.item02 = [BocoTextItem item];
    self.item02.title = @"主题:";
    self.item02.placeholdertext = @"请输入工单主题";
    
    self.item03 = [BocoButtonItem item];
    self.item03.infoMainTitle = @"隐患来源一级:";
    self.item04 = [BocoButtonItem item];
    self.item04.infoMainTitle = @"隐患来源二级:";
    self.item05 = [BocoButtonItem item];
    self.item05.infoMainTitle = @"隐患地市:";
    self.item14 = [BocoButtonItem item];
    self.item14.infoMainTitle = @"隐患区县:";
    self.item06 = [BocoButtonItem item];
    self.item06.infoMainTitle = @"隐患分级:";
    self.item07 = [BocoButtonItem item];
    self.item07.infoMainTitle = @"隐患一级分类:";
    self.item08 = [BocoButtonItem item];
    self.item08.infoMainTitle = @"隐患二级分类:";
    self.item09 = [BocoButtonItem item];
    self.item09.infoMainTitle = @"隐患三级分类:";
    
    self.item10 = [BocoInfoItem item];
    self.item10.infoMainTitle = @"处理时限:";
    
    self.item11 = [BocoTextItem item];
    self.item11.title = @"地理位置/机房名称:";
    self.item11.placeholdertext = @"请输入地理位置/机房名称";
    
    self.item12 = [BocoLongTextItem item];
    self.item12.cellHeight = 150.0f;
    self.item12.title = @"隐患描述:";
    self.item12.placeholdertext = @"请输入隐患描述";
    
    self.item13 = [BocoInfoItem item];
    self.item13.infoMainTitle = @"派往对象:";
    
    [self.section0.items addObjectsFromArray:@[self.item02, self.item03, self.item04, self.item05, self.item14,
                                               self.item06, self.item07, self.item08, self.item09, self.item10, self.item11,
                                               self.item12]];
    [self.tableManager addSection:self.section0];
}
#pragma mark
#pragma mark XXXDelegate

#pragma mark
#pragma mark Event Response
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
    if (item == self.item03) {
        [self.item04Arr removeAllObjects];
        self.item04.buttonTitle = @"";
    }
    if (item == self.item07) {
        [self.item08Arr removeAllObjects];
        self.item08.buttonTitle = @"";
        [self.item09Arr removeAllObjects];
        self.item09.buttonTitle = @"";

    }
    if (item == self.item08) {
        [self.item09Arr removeAllObjects];
        self.item09.buttonTitle = @"";
    }
    if (item == self.item06) {
        NSInteger number = 0;
        if (String_Equal(item.buttonTitle, @"严重")) {
            number = 1;
        }else if (String_Equal(item.buttonTitle, @"重要")) {
            number = 2;
        }else{
            number = 3;
        }
        NSString * nowTimes = [SXTNHWSHelper getNowTimeTimestampAfterMonth:number];
        self.item10.infoSubTitle = [SXTNHWSHelper getDateStringWithTimestampStr:nowTimes];
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
    if (item == self.item03) {
        return self.item03Arr;
    }else if (item == self.item04)
    {
        return self.item04Arr;
    }else if (item == self.item06)
    {
        return self.item06Arr;
    }else if (item == self.item07)
    {
        return self.item07Arr;
    }else if (item == self.item08)
    {
        return self.item08Arr;
    }else if (item == self.item09)
    {
        return self.item09Arr;
    }else if (item == self.item05)
    {
        return self.item05Arr;
    }else if (item == self.item14)
    {
        return self.item14Arr;
    }else{
        return nil;
    }
}

#pragma mark 配置多选区域
- (NSArray *)configAreaNamesWithDatas:(NSArray *) array
{
    NSMutableArray * tempArray = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        NSString * areaId = Dictory_NullOrNo(dict, @"AREAID");
        if (areaId.length > 0) {
            [tempArray addObject:Dictory_NullOrNo(dict, @"AREANAME")];
        }
    }
    return [NSArray arrayWithArray:tempArray];
}

- (void)configAreaIdToItemWithDictName:(NSString *) dictName
                              withItem:(BocoButtonItem *)item
{
    if (item == self.item05) {
        [self.item14Arr removeAllObjects];
        self.item14.buttonTitle = @"";
    }

    NSArray * itemArr = [self configItemArrWithitem:item];
    for (NSDictionary * dict in itemArr) {
        if (String_Equal(dictName, Dictory_NullOrNo(dict, @"AREANAME"))) {
            item.dictId = Dictory_NullOrNo(dict, @"AREAID");
            break;
        }
    }
}

- (void)showAreaNamesWithItem:(BocoButtonItem *) item
{
    SXTNHWSWeakSelf;
    NSArray * itemArr = [self configItemArrWithitem:item];
    NSArray * dictNames = [self configAreaNamesWithDatas:itemArr];
    if (!dictNames) {
        [SXTNHWSHelper showHUDText:@"未获取到字典值" complection:^{}];
        return;
    }
    [[HDActionView sharedInstance] setPopupPosition:HDActionViewPopupPositionMiddle];
    [HDActionView showSheetWithTitle:@"请选择"
                          itemTitles:dictNames
                      selectedHandle:^(NSInteger index) {
                          item.buttonTitle = dictNames[index];
                          [weakSelf configAreaIdToItemWithDictName:dictNames[index] withItem:item];
                          [weakSelf.baseTable reloadData];
                      }];
    
}


- (BOOL)checkItemInfoIntegrity
{
    NSString * content = nil;
    BOOL isStop = NO;
    for (HDTableViewSection * section in self.tableManager.sections) {
        if (isStop) {
            break;
        }
        for (HDTableViewItem * item in section.items) {
            if ([item isMemberOfClass:[BocoInfoItem class]]) {
                BocoInfoItem * tempItem = (BocoInfoItem *)item;
                if (!tempItem.infoSubTitle || tempItem.infoSubTitle.length == 0) {
                    content = tempItem.infoMainTitle;
                    isStop = YES;
                    break;
                }
            }
            if ([item isMemberOfClass:[BocoButtonItem class]]) {
                BocoButtonItem * tempItem = (BocoButtonItem *)item;
                if (!tempItem.buttonTitle || tempItem.buttonTitle.length == 0) {
                    content = tempItem.infoMainTitle;
                    isStop = YES;
                    break;
                }
            }
            if ([item isMemberOfClass:[BocoTextItem class]]) {
                BocoTextItem * tempItem = (BocoTextItem *)item;
                if (!tempItem.text || tempItem.text.length == 0) {
                    content = tempItem.title;
                    isStop = YES;
                    break;
                }
            }
            if ([item isMemberOfClass:[BocoLongTextItem class]]) {
                BocoLongTextItem * tempItem = (BocoLongTextItem *)item;
                if (!tempItem.textTitle || tempItem.textTitle.length == 0) {
                    content = tempItem.title;
                    isStop = YES;
                    break;
                }
            }
        }
    }
    if (content) {
        NSMutableString * mutableString = [NSMutableString stringWithString:content];
        if ([mutableString containsString:@":"]) {
            NSRange range = [mutableString rangeOfString:@":"];
            [mutableString deleteCharactersInRange:range];
        }
        [SXTNHWSHelper showHUDText:[NSString stringWithFormat:@"请完善%@信息",mutableString] complection:^{}];
        return NO;
    }else{
        return YES;
    }
}

- (void)sendSheetBtnClicked:(UIButton *)sender
{
    SXTNHWSWeakSelf;
    if (![self checkItemInfoIntegrity])return;
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert setHorizontalButtons:YES];
    SCLButton * cancleButton = [alert addButton:@"取消" actionBlock:^{
        
    }];
    cancleButton.buttonFormatBlock = ^NSDictionary *{
        
        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
        buttonConfig[@"backgroundColor"] = SXTNHWS_FloatColor(0.82f, 0.82f, 0.82f);
        buttonConfig[@"textColor"] = [UIColor whiteColor];
        buttonConfig[@"font"] = [UIFont fontWithName:@"ComicSansMS" size:13];
        return buttonConfig;
    };
    SCLButton * aureButton = [alert addButton:@"确定" actionBlock:^{
        [weakSelf newSendSheet];
    }];
    aureButton.buttonFormatBlock = ^NSDictionary *{
        
        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
        buttonConfig[@"backgroundColor"] = SXTNHWS_MAIN_COLOR;
        buttonConfig[@"textColor"] = [UIColor whiteColor];
        buttonConfig[@"font"] = [UIFont fontWithName:@"ComicSansMS" size:13];
        return buttonConfig;
    };
    [alert showWarning:self title:@"提示" subTitle:@"确定提交吗?" closeButtonTitle:nil duration:0.0f];

}

- (void)newSendSheet
{
    SXTNHWSWeakSelf;
    NSDictionary * tempParam = @{@"opType":@"shaan_op008",//固定值
                                 @"operateRoleId":Dictory_NullOrNo([BocoUserAgent sharedInstance].currentUser.reservedInfo, @"newOperateRoleId"),
                                 @"operateType":@"0",//0新派 54重派 22草稿派发
                                 @"operateUserId":[BocoUserAgent sharedInstance].currentUser.userId?[BocoUserAgent sharedInstance].currentUser.userId:@"",
                                 @"operateDeptId":[BocoUserAgent sharedInstance].currentUser.deptId?[BocoUserAgent sharedInstance].currentUser.deptId:@"",
                                 @"operaterContact":[BocoUserAgent sharedInstance].currentUser.contact?[BocoUserAgent sharedInstance].currentUser.contact:@"",
                                 @"operateTime":[SXTNHWSHelper getCurrentDateWithDate:[NSDate date]],
                                 @"hiddenSourceLevel":self.item03.dictId?self.item03.dictId:@"",
                                 @"hiddenSourceSubLevel":self.item04.dictId?self.item04.dictId:@"",
                                 @"hiddenSourceCity":self.item05.dictId?self.item05.dictId:@"",
                                 @"hiddenSourceCountry":self.item14.dictId?self.item14.dictId:@"",
                                 @"hiddenSourceType":self.item06.dictId?self.item06.dictId:@"",
                                 @"hiddenClassifyOne":self.item07.dictId?self.item07.dictId:@"",
                                 @"hiddenClassifyTwo":self.item08.dictId?self.item08.dictId:@"",
                                 @"hiddenClassifyThree":self.item09.dictId?self.item09.dictId:@"",
                                 @"hiddenDealLimited":self.item10.infoSubTitle,//处理时限派单时间基础上，根据“隐患分级”自动生成严重隐患：处理时限为建单时间加1个月；
                                 //重要隐患：处理时限为建单时间加2个月；一般隐患：处理时限为建单时间加3个月。
                                 @"hiddenLocationRoom":self.item11.text,
                                 @"hiddenDesc":self.item12.textTitle,
                                 @"title":self.item02.text
                                 };
    [[SXTNHWSHttpManager sharedInstance]
     sendNewSheet:tempParam
     success:^(id _Nonnull request, NSString * _Nonnull serviceFlag) {
         
         [SXTNHWSHelper showHUDText:@"派单成功!" complection:^{}];
         [weakSelf.navigationController popViewControllerAnimated:YES];
     }
     failure:^(NSError * _Nonnull error) {
         
     }];
}
#pragma mark
#pragma mark Getter/Setter
- (HDTableViewManager *)tableManager
{
    if (!_tableManager) {
        _tableManager = [HDTableViewManager fm_manager];
        self.baseTable.dataSource = _tableManager;
        self.baseTable.delegate = _tableManager;
        _tableManager.delegate = self;
    }
    return _tableManager;
}

- (UIButton *)sendSheetBtn
{
    if (!_sendSheetBtn) {
        _sendSheetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendSheetBtn.bounds = CGRectMake(0, 0, 28, 28);
        _sendSheetBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        if ([UIImage imageNamed:@"boco_commit"]) {
            [_sendSheetBtn setImage:[UIImage imageNamed:@"boco_commit"] forState:UIControlStateNormal];
        }else{
            NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"ShaanXiHall_Workbench_WorkSheet" ofType:@"bundle" inDirectory:@"ShaanXiHall_Workbench_WorkSheet.framework"]];
            NSString * path = [imageBundle pathForResource:@"boco_commit@3x.png" ofType:nil];
            [_sendSheetBtn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        }
        _sendSheetBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [_sendSheetBtn addTarget:self action:@selector(sendSheetBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendSheetBtn;
}

@end
