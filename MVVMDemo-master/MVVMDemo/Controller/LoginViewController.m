//
//  LoginViewController.m
//  MVVMDemo
//
//  Created by 张琳 on 2017/5/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "UserModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "LoginSuccessViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTF; //用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *psdTF; //密码输入框
@property (weak, nonatomic) IBOutlet UIButton *loginBtn; //登录按钮

@property (nonatomic , strong) UIAlertView *alertView;//提示框

@property (nonatomic, strong) LoginViewModel *viewModel; //ViewMoel

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    [self bindModel];//绑定ViewModel
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


/**
 *  绑定Model中的各种事件
 */
- (void)bindModel {
    
    
    self.viewModel = [[LoginViewModel alloc] init]; //初始化ViewModel
    
    //用于给某个对象的某个属性绑定
    RAC(self.viewModel, userName) = self.userTF.rac_textSignal;
    RAC(self.viewModel, password) = self.psdTF.rac_textSignal;
    RAC(self.loginBtn, enabled) = [self.viewModel validSignal];
    
    
    RAC(self.userTF,text) = RACObserve(self.viewModel, userName);;
    RAC(self.psdTF,text) = RACObserve(self.viewModel, password);

    

    @weakify(self);
    [self.viewModel.loginResultSignal subscribeNext:^(UserModel *user) {
        @strongify(self);
        
        //初始化登录成功页面
        LoginSuccessViewController *vc = [[LoginSuccessViewController alloc]initWithUser:user];
        
        //订阅保存的信号  得到保存后的User对象
        [vc.saveSubject subscribeNext:^(UserModel *userModel) {
            
            //给当前的ViewModel的属性进行重新的赋值
            self.viewModel.userName = userModel.userName;
            self.viewModel.password = userModel.password;
        }];
        
        //跳转到登录成功页面
        [self.navigationController pushViewController:vc animated:YES];
        
    } error:^(NSError * _Nullable error) {
        
        @strongify(self);
        self.alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"用户名或密码错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [self.alertView show];
        
    }];
    
    
    // 添加按钮点击事件
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel login];
    }];
    
}




//#pragma TextField-Delegate
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//
//    if(textField == self.userTF){
//        self.viewModel.userString = currentString;
//    }else{
//        self.viewModel.psdString = currentString;
//    }
//    
//    self.loginBtn.enabled = self.viewModel.loginEnable;
//    return true;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
