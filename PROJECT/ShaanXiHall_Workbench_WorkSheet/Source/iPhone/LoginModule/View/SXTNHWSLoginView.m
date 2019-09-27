//
//  SXTNHWSLoginView.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by Dailingchi on 07/04/2019.
//  Copyright © 2019年 Boco. All rights reserved.
//

#import "SXTNHWSLoginView.h"
#import <Masonry/Masonry.h>

@interface SXTNHWSLoginView ()

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *passWord;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation SXTNHWSLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.userName];
    [self addSubview:self.passWord];
    [self addSubview:self.loginButton];
    
     CGFloat margin = 20;
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(margin);
        make.top.equalTo(self);
        make.right.equalTo(self).offset(-margin);
        make.height.equalTo(self.userName.mas_width).multipliedBy(1.0/6.5);
    }];
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(margin);
        make.top.equalTo(self.userName.mas_bottom).offset(margin/2);
        make.right.equalTo(self).offset(-margin);
        make.height.equalTo(self.passWord.mas_width).multipliedBy(1.0/6.5);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(margin);
        make.top.equalTo(self.passWord.mas_bottom).offset(margin);
        make.right.equalTo(self).offset(-margin);
        make.height.equalTo(self.loginButton.mas_width).multipliedBy(1.0/6.5);
        
        make.bottom.equalTo(self);
    }];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.userName.layer.cornerRadius = CGRectGetHeight(self.userName.bounds)/2.0;
    self.passWord.layer.cornerRadius = CGRectGetHeight(self.passWord.bounds)/2.0;
    self.loginButton.layer.cornerRadius = CGRectGetHeight(self.loginButton.bounds)/2.0;
}

#pragma mark
#pragma mark Action

-(void)loginAction
{
    if (self.loginBlock)
    {
        self.loginBlock(self.userName.text,self.passWord.text);
    }
}

#pragma mark
#pragma mark Getter/Setter

-(UITextField *)userName
{
    if (nil == _userName)
    {
        UITextField *textFiled = [[UITextField alloc]init];
        textFiled.placeholder = @"请输入帐号";
        textFiled.textAlignment = NSTextAlignmentCenter;
        textFiled.textColor = [UIColor blackColor];
        textFiled.backgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1];
        textFiled.translatesAutoresizingMaskIntoConstraints = NO;
#ifdef DEBUG
        //西安:test   商洛:zhoupeng
        textFiled.text = @"test";
#endif
        _userName = textFiled;
    }
    return _userName;
}

-(UITextField *)passWord
{
    if (nil == _passWord)
    {
        UITextField *textFiled = [[UITextField alloc]init];
        textFiled.placeholder = @"请输入密码";
        textFiled.textAlignment = NSTextAlignmentCenter;
        textFiled.textColor = [UIColor blackColor];
        textFiled.backgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1];
        textFiled.translatesAutoresizingMaskIntoConstraints = NO;
#ifdef DEBUG
        textFiled.text = @"Eoms!@123";
#endif
        _passWord = textFiled;
        _passWord.secureTextEntry = YES;
        
    }
    return _passWord;
}

-(UIButton *)loginButton
{
    if (nil == _loginButton)
    {
        UIButton *button = [[UIButton alloc]init];
        button.contentMode = UIViewContentModeCenter;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:0.463 green:0.702 blue:0.839 alpha:1]];
        
        _loginButton = button;
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        
    }
    return _loginButton;
}

@end
