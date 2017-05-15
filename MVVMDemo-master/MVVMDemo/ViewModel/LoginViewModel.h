//
//  LoginViewModel.h
//  MVVMDemo
//
//  Created by 张琳 on 2017/5/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>


@interface LoginViewModel : NSObject
@property (nonatomic, copy) NSString *userName; //用户名
@property (nonatomic, copy) NSString *password; //密码
@property (nonatomic, strong) RACSubject *loginResultSignal; //登录结果信号提供者

//按钮是否可点击信号
- (RACSignal *)validSignal;

//登录操作
-(void)login;

@end
