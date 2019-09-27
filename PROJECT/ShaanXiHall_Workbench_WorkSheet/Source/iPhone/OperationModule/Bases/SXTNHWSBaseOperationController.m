
//
//  SXTNHWSBaseOperationController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSBaseOperationController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSHelper.h"

#import <BocoFormManager/BocoFormManager.h>
#import <BocoBusiness/BocoBusiness.h>
#import <HaidoraAlertViewManager/HDAlertViewManager.h>
#if __has_include(<SCLAlertView-Objective-C/SCLAlertView.h>)
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#else
#import <SCLAlertView_Objective_C/SCLAlertView.h>
#endif

@interface SXTNHWSBaseOperationController ()

<
HDTableViewManagerDelegate
>
@property(nonatomic, strong)BocoInfoItem * item0;
@property(nonatomic, strong)BocoInfoItem * item1;
@property(nonatomic, strong)BocoInfoItem * item2;
@property(nonatomic, strong)BocoInfoItem * item3;
@property(nonatomic, strong)BocoInfoItem * item4;
@property(nonatomic, strong)BocoInfoItem * item5;
@property(nonatomic, strong)BocoInfoItem * item6;
@property(nonatomic, strong)BocoInfoItem * item7;
@property(nonatomic, strong)BocoInfoItem * item8;
@property(nonatomic, strong)UIButton * commitBtn;
@property(nonatomic, strong)dispatch_source_t sourceTimer;

@end

@implementation SXTNHWSBaseOperationController

#pragma mark
#pragma mark Init

#pragma mark
#pragma mark Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareBaseOperateForData];
    [self prepareBaseOperateForView];
    [self prepareBaseOperateForAction];
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
//    dispatch_source_cancel(self.sourceTimer);
}

#pragma mark
#pragma mark PrepareConfig

- (void)prepareBaseOperateForData
{
//    self.roleDict = [self
//                    SXTNHWSChecksubRole:Dictory_NullOrNo([BocoUserAgent sharedInstance].currentUser.reservedInfo, @"operateRoleIds")
//                     userId:[BocoUserAgent sharedInstance].currentUser.userId];

}

- (void)prepareBaseOperateForView
{
    
    self.baseTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,10.0f)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.commitBtn];
    
    _section0 = [HDTableViewSection section];
    
    _item0 = [BocoInfoItem item];
    _item0.infoMainTitle = @"工单编号*:";
    _item0.infoSubTitle = Dictory_NullOrNo(self.detailsDic, @"SHEETID");
    _item1 = [BocoInfoItem item];
    _item1.infoMainTitle = @"工单状态*:";
    _item1.infoSubTitle = String_Equal(Dictory_NullOrNo(self.detailsDic, @"TASKSTATUS"), @"2")?@"待处理":@"已接单";;
    _item2 = [BocoInfoItem item];
    _item2.infoMainTitle = @"工单主题*:";
    _item2.infoSubTitle = Dictory_NullOrNo(self.detailsDic, @"TITLE");
    _item3 = [BocoInfoItem item];
    _item3.infoMainTitle = @"操作人*:";
    _item3.infoSubTitle = [BocoUserAgent sharedInstance].currentUser.userName?[BocoUserAgent sharedInstance].currentUser.userName:@"";
    _item4 = [BocoInfoItem item];
    _item4.infoMainTitle = @"操作人部门*:";
    _item4.infoSubTitle = [BocoUserAgent sharedInstance].currentUser.deptName?[BocoUserAgent sharedInstance].currentUser.deptName:@"";
    _item5 = [BocoInfoItem item];
    _item5.infoMainTitle = @"操作人联系方式*:";
    _item5.infoSubTitle = [BocoUserAgent sharedInstance].currentUser.contact?[BocoUserAgent sharedInstance].currentUser.contact:@"";
    _item6 = [BocoInfoItem item];
    _item6.infoMainTitle = @"操作人当前角色:";
    _item6.infoSubTitle = Dictory_NullOrNo([BocoUserAgent sharedInstance].currentUser.reservedInfo, @"operateRoleName");
    _item7 = [BocoInfoItem item];
//    _item7.pickerType = BocoDatePickerDown;
    _item7.infoMainTitle = @"操作时间*:";
    _item7.infoSubTitle = [SXTNHWSHelper getCurrentDateWithDate:[NSDate date]];
    _item8 = [BocoInfoItem item];
    _item8.infoMainTitle = @"工单附件*:";
    [_section0.items addObjectsFromArray:@[_item0, _item1, _item2, _item3, _item4,_item5, _item7 
                                           ]];
    [self.tableManager addSection:_section0];
    
}


- (void)prepareBaseOperateForAction
{
    SXTNHWSWeakSelf;
//    _item7.timeChangeHandler = ^(NSString *time) {
//        [weakSelf.baseTable reloadData];
//    };
//    [self createDispatchSourceT];
}

#pragma mark
#pragma mark HDTableViewManagerDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50.0f;
//}

#pragma mark
#pragma mark Event Response
- (void)SXTNHWSBaseOperateCommit:(UIButton *)sender
{
    SXTNHWSWeakSelf;
    if (![self SXTNHWSCheckItemInfoIntegrity])return;
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
        [weakSelf SXTNHWSBaseOperateCommitSure];
    }];
    aureButton.buttonFormatBlock = ^NSDictionary *{
        
        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
        buttonConfig[@"backgroundColor"] = SXTNHWS_MAIN_COLOR;
        buttonConfig[@"textColor"] = [UIColor whiteColor];
        buttonConfig[@"font"] = [UIFont fontWithName:@"ComicSansMS" size:13];
        return buttonConfig;
    };
    [alert showWarning:self title:@"提示" subTitle:@"确定提交吗?" closeButtonTitle:nil duration:0.0f];
    //子类重写
}

- (void)SXTNHWSBaseOperateCommitSure
{
    
}

- (BOOL)SXTNHWSCheckItemInfoIntegrity
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
                if (tempItem.infoSubTitle.length == 0 && [tempItem.infoMainTitle containsString:@"*"]) {
                    content = tempItem.infoMainTitle;
                    isStop = YES;
                    break;
                }
            }
            if ([item isMemberOfClass:[BocoButtonItem class]]) {
                BocoButtonItem * tempItem = (BocoButtonItem *)item;
                if (tempItem.buttonTitle.length == 0 && [tempItem.infoMainTitle containsString:@"*"]) {
                    content = tempItem.infoMainTitle;
                    isStop = YES;
                    break;
                }
            }
            if ([item isMemberOfClass:[BocoTextItem class]]) {
                BocoTextItem * tempItem = (BocoTextItem *)item;
                if (tempItem.text.length == 0 && [tempItem.title containsString:@"*"]) {
                    content = tempItem.title;
                    isStop = YES;
                    break;
                }
            }
            if ([item isMemberOfClass:[BocoLongTextItem class]]) {
                BocoLongTextItem * tempItem = (BocoLongTextItem *)item;
                if (tempItem.textTitle.length == 0 && [tempItem.title containsString:@"*"]) {
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
        if ([mutableString containsString:@"*"]) {
            NSRange range = [mutableString rangeOfString:@"*"];
            [mutableString deleteCharactersInRange:range];
        }
        [SXTNHWSHelper showHUDText:[NSString stringWithFormat:@"请完善%@信息",mutableString] complection:^{}];
        return NO;
    }else{
        return YES;
    }

}

- (NSDictionary *)SXTNHWSChecksubRole:(NSArray *) array
                                 city:(NSString *) city
{
    NSDictionary * tempDict = nil;
    for (NSDictionary * dict in array) {
        NSString * name = Dictory_NullOrNo(dict, @"SUBROLENAME");
        if ([name containsString:city]) {
            tempDict = dict;
            break;
        }
    }
    return tempDict;
}

- (NSDictionary *)SXTNHWSChecksubRole:(NSArray *) array
                               userId:(NSString *) userId
{
    NSDictionary * tempDict = nil;
    NSMutableArray *  tempArray = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        for (NSDictionary * userDict in Dictory_NullOrNo(dict, @"resultMap")) {
            [tempArray addObject:Dictory_NullOrNo(userDict, @"USERID")];
        }
        if ([tempArray containsObject:userId]) {
            tempDict = [dict mutableCopy];
            break;
        }
    }
    return tempDict;
}


- (void)createDispatchSourceT{
    SXTNHWSWeakSelf;
    //创建全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //使用全局队列创建计时器
    self.sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //定时器延迟时间
    NSTimeInterval delayTime = 1.0f;
    //定时器间隔时间
    NSTimeInterval timeInterval = 1.0f;
    //设置开始时间
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    //设置计时器
    dispatch_source_set_timer(self.sourceTimer,startDelayTime,timeInterval*NSEC_PER_SEC,0.1*NSEC_PER_SEC);
    //执行事件
    dispatch_source_set_event_handler(self.sourceTimer,^{
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.item7.infoSubTitle = [SXTNHWSHelper getCurrentDateWithDate:[NSDate date]];
            [weakSelf.baseTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        });
    });
    //启动计时器
    dispatch_resume(_sourceTimer);
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

- (UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_commitBtn setTitle:@"搜索" forState:UIControlStateNormal];
        if ([UIImage imageNamed:@"boco_commit"]) {
            [_commitBtn setImage:[UIImage imageNamed:@"boco_commit"] forState:UIControlStateNormal];
        }else{
            NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"ShaanXiHall_Workbench_WorkSheet" ofType:@"bundle" inDirectory:@"ShaanXiHall_Workbench_WorkSheet.framework"]];
            NSString * path = [imageBundle pathForResource:@"boco_commit@3x.png" ofType:nil];
            [_commitBtn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        }
        _commitBtn.titleLabel.font = FONT14;
        [_commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        [_searchBtn setImage:[UIImage imageNamed:@"gxjkr_main_refresh"] forState:UIControlStateNormal];
        _commitBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [_commitBtn addTarget:self action:@selector(SXTNHWSBaseOperateCommit:) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.bounds = CGRectMake(0, 0, 32, 32);
    }
    return _commitBtn;
}



#pragma mark
#pragma mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
