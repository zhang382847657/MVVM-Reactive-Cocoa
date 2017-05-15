//
//  LoginSuccessViewController.m
//  MVVMDemo
//
//  Created by 张琳 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginSuccessViewController.h"


@interface LoginSuccessViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (nonatomic, strong) UserModel *user;

@end

@implementation LoginSuccessViewController

-(id)initWithUser:(UserModel *)user
{
    self = [super initWithNibName:@"LoginSuccessViewController" bundle:nil];
    if(self){
        
        self.user = user;
        self.saveSubject = [RACSubject subject];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录成功";
    
    
    //TextField与Model双向绑定
    RAC(self.userNameTF,text) = RACObserve(self.user, userName);
    RAC(self.psdTF,text) = RACObserve(self.user, password);
    RAC(self.user,userName) = self.userNameTF.rac_textSignal;
    RAC(self.user,password) = self.psdTF.rac_textSignal;
    
    
    
    //保存按钮点击事件
    @weakify(self);
    [[self.saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        [self.saveSubject sendNext:self.user]; //把当前的User对象进行发送
        [self.saveSubject sendCompleted];
        [self.navigationController popViewControllerAnimated:YES];//返回到上个页面
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
