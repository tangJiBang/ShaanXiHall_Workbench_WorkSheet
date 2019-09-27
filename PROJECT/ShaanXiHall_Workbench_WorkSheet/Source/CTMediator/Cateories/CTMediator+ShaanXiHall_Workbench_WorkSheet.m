//
//  CTMediator+ShaanXiHall_Workbench_WorkSheet.m
//  ShaanXiHall_Workbench_WorkSheet
//
//  Created by tangji on 2019/9/27.
//  Copyright © 2019 TJ. All rights reserved.
//

#import "CTMediator+ShaanXiHall_Workbench_WorkSheet.h"

NSString * const kCTMediatorTargetWorkSheet = @"ShaanXiHall_Workbench_WorkSheet";

NSString * const kCTMediatorActionNativeMianViewController = @"nativeMianViewController";


@implementation CTMediator (ShaanXiHall_Workbench_WorkSheet)

- (id)mainViewController
{
    UIViewController * mainViewController = [self performTarget:kCTMediatorTargetWorkSheet
                                                         action:kCTMediatorActionNativeMianViewController
                                                         params:@{@"key":@"value"}
                                              shouldCacheTarget:YES];
    if ([mainViewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return mainViewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
