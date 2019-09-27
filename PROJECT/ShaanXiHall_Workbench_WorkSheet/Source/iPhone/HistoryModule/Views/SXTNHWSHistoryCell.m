//
//  SXTNHWSHistoryCell.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSHistoryCell.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSConfigs.h"

#import <SDAutoLayout/SDAutoLayout.h>

@interface SXTNHWSHistoryCell ()

//操作人
@property(nonatomic, strong)UILabel * operationUserName;
//操作类型
@property(nonatomic, strong)UILabel * operationType;
//操作时间
@property(nonatomic, strong)UILabel * operationDate;

@end

@implementation SXTNHWSHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
        [self configSubviewsAutolayout];
    }
    return  self;
}

- (void)configSubviews
{
    _operationUserName = [[UILabel alloc] init];
    _operationUserName.font = FONT15;
    _operationUserName.textColor = SXTNHWS_FloatColor(0.22f, 0.22f, 0.22f);
    [self.contentView addSubview:_operationUserName];
    
    _operationType = [[UILabel alloc] init];
    _operationType.font = FONT13;
    _operationType.textColor = SXTNHWS_FloatColor(0.60f, 0.60f, 0.60f);
    [self.contentView addSubview:_operationType];
    
    _operationDate = [[UILabel alloc] init];
    _operationDate.font = FONT13;
    _operationDate.textColor = SXTNHWS_FloatColor(0.60f, 0.60f, 0.60f);
    [self.contentView addSubview:_operationDate];
    
#ifdef DEBUG
    _operationUserName.text = @"操作人:唐继";
    _operationType.text = @"操作类型:新建派单";
    _operationDate.text = @"操作时间:2019-08-8 12:22:22";
#endif
}

- (void)configSubviewsAutolayout
{
    self.operationUserName.sd_layout
    .topSpaceToView(self.contentView, magrn /2)
    .leftSpaceToView(self.contentView, magrn)
    .rightSpaceToView(self.contentView, magrn)
    .heightIs(15);
    
    self.operationType.sd_layout
    .topSpaceToView(self.operationUserName, magrn /2)
    .leftSpaceToView(self.contentView, magrn)
    .widthIs(140.0f)
    .heightIs(15.0f);
    
    self.operationDate.sd_layout
    .centerYEqualToView(self.operationType)
    .leftSpaceToView(self.operationType, magrn)
    .rightSpaceToView(self.contentView, magrn)
    .heightIs(15);
    
}
- (void)setDataModel:(NSDictionary *)dataModel
{
    _dataModel = dataModel;
    _operationUserName.text = [NSString stringWithFormat:@"操作人:%@",Dictory_NullOrNo(dataModel, @"OPERATEUSERID")];
    _operationType.text = [NSString stringWithFormat:@"操作类型:%@",Dictory_NullOrNo([SXTNHWSConfigs sharedInstance].hitoryOperateType, Dictory_NullOrNo(dataModel, @"OPERATETYPE"))];
    _operationDate.text = [NSString stringWithFormat:@"操作时间:%@",Dictory_NullOrNo(dataModel, @"OPERATETIME")];
}
@end
