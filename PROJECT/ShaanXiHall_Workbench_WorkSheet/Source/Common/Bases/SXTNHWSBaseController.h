//
//  SXTNHWSBaseController.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/4.
//  Copyright © 2019 Boco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXTNHWSBaseController : UIViewController

#pragma mark UI
/**基类table布局*/
@property(nonatomic, strong)UITableView * baseTable;
/**page*/
@property(nonatomic, assign)NSInteger page;
/**数据存储arr*/
@property(nonatomic, strong)NSMutableArray * dataArr;

#pragma mark methods
/**主要用于刷新列表界面*/
- (void)SXTNHWSBaseRefresh;

@end

NS_ASSUME_NONNULL_END
