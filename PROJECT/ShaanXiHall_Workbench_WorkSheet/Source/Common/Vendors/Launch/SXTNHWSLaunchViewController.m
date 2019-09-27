//
//  SXTNHWSLaunchViewController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by Dailingchi on 2017/3/2.
//  Copyright © 2017年 Boco. All rights reserved.
//

#import "SXTNHWSLaunchViewController.h"

@interface SXTNHWSLaunchViewController ()

@property (nonatomic, strong) UIView *snapshotView;
@property (nonatomic, strong) NSString *launchScreenName;
@property (nonatomic, assign) BOOL isStatusBarInitiallyHidden;

@end

@implementation SXTNHWSLaunchViewController

#pragma mark
#pragma mark Init

#pragma mark
#pragma mark Life Cycle

-(void)loadView
{
    self.view = [self loadLaunchIB];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareForData];
    [self prepareForView];
    [self prepareForAction];
    
    UIApplication *app = [UIApplication sharedApplication];
    self.view.frame = app.keyWindow.bounds;
    [self.view layoutIfNeeded];
    if (self.isStatusBarInitiallyHidden)
    app.keyWindow.windowLevel = UIWindowLevelStatusBar+1;
    [app.keyWindow addSubview:self.snapshotView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.snapshotView removeFromSuperview];
    UIApplication *app = [UIApplication sharedApplication];
    if (self.isStatusBarInitiallyHidden)
    app.keyWindow.windowLevel = UIWindowLevelNormal;
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

#pragma mark
#pragma mark Getter/Setter

- (UIView *)snapshotView
{
    if (_snapshotView == nil)
    {
        UIView *viewCopy = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.view]];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:viewCopy];
        viewCopy.frame = window.bounds;
        
        UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, YES, 0.0);
        [viewCopy.layer renderInContext:UIGraphicsGetCurrentContext()];
        [viewCopy removeFromSuperview];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _snapshotView = [[UIImageView alloc] initWithImage:img];
        _snapshotView.frame = [UIScreen mainScreen].bounds;
    }
    return _snapshotView;
}

-(UIView *)loadLaunchIB
{
    UIView *launchView = nil;
    NSString *launchIBName = [[NSBundle mainBundle] infoDictionary][@"UILaunchStoryboardName"];
    if (launchIBName)
    {
        //nib
        if ([[NSBundle mainBundle] pathForResource:launchIBName ofType:@".nib"])
        {
            launchView = [[UINib nibWithNibName:launchIBName bundle:nil] instantiateWithOwner:self options:nil].firstObject;
        }
    }
    return launchView;
}

- (BOOL)isStatusBarInitiallyHidden
{
    return [[[NSBundle mainBundle] infoDictionary][@"UIStatusBarHidden"] boolValue];
}

- (BOOL)prefersStatusBarHidden
{
    return self.isStatusBarInitiallyHidden;
}

@end
