//
//  UpdateOldPhoneViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/26.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "UpdateOldPhoneViewController.h"
#import "UpdatePhoneGetVerifyViewController.h"
@interface UpdateOldPhoneViewController ()<CNPPopupControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic, strong) CNPPopupController *popupController;
@end

@implementation UpdateOldPhoneViewController


- (void)doBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改联系电话";
    backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    //重新定义返回按钮
    
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _phoneTextFiled.leftViewMode=UITextFieldViewModeAlways;
    _phoneTextFiled.leftView = [self createView];
    
    _nextBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = 5;
}

- (UIView *)createView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    imageView.image = [UIImage imageNamed:@"modifyphone_lock"];
    [view addSubview:imageView];
    return view;
    
}
- (IBAction)nextAct:(UIButton *)sender {
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *pwd = [accountDefaults objectForKey:@"loginPwd"];
    if ([_phoneTextFiled.text isEqualToString:pwd]) {
        UpdatePhoneGetVerifyViewController *upgvVC = [[UpdatePhoneGetVerifyViewController alloc]initWithNibName:@"UpdatePhoneGetVerifyViewController" bundle:nil];
        [self.navigationController pushViewController:upgvVC animated:YES];
    }else{
        [self.view endEditing:YES];
        [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:@"登录密码错误"];
    }
    
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
