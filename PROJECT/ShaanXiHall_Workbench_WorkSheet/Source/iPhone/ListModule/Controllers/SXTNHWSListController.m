//
//  SXTNHWSListController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/4.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSListController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSListCell.h"
#import "SXTNHWSHelper.h"
#import "SXTNHWSDetailsController.h"
#import "ShaanxiTransmissionNetworkHiddenWorkSheetConstants.h"

#import <BocoJTI/com_boco_bmdp_eoms_service_newcommon_INewCommon.h>
#import <BocoJTIRetrofit/BocoJTIRetrofit.h>
#import <YYModel/YYModel.h>
#import <BocoBusiness/BocoBusiness.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>
#import <HaidoraRefresh/HaidoraRefresh.h>
#import <SDAutoLayout/SDAutoLayout.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface SXTNHWSListController ()

<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>
@end

@implementation SXTNHWSListController

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
    SXTNHWSWeakSelf;
    NSDictionary * param = @{
//                             @"operateRoleId":Dictory_NullOrNo([BocoUserAgent sharedInstance].currentUser.reservedInfo, @"newOperateRoleId"),
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
         [weakSelf stopFailureRefresh];
         SXTNHWSShowAlerView(error.localizedDescription);
     }];
}

- (void)prepareForView
{
    self.baseTable.delegate = self;
    self.baseTable.dataSource = self;
    self.baseTable.emptyDataSetDelegate = self;
    self.baseTable.emptyDataSetSource = self;
    [self.baseTable registerClass:[SXTNHWSListCell class] forCellReuseIdentifier:IDENTFIER];
}

- (void)prepareForAction
{
    SXTNHWSWeakSelf;
    [self.baseTable addPullToRefreshWithActionHandler:^{
        weakSelf.page = 0;
        [weakSelf prepareForData];
    }];
    [self.baseTable addInfiniteToRefreshWithActionHandler:^{
        weakSelf.page++;
        [weakSelf prepareForData];
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshList)
                                                 name:kShaanxiTransmissionNetworkHiddenWorkSheetNotifactionUndoList
                                               object:nil];
}

#pragma mark
#pragma mark XXXDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataArr[indexPath.row];
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
    cell.dataModel = self.dataArr[indexPath.row];
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

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if ([UIImage imageNamed:@"error_server"]) {
        return [UIImage imageNamed:@"error_server"];
    }else{
        NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"ShaanXiHall_Workbench_WorkSheet" ofType:@"bundle" inDirectory:@"ShaanXiHall_Workbench_WorkSheet.framework"]];
        NSString * path = [imageBundle pathForResource:@"error_server@3x.png" ofType:nil];
        return [UIImage imageWithContentsOfFile:path];
    }

}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"提示";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂时没有数据";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView
                                          forState:(UIControlState)state {
    NSString *text = @"刷新试试";
    UIFont   *font = [UIFont systemFontOfSize:15.0];
    // 设置默认状态、点击高亮状态下的按钮字体颜色
    UIColor  *textColor = nil;
    if (state == UIControlStateNormal) {
        textColor = [UIColor colorWithRed:0.0f green:0.45f blue:0.91f alpha:1.0f];
    }else{
        textColor = [UIColor colorWithRed:0.0f green:0.65f blue:0.91f alpha:1.0f];
    }
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font      forKey:NSFontAttributeName];
    //    [attributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    NSMutableAttributedString *attributeSring=[[NSMutableAttributedString alloc]initWithString:text
                                                                                    attributes:attributes];
    //    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
    //    paragraphStyle.firstLineHeadIndent=60;
    //    paragraphStyle.lineSpacing=10;
    //    [attributeSring addAttribute:NSParagraphStyleAttributeName
    //                           value:paragraphStyle
    //                           range:NSMakeRange(0,attributeSring.length)];
    
    
    return attributeSring;
}

- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self.baseTable triggerPullToRefresh];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -TabbarHeight-StatusBarHeight+20;
}
#pragma mark
#pragma mark Event Response

- (void)reloadWithData:(NSDictionary *) dict
{
    SXTNHWSWeakSelf;
    if (String_Equal(Dictory_NullOrNo(dict, @"serviceFlag"), @"TRUE")) {
        [weakSelf stopSuccessRefresh];
        if ([dict.allKeys containsObject:@"datalist"]) {
            if (self.page == 0) {
                [self.dataArr removeAllObjects];
            }
            [weakSelf.dataArr addObjectsFromArray:Dictory_NullOrNo(dict, @"datalist")];
            [self.baseTable reloadData];
        }else{
            if (self.page > 0) {
                self.page--;
            }
            [SXTNHWSHelper showHUDText:@"没有更多数据!" complection:^{}];
        }
    }else{
        [weakSelf stopFailureRefresh];
        SXTNHWSShowAlerView(Dictory_NullOrNo(dict, @"serviceMessage"));
    }
}
- (void)stopSuccessRefresh
{
    if (self.page > 0) {
        [self.baseTable stopInfiniteRefresh];
    }else{
        [self.baseTable stopPullRefresh];
    }

}
- (void)stopFailureRefresh
{
    if (self.page > 0) {
        [self.baseTable stopInfiniteRefresh];
        self.page--;
    }else{
        [self.baseTable stopPullRefresh];
    }
}

- (void)refreshList
{
    [self.baseTable triggerPullToRefresh];
}
#pragma mark
#pragma mark Getter/Setter
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
