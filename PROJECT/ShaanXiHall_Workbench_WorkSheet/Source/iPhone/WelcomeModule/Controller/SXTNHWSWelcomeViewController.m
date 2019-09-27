//
//  SXTNHWSWelcomeViewController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by Dailingchi on 2017/3/2.
//  Copyright © 2017年 Boco. All rights reserved.
//

#import "SXTNHWSWelcomeViewController.h"
#import "ShaanxiTransmissionNetworkHiddenWorkSheetConstants.h"
#import <HaidoraProgressHUDManager/HaidoraProgressHUDManager.h>

@interface SXTNHWSWelcomeViewController ()

@end

@implementation SXTNHWSWelcomeViewController
#pragma mark
#pragma mark Init

#pragma mark
#pragma mark Life Cycle

- (void)viewDidLoad
{
    __weak typeof(self) weakSelf = self;
    [super viewDidLoad];
    [self prepareForData];
    [self prepareForView];
    [self prepareForAction];
    
    #warning checkInfo
    [HDProgressHUDManager showLoadingAnimationInView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HDProgressHUDManager hideLoadingAnimationInView:weakSelf.view];
        [self welcomeFinish];
    });
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
}

- (void)prepareForAction
{
}

#pragma mark
#pragma mark XXXDelegate

#pragma mark
#pragma mark Event Response

-(void)welcomeFinish
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kShaanxiTransmissionNetworkHiddenWorkSheetNotifactionWelcome object:nil];
}

#pragma mark
#pragma mark Getter/Setter

@end
