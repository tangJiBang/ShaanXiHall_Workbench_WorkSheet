//
//  SXTNHWSLoginViewController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by Dailingchi on 07/04/2019.
//  Copyright © 2019年 Boco. All rights reserved.
//

#import "SXTNHWSLoginViewController.h"
#import <BocoBusiness/BocoBusiness.h>
#import <Masonry/Masonry.h>
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>
#import "ShaanxiTransmissionNetworkHiddenWorkSheetConstants.h"
#import "SXTNHWSLoginView.h"
#import "SXTNHWSHttpManager.h"
#import "SXTNHWSHelper.h"

#import <BocoBusiness/BocoBusiness.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryalluserinfosrv_InquiryAllUserInfo.h>
#import <BocoJTI/com_boco_bmdp_eoms_entity_commonsheet_inquiryallroleinfosrv_InquiryAllRoleInfo.h>

@interface SXTNHWSLoginViewController ()

@property (nonatomic, strong) SXTNHWSLoginView *inputView;

@end

@implementation SXTNHWSLoginViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:0.212 green:0.494 blue:0.702 alpha:1];
    self.inputView = [[SXTNHWSLoginView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.9);
    }];
}

- (void)prepareForAction
{
    __weak typeof(self) weakSelf = self;
    [self.inputView setLoginBlock:^(NSString *userName, NSString *passWord) {
        if (userName.length == 0) {
            [SXTNHWSHelper showHUDText:@"请输入登录用户名" complection:^{
                
            }];
        }else{
            [weakSelf loginAction:userName];
        }
    }];
}

#pragma mark
#pragma mark XXXDelegate

#pragma mark
#pragma mark Event Response

-(void)loginAction:(NSString *)userId
{
    
//    [[SXTNHWSHttpManager sharedInstance]
//     getSubRoleId:@{@"userId":userId}
//     success:^(id _Nonnull test, id _Nonnull test1) {
//         
//     }
//     failure:^(NSError * _Nonnull error) {
//         
//     }];
    
    //登录成功后保存用户信息
    [HDProgressHUDManager showLoadingAnimationWithMessage:@"登录中"];
    [[SXTNHWSHttpManager sharedInstance]
     getRoleId:@{@"roleId":@"8901",@"opType":@"shaan_op007"}
     success:^(id _Nonnull responseObject, NSArray * _Nonnull array) {
         NSDictionary * dict = array.firstObject;
         [[SXTNHWSHttpManager sharedInstance]
          getRoleId:@{@"roleId":@"8903",@"opType":@"shaan_op007"}
          success:^(id _Nonnull responseObject, NSArray * _Nonnull tempArray) {
              [[SXTNHWSHttpManager sharedInstance]
               getUserRoleInfo:@{@"userId":userId}
               success:^(id _Nonnull request, com_boco_bmdp_eoms_entity_commonsheet_inquiryallroleinfosrv_InquiryAllRoleInfo * _Nonnull roleInfo) {
                   [[SXTNHWSHttpManager sharedInstance]
                    getUserDeptInfo:@{@"userId":userId}
                    success:^(id _Nonnull request, com_boco_bmdp_eoms_entity_commonsheet_inquiryalluserinfosrv_InquiryAllUserInfo * _Nonnull deptInfo) {
                        [HDProgressHUDManager hideLoadingAnimation];
                        BocoUser * user = [[BocoUser alloc] init];
                        user.userId = deptInfo.userId;
                        user.userName = deptInfo.userName;
                        user.deptId = deptInfo.deptId;
                        user.deptName = deptInfo.deptName;
                        user.regionName = @"";
                        user.regionId = @"";
                        user.contact = deptInfo.mobile?deptInfo.mobile:@"18202817251";
                        user.phone = deptInfo.phone?deptInfo.phone:@"";
                        user.reservedInfo = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                            @"newOperateRoleId":Dictory_NullOrNo(dict, @"ID"),
                                                                                            @"newOperateRoleName":Dictory_NullOrNo(dict, @"SUBROLENAME"),
                                                                                            @"operateRoleIds":tempArray,
                                                                                            @"operateRoleId":roleInfo.roleId?roleInfo.roleId:@"",
                                                                                            @"operateRoleName":roleInfo.roleName?roleInfo.roleName:@"",
                                                                                            @"sex":deptInfo.sex?deptInfo.sex:@"",
                                                                                            @"fax":deptInfo.fax?deptInfo.fax:@"",
                                                                                            @"remark":deptInfo.remark?deptInfo.remark:@""
                                                                                            }];
                        [[BocoUserAgent sharedInstance] updateCurrentUser:user];
                        [[NSNotificationCenter defaultCenter] postNotificationName:kShaanxiTransmissionNetworkHiddenWorkSheetNotifactionLogin object:nil];
                    }
                    failure:^(NSError * _Nonnull error) {
                        [HDProgressHUDManager hideLoadingAnimation];
                    }];
               }
               failure:^(NSError * _Nonnull error) {
                   [HDProgressHUDManager hideLoadingAnimation];
               }];
          }
          failure:^(NSError * _Nonnull error) {
              [HDProgressHUDManager hideLoadingAnimation];
          }];
     }
     failure:^(NSError * _Nonnull error) {
         [HDProgressHUDManager hideLoadingAnimation];
     }];
}

#pragma mark
#pragma mark Getter/Setter

@end
