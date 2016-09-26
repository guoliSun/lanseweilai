//
//  UpdatePhoneGetVerifyViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/26.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "UpdatePhoneGetVerifyViewController.h"
#import "SelfCenterViewController.h"
@interface UpdatePhoneGetVerifyViewController ()<CNPPopupControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *PhoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *verifyTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (nonatomic, strong) CNPPopupController *popupController;
@end

@implementation UpdatePhoneGetVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改联系电话";
    backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    //重新定义返回按钮
    
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    
    _PhoneTextFiled.leftViewMode=UITextFieldViewModeAlways;
    _PhoneTextFiled.leftView = [self createViewWithImageName:@"login_phone"];
    
    _verifyTextFiled.leftViewMode=UITextFieldViewModeAlways;
    _verifyTextFiled.leftView = [self createViewWithImageName:@"login_valcode"];
    
    
    _updateBtn.layer.masksToBounds = YES;
    _updateBtn.layer.cornerRadius = 5;
    
    _verifyBtn.layer.masksToBounds = YES;
    _updateBtn.layer.cornerRadius = 5;


    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)doBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)createViewWithImageName:(NSString *)imageName{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    imageView.image = [UIImage imageNamed:imageName];
    [view addSubview:imageView];
    return view;
    
}
- (IBAction)updateBtn:(UIButton *)sender {
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userInfo = [accountDefaults objectForKey:@"userInfo"];
    NSString *url = [NSString stringWithFormat:ChangePhoneUrl,[userInfo objectForKey:@"userId"],_PhoneTextFiled.text];
    [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
        [self.view endEditing:YES];
        if ([[response objectForKey:@"code"] integerValue] == 100) {
            [accountDefaults setObject:_PhoneTextFiled.text forKey:@"mobile"];
            [self showPopupWithStyle:CNPPopupStyleCentered WithSuccess:[response objectForKey:@"msg"]];
        }else{
            [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:[response objectForKey:@"msg"]];
        }
        
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle WithSuccess:(NSString *)info {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"修改提示" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:info attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [self.popupController dismissPopupControllerAnimated:YES];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -4)] animated:YES];
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
@end
