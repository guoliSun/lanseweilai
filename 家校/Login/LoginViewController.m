//
//  LoginViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "LoginViewController.h"
#import "StatusSelectViewController.h"
#import "CNPPopupController.h"


@interface LoginViewController ()<CNPPopupControllerDelegate>
{
    UITextField *_username;
    UITextField *_password;
    UIButton *_loginBtn;
    UIImageView *_leftImageView;
    UIButton *_wangjiBtn;
    float _height;
}
@property (nonatomic, strong) CNPPopupController *popupController;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _height = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    
    
    
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    self.navigationController.navigationBarHidden = YES;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [UIImage imageNamed:@"loginbg"];
    [self.view addSubview:imageView];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(120 * ScaleWidth , 70,  kScreenWidth - 240 * ScaleWidth, 150 * ScaleWidth)];
    logoImageView.image = [UIImage imageNamed:@"login_headerlogo"];
    [imageView addSubview:logoImageView];
    
    //用户名
    _username = [[UITextField alloc]initWithFrame:CGRectMake(30, logoImageView.bottom + 30 + 65 * ScaleHeight, kScreenWidth - 60, 40 * ScaleHeight)];
    _username.layer.borderWidth = 1.0f;
    _username.backgroundColor = [UIColor whiteColor];
    _username.layer.cornerRadius = 5;
    _username.layer.borderColor = [UIColor colorWithRed:0 green:123/255.0 blue:187/255.0 alpha:1].CGColor;
    _username.placeholder = @"输入手机号";
    [imageView addSubview:_username];
    _username.leftViewMode=UITextFieldViewModeAlways;
    _username.font = [UIFont systemFontOfSize:16];
    _username.textColor = [UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:127 / 255.0 alpha:1];
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50 , 40 * ScaleHeight)];
    UIImageView *userimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30  * ScaleHeight, 30 * ScaleHeight)];
    [userView addSubview:userimageView];
    userimageView.image = [UIImage imageNamed:@"login_phone"];
    _username.leftView=userView;
    //密码
    _password = [[UITextField alloc]initWithFrame:CGRectMake(30, _username.bottom + 30 * ScaleHeight, kScreenWidth - 60, 40 * ScaleHeight)];
    _password.font = [UIFont systemFontOfSize:16];
    _password.textColor = [UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:127 / 255.0 alpha:1];
    
    _password.placeholder = @"输入密码";
    _password.layer.borderWidth = 1.0f;
    _password.layer.cornerRadius = 5;
    _password.layer.borderColor = [UIColor colorWithRed:0 green:123/255.0 blue:187/255.0 alpha:1].CGColor;
    UIView *passView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50 , 40 * ScaleHeight)];
    UIImageView *passimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30  * ScaleHeight, 30 * ScaleHeight)];
    [passView addSubview:passimageView];
    passimageView.image = [UIImage imageNamed:@"login_lock"];
    _password.leftViewMode=UITextFieldViewModeAlways;
    _password.leftView=passView;
    _password.backgroundColor = [UIColor whiteColor];
    [imageView addSubview:_password];
    
    //登录
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, _password.bottom + 60 * ScaleHeight, kScreenWidth - 60, 40 )];
    [_loginBtn setBackgroundColor:[UIColor colorWithRed:0 green:0.486 blue:0.721 alpha:1]];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.textColor = [UIColor whiteColor];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 5;
    [_loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:_loginBtn];
    imageView.userInteractionEnabled = YES;
    
     _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_loginBtn.left - 10, _loginBtn.bottom, 40 , 40)];
    _leftImageView.image = [UIImage imageNamed:@"login_forgetsecret"];
    [imageView addSubview:_leftImageView];
    
    _wangjiBtn = [[UIButton alloc]initWithFrame:CGRectMake(_leftImageView.right - 10, _leftImageView.top + 10, 70, 20)];
    [_wangjiBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_wangjiBtn setTitleColor:[UIColor colorWithRed:51 / 255.0 green:134 / 255.0 blue:182 / 255.0 alpha:1] forState:UIControlStateNormal];
    _wangjiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:_wangjiBtn];
    
    _username.text = @"15092216493";
    _password.text = @"123456";
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度

    _username.transform = CGAffineTransformIdentity;
    _password.transform = CGAffineTransformIdentity;
    _loginBtn.transform = CGAffineTransformIdentity;
    _leftImageView.transform = CGAffineTransformIdentity;
    _wangjiBtn.transform = CGAffineTransformIdentity;
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float height = keyboardRect.size.height;
    float changeHeight = height - (kScreenHeight - _wangjiBtn.bottom ) + 10;
    
    _username.transform = CGAffineTransformTranslate(_username.transform, 0, -changeHeight);
    _password.transform = CGAffineTransformTranslate(_password.transform, 0, -changeHeight);
    _loginBtn.transform = CGAffineTransformTranslate(_loginBtn.transform, 0, -changeHeight);
    _leftImageView.transform = CGAffineTransformTranslate(_leftImageView.transform, 0, -changeHeight);
    _wangjiBtn.transform = CGAffineTransformTranslate(_wangjiBtn.transform, 0, -changeHeight);

    
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    _username.transform = CGAffineTransformIdentity;
    _password.transform = CGAffineTransformIdentity;
    _loginBtn.transform = CGAffineTransformIdentity;
    _leftImageView.transform = CGAffineTransformIdentity;
    _wangjiBtn.transform = CGAffineTransformIdentity;
}


#pragma mark ----点击登录调用的方法

- (void)loginBtn:(UIButton *)sender {
    if (_username.text.length == 0 || _password.text.length == 0) {
        [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:@"手机号或密码不能为空"];
        _username.text = nil;
        _password.text = nil;
        return;
    }
    NSString *url = [NSString stringWithFormat:LoginPort,_username.text,_password.text];
    [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
        NSDictionary *dic = response;
        NSString *code = [dic objectForKey:@"code"];
        if ([code integerValue] == 103) {
                StatusSelectViewController *statusVC = [[StatusSelectViewController alloc]init];
                [statusVC setBlock:^(NSInteger index) {
                        _block(index);
                }];
            [self.navigationController pushViewController:statusVC animated:YES];
        }else if([[dic objectForKey:@"code"] integerValue] == 101){
            [self.view endEditing:YES];
            [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:[dic objectForKey:@"msg"]];
        }
        else{
            NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
            [accountDefaults setObject:_password.text forKey:@"loginPwd"];
            
            NSDictionary *infoDic = [dic objectForKey:@"result"];
            [accountDefaults setObject:[infoDic objectForKey:@"mobile"] forKey:@"mobile"];
            NSDictionary *studentInfoDic = @{
                                             @"studentId":[infoDic objectForKey:@"studentId"],
                                             @"studentName":[infoDic objectForKey:@"studentName"],
                                             @"studentSchool":[infoDic objectForKey:@"studentSchool"],
                                             @"studentClass":[infoDic objectForKey:@"studentClass"],
                                             @"schoolId":[infoDic objectForKey:@"schoolId"],
                                             @"relation":[infoDic objectForKey:@"relation"]};
            
            [accountDefaults setObject:studentInfoDic forKey:@"studentInfo"];
            NSDictionary *userInfoDic = @{
                                          @"loginName":[infoDic objectForKey:@"loginName"],
                                          @"parentId":[infoDic objectForKey:@"parentId"],
                                          @"userName":[infoDic objectForKey:@"userName"],
                                          @"userId":[infoDic objectForKey:@"userId"],
                                          @"icon":[infoDic objectForKey:@"icon"]};
             [accountDefaults setObject:userInfoDic forKey:@"userInfo"];
            
            _infoBlock(dic);
        }
    }];
    
}

#pragma mark  ----- 自定义提示框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle WithNumber:(NSString *)info {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"登录提示" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:info attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [self.popupController dismissPopupControllerAnimated:YES];
        _username.text = nil;
        _password.text = nil;
    };
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = title;
    
    UILabel *lineOneLabel = [[UILabel alloc] init];
    lineOneLabel.numberOfLines = 0;
    lineOneLabel.attributedText = lineOne;
    self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, button]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    [self.popupController presentPopupControllerAnimated:YES];
}


#pragma mark ----点击忘记密码调用的方法

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
