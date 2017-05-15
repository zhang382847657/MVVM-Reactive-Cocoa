//
//  LoginViewModel.m
//  MVVMDemo
//
//  Created by 张琳 on 2017/5/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginViewModel.h"
#import "UserModel.h"

@interface LoginViewModel ()

@end

@implementation LoginViewModel

//初始化ViewModel
- (instancetype)init {
    if (self = [super init]) {
        _loginResultSignal = [RACSubject subject];
    }
    return self;
}

-(RACSignal *)validSignal{
    
    // RACObserve(self, name):监听某个对象的某个属性,返回的是信号。 可以代替kvo
    RACSignal *userNameSiganl = RACObserve(self, userName);
    RACSignal *psdSiganl = RACObserve(self, password);
    
    //第一步  先把用户名和密码的信号进行合并
    //第二歩  把合并产生的多个返回值进行聚合，返回一个新的信号
    RACSignal *validSignal = [RACSignal combineLatest:@[userNameSiganl, psdSiganl] reduce:^id(NSString *userName, NSString *password){
        // 要求用户名和密码大于6位数
        return @(userName.length >= 6 && password.length >= 6);
    }];
    return validSignal;
}


/**
 *  登陆操作
 */
- (void)login{
    
    // 网络请求进行登录，当然这里只是模拟一下
    UserModel *user = [[UserModel alloc] init];
    user.userName = self.userName;
    user.password = self.password;
    
    
    if([user.userName isEqualToString:@"zhanglin"]&&[user.password isEqualToString:@"111111"]){
        
        [_loginResultSignal sendNext:user];// 成功发送成功的信号 同时把用户对象传递过去
        [_loginResultSignal sendCompleted];//设置完成

    }else{
        
        [_loginResultSignal sendError:nil];// 失败发送失败的信息号
        [_loginResultSignal sendCompleted];//设置完成
    }
    
    
}
@end
