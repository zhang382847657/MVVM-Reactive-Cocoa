//
//  LoginSuccessViewController.h
//  MVVMDemo
//
//  Created by 张琳 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginSuccessViewController : UIViewController
@property (nonatomic,strong) RACSubject *saveSubject;//保存并返回的信号
-(id)initWithUser:(UserModel *)user;
@end
