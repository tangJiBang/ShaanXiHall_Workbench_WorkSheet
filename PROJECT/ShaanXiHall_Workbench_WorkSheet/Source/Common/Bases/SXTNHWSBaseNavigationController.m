//
//  SXTNHWSBaseNavigationController.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/4.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSBaseNavigationController.h"

@interface SXTNHWSBaseNavigationController ()

@end

@implementation SXTNHWSBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 10, 10);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        if ([UIImage imageNamed:@"boco_back"]) {
            [button setImage:[UIImage imageNamed:@"boco_back"] forState:UIControlStateNormal];
        }else{
            NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"ShaanXiHall_Workbench_WorkSheet" ofType:@"bundle" inDirectory:@"ShaanXiHall_Workbench_WorkSheet.framework"]];
            NSString * path = [imageBundle pathForResource:@"boco_back@3x.png" ofType:nil];
            [button setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        }
        button.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
