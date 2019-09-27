//
//  UIButton+SXTNHWS.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/5.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "UIButton+SXTNHWS.h"

@implementation UIButton (SXTNHWS)

- (void)setImageTopTitleBottomMargn:(CGFloat)margn{
    
    if (margn >= 0) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height,-self.imageView.frame.size.width + margn, 0.0,0.0)];
        //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    }else{
        [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height,0.0 , 0.0, -margn)];
        //文字距离上边框的距离增加imageView的高度，距离右边框增加imageView的宽度，距离下边框和右边框距离不变
    }
    [self setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -self.titleLabel.bounds.size.width)];
    //图片距离右边框距离减少图片的宽度，其它不边
    
}

@end
