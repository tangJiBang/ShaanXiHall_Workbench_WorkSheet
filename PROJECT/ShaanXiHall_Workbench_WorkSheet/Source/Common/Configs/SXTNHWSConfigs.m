//
//  SXTNHWSConfigs.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/1.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSConfigs.h"

#import "NSObject+SXTNHWS.h"

@implementation SXTNHWSConfigs

HABM_DEFINE_SINGLETON(SXTNHWSConfigs)

- (NSDictionary *)hitoryOperateType{
    __weak typeof(self) weakSelf = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakSelf.hitoryOperateType = @{
                                       @"-15":@"抄送确认",
                                       @"-14":@"强制作废",
                                       @"-13":@"强制归档",
                                       @"-12":@"作废",
                                       @"-11":@"阶段通知",
                                       @"-10":@"抄送",
                                       @"0":@"提交申请",
                                       @"3":@"草稿派发",
                                       @"4":@"驳回上一级",
                                       @"6":@"处理回复通过",
                                       @"7":@"处理回复不通过",
                                       @"8":@"转派",
                                       @"9":@"阶段回复",
                                       @"10":@"分派",
                                       @"11":@"分派回复",
                                       @"22":@"保存草稿",
                                       @"30":@"会审",
                                       @"54":@"重新派发",
                                       @"61":@"确认受理",
                                       @"88":@"转审",
                                       @"101":@"通过",
                                       @"102":@"处理完成",
                                       @"103":@"处理完成",
                                       @"104":@"质检通过",
                                       @"105":@"质检不通过",
                                       @"106":@"质检通过",
                                       @"107":@"质检不通过"
                                       };
    });
    
    return _hitoryOperateType;
    
}

- (NSArray *)operateName{
    __weak typeof(self) weakSelf = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakSelf.operateName = @[
                                 
                                 [[NSObject alloc] initWithKey:@(SXTNHWSWorkSheetOperationType61) value:@"确认受理"],
                                 [[NSObject alloc] initWithKey:@(SXTNHWSWorkSheetOperationType102) value:@"处理完成"],
                                 [[NSObject alloc] initWithKey:@(SXTNHWSWorkSheetOperationType103) value:@"处理完成"],
                                 [[NSObject alloc] initWithKey:@(SXTNHWSWorkSheetOperationType8) value:@"转派"],
                                 ];
        
        
    });
    return _operateName;
}

- (NSArray *)operateAction{
    __weak typeof(self) weakSelf = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakSelf.operateAction = @[
                                   
                                   [[NSObject alloc] initWithKey:@(SXTNHWSWorkSheetOperationType61) value:@"SXTNHWSAcceptController"],
                                   [[NSObject alloc] initWithKey:@(SXTNHWSWorkSheetOperationType102) value:@"SXTNHWSDealCompleteController"],
                                   [[NSObject alloc] initWithKey:@(SXTNHWSWorkSheetOperationType103) value:@"SXTNHWSDealCompleteController"],
                                   [[NSObject alloc] initWithKey:@(SXTNHWSWorkSheetOperationType8) value:@"SXTNHWSTurntoSendController"],
                                   ];
        
        
    });
    return _operateAction;
}

- (NSArray *)manufacturerName{
    __weak typeof(self) weakSelf = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakSelf.manufacturerName = @[//、中兴、烽火、光迅、
                                      @"华为",
                                      @"中兴",
                                      @"烽火",
                                      @"光迅",
                                      @"其他"
                                   ];
        
        
    });
    return _manufacturerName;
}

@end
