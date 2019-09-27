//
//  SXTNHWSBottomOperateView.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SXTNHWSBottomOperateType) {
    /**刷新*/
    SXTNHWSBottomOperateRefresh = 0,
    /**历史*/
    SXTNHWSBottomOperateHistory,
    /**操作*/
    SXTNHWSBottomOperateOperate
};

typedef void(^SXTNHWSBottomOperateBlock)(SXTNHWSBottomOperateType type);

@protocol  SXTNHWSBottomOperateDelegate <NSObject>

@optional

- (void)SXTNHWSBottomOperateSelectedBtnItemType:(SXTNHWSBottomOperateType) type;

@end


NS_ASSUME_NONNULL_BEGIN

@interface SXTNHWSBottomOperateView : UIView

/** 操作类型 */
@property(nonatomic, strong)NSString * operateType;

/** 操作按钮是否可点击 */
@property(nonatomic, assign)BOOL isEdit;

/** 代理 */
@property(nonatomic, assign)id <SXTNHWSBottomOperateDelegate> delegate;

/** 初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame
                 withDelegate:(id <SXTNHWSBottomOperateDelegate>) delegate
                       action:(SXTNHWSBottomOperateBlock) action;

@end

NS_ASSUME_NONNULL_END
