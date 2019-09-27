//
//  SXTNHWSBaseOperationController.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSBaseController.h"

#import "SXTNHWSEnum.h"

@class HDTableViewManager;
@class HDTableViewSection;
@class BocoTextItem;
@class BocoDatePickerItem;
NS_ASSUME_NONNULL_BEGIN

@interface SXTNHWSBaseOperationController : SXTNHWSBaseController

#pragma mark UI
/**tableManager*/
@property(nonatomic, strong)HDTableViewManager * tableManager;
/**section0*/
@property(nonatomic, strong)HDTableViewSection * section0;

#pragma mark data
/**列表模型model*/
@property(nonatomic, strong)NSDictionary * listModel;
/**详情数据*/
@property(nonatomic, strong)NSDictionary * detailsDic;
/**当前操作类型*/
@property(nonatomic, assign)SXTNHWSWorkSheetOperationType  operationType;
/**当前从列表还是搜索列表进入*/
//@property(nonatomic, assign)XZCWSPushCompleteType  pushType;
/**当前操作获取派发对象的初始id*/
@property(nonatomic, strong)NSString * sendOwnerId;

/**opType*/
@property(nonatomic, strong)NSString * opType;

/**派发给公司name*/
@property(nonatomic, strong)NSString * companyName;
/**派发给公司namId*/
@property(nonatomic, strong)NSString * companyNameId;

/**roledDict*/
@property(nonatomic, strong)NSDictionary * roleDict;

#pragma mark methods

/**提交操作(主要是弹出提示框)*/
- (void)SXTNHWSBaseOperateCommit:(UIButton *)sender;

/**提交请求*/
- (void)SXTNHWSBaseOperateCommitSure;

/**检查信息完整性*/
- (BOOL)SXTNHWSCheckItemInfoIntegrity;

/**判断当前工单该用什么子角色*/
- (NSDictionary *)SXTNHWSChecksubRole:(NSArray *) array
                                 city:(NSString *) city;
@end

NS_ASSUME_NONNULL_END
