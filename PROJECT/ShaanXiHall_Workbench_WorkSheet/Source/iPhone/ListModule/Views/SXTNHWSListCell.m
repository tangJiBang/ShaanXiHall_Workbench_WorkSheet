//
//  SXTNHWSListCell.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSListCell.h"

#import "SXTNHWSMacros.h"

#import <SDAutoLayout/SDAutoLayout.h>

@interface SXTNHWSListCell ()

//工单主题
@property(nonatomic, strong)UILabel * workSheetTheme;
//工单流水号
@property(nonatomic, strong)UILabel * workSheetId;
//派单时间
@property(nonatomic, strong)UILabel * sendOrderDate;
//处理时限
@property(nonatomic, strong)UILabel * dealDate;
//任务状态
@property(nonatomic, strong)UILabel * taskStatus;
@end

@implementation SXTNHWSListCell

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
    _workSheetTheme = [[UILabel alloc] init];
    _workSheetTheme.font = FONT15;
    _workSheetTheme.textColor = SXTNHWS_FloatColor(0.22f, 0.22f, 0.22f);
    [self.contentView addSubview:_workSheetTheme];
    
    _workSheetId = [[UILabel alloc] init];
    _workSheetId.font = FONT13;
    _workSheetId.textColor = SXTNHWS_FloatColor(0.60f, 0.60f, 0.60f);
    [self.contentView addSubview:_workSheetId];

    _sendOrderDate = [[UILabel alloc] init];
    _sendOrderDate.font = FONT13;
    _sendOrderDate.textColor = SXTNHWS_FloatColor(0.60f, 0.60f, 0.60f);
    [self.contentView addSubview:_sendOrderDate];

    _dealDate = [[UILabel alloc] init];
    _dealDate.font = FONT13;
    _dealDate.textColor = SXTNHWS_FloatColor(0.60f, 0.60f, 0.60f);
    [self.contentView addSubview:_dealDate];

    _taskStatus = [[UILabel alloc] init];
    _taskStatus.font = FONT13;
    _taskStatus.textColor = SXTNHWS_FloatColor(0.60f, 0.60f, 0.60f);
    [self.contentView addSubview:_taskStatus];
    
#ifdef DEBUG
    _workSheetTheme.text = @"工单主题:这是一个测试工单主题";
    _workSheetId.text = @"SX_09_09FD_FDFDSFDS";
    _sendOrderDate.text = @"2019-08-8 12:22:22";
    _dealDate.text = @"2019-08-8 12:22:22";
    _taskStatus.text = @"已完成";
#endif
}

- (void)configSubviewsAutolayout
{
    self.workSheetTheme.sd_layout
    .topSpaceToView(self.contentView, magrn /2)
    .leftSpaceToView(self.contentView, magrn)
    .rightSpaceToView(self.contentView, magrn)
    .autoHeightRatio(0);
    
    self.workSheetId.sd_layout
    .topSpaceToView(self.workSheetTheme, magrn /2)
    .leftSpaceToView(self.contentView, magrn)
    .rightSpaceToView(self.contentView, magrn)
    .autoHeightRatio(0);
    
    self.sendOrderDate.sd_layout
    .topSpaceToView(self.workSheetId, magrn /2)
    .leftSpaceToView(self.contentView, magrn)
    .rightSpaceToView(self.contentView, magrn)
    .heightIs(15);
    
    self.sendOrderDate.sd_layout
    .topSpaceToView(self.workSheetId, magrn /2)
    .leftSpaceToView(self.contentView, magrn)
    .rightSpaceToView(self.contentView, magrn)
    .heightIs(15);
    
    self.dealDate.sd_layout
    .topSpaceToView(self.sendOrderDate, magrn /2)
    .leftSpaceToView(self.contentView, magrn)
    .rightSpaceToView(self.contentView, magrn)
    .heightIs(15);

    self.taskStatus.sd_layout
    .topSpaceToView(self.dealDate, magrn /2)
    .leftSpaceToView(self.contentView, magrn)
    .rightSpaceToView(self.contentView, magrn)
    .heightIs(15);

}

- (void)setDataModel:(NSDictionary *)dataModel
{
    _dataModel = dataModel;
    _workSheetTheme.text = [NSString stringWithFormat:@"工单主题:%@",Dictory_NullOrNo(dataModel, @"TITLE")];
    _workSheetId.text = [NSString stringWithFormat:@"工单流水号:%@",Dictory_NullOrNo(dataModel, @"SHEETID")];
    _sendOrderDate.text = [NSString stringWithFormat:@"派单时间:%@",Dictory_NullOrNo(dataModel, @"SENDTIME")];
    _dealDate.text = [NSString stringWithFormat:@"处理时限:%@",Dictory_NullOrNo(dataModel, @"HIDDENDEALLIMITED")];
    _taskStatus.text = String_Equal(Dictory_NullOrNo(dataModel, @"TASKSTATUS"), @"2")?@"待处理":@"已接单";
    
    [self setupAutoHeightWithBottomView:_taskStatus bottomMargin:magrn];
}
@end
