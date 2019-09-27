//
//  SXTNHWSLoginView.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by Dailingchi on 07/04/2019.
//  Copyright © 2019年 Boco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXTNHWSLoginView : UIView

@property (nonatomic, copy) void (^loginBlock)(NSString *userName,NSString *passWord);

@end
