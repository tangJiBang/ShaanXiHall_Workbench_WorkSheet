//
//  SXTNHWSBottomOperateView.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSBottomOperateView.h"

#import "SXTNHWSMacros.h"
#import "UIButton+SXTNHWS.h"


@interface SXTNHWSBottomOperateView ()

/** btn array */
@property(nonatomic, strong)NSMutableArray * btnArr;

/** block */
@property(nonatomic, copy)SXTNHWSBottomOperateBlock block;

@property(nonatomic, strong)UIView * lineView;

@end

@implementation SXTNHWSBottomOperateView

- (NSMutableArray *)btnArr{
    
    if (!_btnArr) {
        _btnArr = @[].mutableCopy;
    }
    return _btnArr;
}

- (instancetype)initWithFrame:(CGRect)frame
                 withDelegate:(id<SXTNHWSBottomOperateDelegate>)delegate
                       action:(SXTNHWSBottomOperateBlock)action{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor whiteColor];
        _delegate = delegate;
        _isEdit = YES;
        if (action) {
            _block = action;
        }
        //配置底部按钮
        [self configurationBottomView];
    }
    return self;
}

- (void)configurationBottomView{
    
    NSArray * iconArray = @[@"sxtnhws_details_bottombar_refresh",
                            @"sxtnhws_details_bottombar_history",
                            @"sxtnhws_details_bottombar_operate"];
    for (NSInteger i = 0; i < 3; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:i == 0?@"刷新":(i == 1?@"流转信息":@"操作") forState:UIControlStateNormal];
        if ([UIImage imageNamed:iconArray[i]]) {
            [button setImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
        }else{
            NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"ShaanXiHall_Workbench_WorkSheet" ofType:@"bundle" inDirectory:@"ShaanXiHall_Workbench_WorkSheet.framework"]];
            NSString * path = [imageBundle pathForResource:[NSString stringWithFormat:@"%@@3x.png",iconArray[i]] ofType:nil];
            [button setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button addTarget:self action:@selector(bottomViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithRed:0.23f green:0.57f blue:0.75f alpha:1.0f] forState:UIControlStateNormal];
        button.tag = kBtnTag + i;
        button.frame = CGRectMake(ScreenWidth / 3.0 * i, 0, ScreenWidth / 3.0, 50);
        if (i == 0) {
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [button setImageTopTitleBottomMargn:4];
        }else if (i == 1){
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [button setImageTopTitleBottomMargn:0];
        }else{
            [button setImageTopTitleBottomMargn:-3];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
        button.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [self addSubview:button];
        [self.btnArr addObject:button];
    }
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1.5f)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineView];
}

- (void)bottomViewClicked:(UIButton *) sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(SXTNHWSBottomOperateSelectedBtnItemType:)]) {
        
        [_delegate SXTNHWSBottomOperateSelectedBtnItemType:sender.tag - 300];
    }
    
    if (_block) {
        _block(sender.tag - kBtnTag);
    }
    NSLog(@"点击了%@", sender.titleLabel.text);
}

- (void)setOperateType:(NSString *)operateType
{
    _operateType = operateType;
    UIButton * button = [_btnArr lastObject];
    [button setTitle:operateType forState:UIControlStateNormal];
    
}

- (void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    UIButton * button = [_btnArr lastObject];
    if (_isEdit) {
        button.enabled = YES;
    }else{
        button.enabled = NO;
    }
}



@end
