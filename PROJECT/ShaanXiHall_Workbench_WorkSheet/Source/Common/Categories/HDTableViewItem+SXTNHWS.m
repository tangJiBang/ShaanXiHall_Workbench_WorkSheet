//
//  HDTableViewItem+SXTNHWS.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/24.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "HDTableViewItem+SXTNHWS.h"

#import <objc/runtime.h>

@implementation HDTableViewItem (SXTNHWS)

- (void)setDictId:(NSString *)dictId
{
        objc_setAssociatedObject(self,
                                 @selector(dictId),
                                 dictId,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)dictId
{
    return objc_getAssociatedObject(self,@selector(dictId));
}


@end
