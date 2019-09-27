//
//  SXTNHWSCompleteController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/30.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSCompleteController.h"

#import "SXTNHWSMacros.h"
#import "SXTNHWSHelper.h"
#import "ShaanxiTransmissionNetworkHiddenWorkSheetConstants.h"
#import "SXTNHWSPageListController.h"
#import "SXTNHWSDetailsController.h"
#import "SXTNHWSListController.h"

#import <BocoFormManager/BocoFormManager.h>
#import <BocoBusiness/BocoBusiness.h>
#import <HaidoraAlertViewManager/HaidoraAlertViewManager.h>
#import <BocoJTI/com_boco_bmdp_eoms_service_newcommon_INewCommon.h>
#import <BocoJTIRetrofit/BocoJTIRetrofit.h>
#import <BocoBusiness/BocoBusiness.h>
#import <YYModel/YYModel.h>
#import <SDAutoLayout/SDAutoLayout.h>
#import <Masonry/Masonry.h>


@interface SXTNHWSCompleteController ()

@property (nonatomic, strong) UIImageView * sucImgView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIButton * bottomBtn;

@end

@implementation SXTNHWSCompleteController

#pragma mark
#pragma mark Init

#pragma mark
#pragma mark Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareForData];
    [self prepareForView];
    [self prepareForAction];
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
}

#pragma mark
#pragma mark PrepareConfig

- (void)prepareForData
{
    
}

- (void)prepareForView
{
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.baseTable removeFromSuperview];
    self.title= @"工单操作成功";
    
    //    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 194)];
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.masksToBounds = YES;
    [self.view addSubview:_bgView];
    _bgView.sd_layout
    .topSpaceToView(self.view, 88 + 30)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .bottomSpaceToView(self.view, 100);
    
    
    if ([UIImage imageNamed:@"sxtnhws_operate_success"]) {
        _sucImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sxtnhws_operate_success"]];
    }else{
        NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"ShaanXiHall_Workbench_WorkSheet" ofType:@"bundle" inDirectory:@"ShaanXiHall_Workbench_WorkSheet.framework"]];
        NSString * path = [imageBundle pathForResource:@"sxtnhws_operate_success@3x.png" ofType:nil];
        _sucImgView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
    }
    [self.bgView addSubview:_sucImgView];
    _sucImgView.sd_layout
    .topSpaceToView(_bgView, 30)
    .centerXEqualToView(_bgView)
    .widthIs(86)
    .heightIs(86);
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.text = @"工单操作成功!";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.bgView addSubview:_contentLabel];
    _contentLabel.sd_layout
    .topSpaceToView(_sucImgView, 30)
    .centerXEqualToView(_bgView)
    .widthRatioToView(_bgView, 0.5)
    .heightIs(20);
    
    
    for (NSInteger i = 0; i < (self.operationType == SXTNHWSWorkSheetOperationType61?2:1); i++) {
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setBackgroundImage:[self createImageWithColor:[UIColor lightTextColor]] forState:UIControlStateNormal];
        [_bottomBtn setBackgroundImage:[self createImageWithColor:SXTNHWS_MAIN_COLOR] forState:UIControlStateHighlighted];
        [_bottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _bottomBtn.layer.cornerRadius = 5;
        _bottomBtn.layer.masksToBounds = YES;
        if (i == 0) {
            [_bottomBtn setTitle:@"返回工单列表" forState:UIControlStateNormal];
        }else{
            [_bottomBtn setTitle:@"返回继续操作" forState:UIControlStateNormal];
        }
        [_bottomBtn addTarget:self action:@selector(completeClicked:) forControlEvents:UIControlEventTouchUpInside];
        _bottomBtn.tag = 300 + i;
        [self.view addSubview:_bottomBtn];
        _bottomBtn.sd_layout
        .bottomSpaceToView(self.view, 50)
        .leftSpaceToView(self.view, 10 + i * ((ScreenWidth - 30) / 2.0f + 10))
        .widthIs(self.operationType == SXTNHWSWorkSheetOperationType61?(ScreenWidth - 30) / 2.0f:ScreenWidth - 20)
        .heightIs(40);
    }
    self.navigationItem.hidesBackButton = YES;
    
}


- (void)prepareForAction
{
    
}
#pragma mark
#pragma mark HDTableViewManagerDelegate

#pragma mark
#pragma mark Event Response
//返回colorImage
- (UIImage*) createImageWithColor:(UIColor *) color{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

- (void)completeClicked:(UIButton *) sender{
    
    if (sender.tag - 300 == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kShaanxiTransmissionNetworkHiddenWorkSheetNotifactionUndoList object:nil];
        for (UIViewController * controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[SXTNHWSListController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
                break;
            }
        }
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kShaanxiTransmissionNetworkHiddenWorkSheetNotifactionUndoList object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kShaanxiTransmissionNetworkHiddenWorkSheetNotifactionDetails object:nil];
        for (UIViewController * controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[SXTNHWSDetailsController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
                break;
            }
        }
    }
}


#pragma mark
#pragma mark Getter/Setter

#pragma mark
#pragma mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
