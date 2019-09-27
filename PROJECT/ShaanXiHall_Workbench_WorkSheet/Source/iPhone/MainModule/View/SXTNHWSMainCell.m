//
//  SXTNHWSMainCell.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/4.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSMainCell.h"

#import "SXTNHWSMacros.h"

#import <SDAutoLayout/SDAutoLayout.h>

@interface SXTNHWSMainCell ()

//icon
@property(nonatomic, strong)UIImageView * iconImgView;
//title
@property(nonatomic, strong)UILabel * titleLbl;
@end

@implementation SXTNHWSMainCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style
               reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
        [self configSubviewsAutolayout];
    }
    return self;
}

- (void)configSubviews
{
    _iconImgView = [[UIImageView alloc] init];
    _iconImgView.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:_iconImgView];
    
    _titleLbl = [[UILabel alloc] init];
    _titleLbl.font = FONT15;
    _titleLbl.textColor = SXTNHWS_FloatColor(0.22f, 0.22f, 0.22f);
    [self.contentView addSubview:_titleLbl];
}

- (void)configSubviewsAutolayout
{
    self.iconImgView.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, magrn / 2)
    .widthIs(30)
    .heightEqualToWidth();
    
    self.titleLbl.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.iconImgView, magrn / 2)
    .rightSpaceToView(self.contentView, magrn)
    .heightIs(20.0f);
    
}

- (void)setModel:(NSDictionary *)model
{
    _model = model;
    _iconImgView.image = [UIImage imageNamed:Dictory_NullOrNo(model, @"icon")];
    _titleLbl.text = Dictory_NullOrNo(model, @"title");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
