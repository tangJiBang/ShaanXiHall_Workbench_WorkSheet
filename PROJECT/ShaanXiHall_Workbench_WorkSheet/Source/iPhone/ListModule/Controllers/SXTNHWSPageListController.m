//
//  SXTNHWSPageListController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/4.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSPageListController.h"

#import "SXTNHWSListController.h"
#import "SXTNHWSMacros.h"

#import <SDAutoLayout/SDAutoLayout.h>
@interface SXTNHWSPageListController ()

@property(nonatomic, strong)UIButton * setBtn;
@property(nonatomic, strong)UIView * hLineView;
@property(nonatomic, strong)UIView * vLineView;

@property(nonatomic, copy)void(^XZCWSPageListUpdate)(NSInteger, NSInteger);
@property(nonatomic, assign)NSInteger bdageNumber;
@end

@implementation SXTNHWSPageListController

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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark
#pragma mark PrepareConfig

- (void)prepareForData
{
    self.bdageNumber = 0;
}

- (void)prepareForView
{
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    [self.view addSubview:self.hLineView];
    [self.view addSubview:self.vLineView];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.setBtn];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
}


- (void)prepareForAction
{
    SXTNHWSWeakSelf;
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(XZCWSPageListUpdateBadge:)
//                                                 name:kXiZangCutoverWorkSheetNotifactionUpdateBageNumber
//                                               object:nil];
    _XZCWSPageListUpdate = ^(NSInteger badgeNumber, NSInteger type){
        weakSelf.bdageNumber = badgeNumber;
        [weakSelf.menuView updateBadgeViewAtIndex:type];
    };
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.hLineView.frame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 1.0);
    self.vLineView.frame = CGRectMake(CGRectGetMaxX(self.menuView.frame) / 2.0f, CGRectGetMinY(self.menuView.frame) + 2.5, 1.0f, self.menuView.frame.size.height - 5.0f);
    
}

#pragma mark
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 2;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
            case 0: return @"待办";
            case 1: return @"已建立";
    }
    return @"NONE";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    SXTNHWSListController * listVc = [[SXTNHWSListController alloc] init];
    switch (index) {
            case 0:
        {
//            listVc.workSheetType = XZCWSListWorkSheetType0;
        }
            break;
            case 1:
        {
//            listVc.workSheetType = XZCWSListWorkSheetType1;
        };
            break;
    }
    return listVc;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 60;
}

//- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index
//{
//    return 50;
//}

- (UIView *)menuView:(WMMenuView *)menu badgeViewAtIndex:(NSInteger)index
{
    if (self.bdageNumber == 0) {
        return nil;
    }
    CGRect menuFrame = menu.frame;
    //    UILabel * badgeLbl = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetMaxX(menuFrame) == 0?0:CGRectGetMaxX(menuFrame)) + 5,
    //                                                                   CGRectGetMinY(menuFrame) == 0?0:CGRectGetMaxX(menuFrame),
    //                                                                   menuFrame.size.height == 0?15:menuFrame.size.height,
    //                                                                   menuFrame.size.height == 0?15:menuFrame.size.height)];
    UILabel * badgeLbl = [[UILabel alloc] init];
    badgeLbl.layer.borderWidth = 0.5;
    badgeLbl.layer.borderColor = SXTNHWS_FloatColor(0.00f,0.74f,0.92f).CGColor;
    badgeLbl.textColor = SXTNHWS_FloatColor(0.00f,0.74f,0.92f);
    badgeLbl.textAlignment = NSTextAlignmentCenter;
    badgeLbl.font = FONT10;
    NSString * textNumber = nil;
    if (self.bdageNumber > 0 && self.bdageNumber < 10) {
        badgeLbl.text = [NSString stringWithFormat:@"%ld",self.bdageNumber];
        textNumber = [NSString stringWithFormat:@"%ld", self.bdageNumber * 10];
    }else if (self.bdageNumber >= 10 && self.bdageNumber <= 99){
        badgeLbl.text = [NSString stringWithFormat:@"%ld",self.bdageNumber];
        textNumber = [NSString stringWithFormat:@"%ld", self.bdageNumber];
    }else{
        badgeLbl.text = @"99⁺";
        textNumber = [NSString stringWithFormat:@"%ld", self.bdageNumber];
    }
    CGSize titleSize = [textNumber boundingRectWithSize:CGSizeMake(100, 0) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]} context:nil].size;
    badgeLbl.frame = CGRectMake(70,  (35 - titleSize.width - 5) / 2.0f, titleSize.width + 5, titleSize.width + 5);
    badgeLbl.layer.cornerRadius = (titleSize.width + 5) / 2.0f;
    return badgeLbl;
}


//- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
//    if (self.menuViewPosition == WMMenuViewPositionBottom) {
//        menuView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
//        return CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
//    }
//    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
//    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
//    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 44);
//}
//
//- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
//    if (self.menuViewPosition == WMMenuViewPositionBottom) {
//        return CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44);
//    }
//    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
//    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
//        originY += self.redView.frame.size.height;
//    }
//    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
//}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView
{
    menuView.backgroundColor = [UIColor whiteColor];
    return CGRectMake(0, StatusBarAndNavigationBarHeight, ScreenWidth, 35);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView
{
    return CGRectMake(0, StatusBarAndNavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarAndNavigationBarHeight);
}

#pragma mark
#pragma mark Event Response

//设置
- (void)XZCWSPageListSetClicked:(UIButton *) sender
{
    
}

//更新角标
- (void)XZCWSPageListUpdateBadge:(NSNotification *) notification
{
    NSDictionary * valueDic = (NSDictionary *)notification.object;
    NSInteger badgeNumber = [Dictory_NullOrNo(valueDic, @"badgeNumber") integerValue];
    NSInteger type = [Dictory_NullOrNo(valueDic, @"type") integerValue];
    self.XZCWSPageListUpdate(badgeNumber, type);
}
#pragma mark
#pragma mark Getter/Setter
- (UIButton *)setBtn
{
    if (!_setBtn) {
        _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setBtn setTitle:@"设置" forState:UIControlStateNormal];
        _setBtn.titleLabel.font = FONT14;
        [_setBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        [_setBtn setImage:[UIImage imageNamed:@"gxjkr_main_refresh"] forState:UIControlStateNormal];
        _setBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [_setBtn addTarget:self action:@selector(XZCWSPageListSetClicked:) forControlEvents:UIControlEventTouchUpInside];
        _setBtn.bounds = CGRectMake(0, 0, 32, 32);
    }
    return _setBtn;
}

- (UIView *)hLineView
{
    if (!_hLineView) {
        _hLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _hLineView.backgroundColor = SXTNHWS_MAIN_COLOR;
    }
    return _hLineView;
}

- (UIView *)vLineView
{
    if (!_vLineView) {
        _vLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _vLineView.backgroundColor = SXTNHWS_FloatColor(0.22f,0.22f,0.22f);
    }
    return _vLineView;
}


#pragma mark
#pragma mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

