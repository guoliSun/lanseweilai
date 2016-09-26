//
//  UpdatePassWordViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/23.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "UpdatePassWordViewController.h"

@interface UpdatePassWordViewController ()<UIGestureRecognizerDelegate,CNPPopupControllerDelegate>
{
    UITextField *_oldTextFile;
    UITextField *_newTextFile1;
    UITextField *_newTextFile2;
}
@property (strong, nonatomic) UIView *oldPwd;
@property (strong, nonatomic) UIView *newsPwd1;
@property (strong, nonatomic) UIView *newsPwd2;
@property (nonatomic, strong) CNPPopupController *popupController;


@end

@implementation UpdatePassWordViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.title = @"修改密码";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
    return self;
}

- (void)doBack:(UIButton *)sender{
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _oldPwd = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 70)];
    [self.view addSubview:_oldPwd];
    _oldPwd.backgroundColor = [UIColor whiteColor];
    _oldTextFile = [[UITextField alloc]initWithFrame:CGRectMake(30, 15, kScreenWidth - 60, 40)];
    _oldTextFile.placeholder = @"请输入原密码";
    [_oldPwd addSubview:_oldTextFile];
   NSString *image1 = @"modifyphone_lock";
    _oldTextFile.leftViewMode=UITextFieldViewModeAlways;
    _oldTextFile.leftView = [self imageView:image1];
    _oldTextFile.layer.borderWidth = 1;
    _oldTextFile.layer.borderColor= [[UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1]CGColor];
    _oldTextFile.layer.masksToBounds = YES;
    _oldTextFile.layer.cornerRadius = 5;

    
    
    
    _newsPwd1 = [[UIView alloc]initWithFrame:CGRectMake(0, _oldPwd.bottom, kScreenWidth, 70)];
    [self.view addSubview:_newsPwd1];
    _newsPwd1.backgroundColor = [UIColor whiteColor];
    _newTextFile1 = [[UITextField alloc]initWithFrame:CGRectMake(30, 15, kScreenWidth - 60, 40)];
    _newTextFile1.placeholder = @"请输入新密码，不少于6位";
    [_newsPwd1 addSubview:_newTextFile1];
    NSString *image2 = @"modifyphone_locked";
    _newTextFile1.leftViewMode=UITextFieldViewModeAlways;
    _newTextFile1.leftView = [self imageView:image2];
    _newTextFile1.layer.borderWidth = 1;
    _newTextFile1.layer.borderColor= [[UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1]CGColor];
    _newTextFile1.layer.masksToBounds = YES;
    _newTextFile1.layer.cornerRadius = 5;

    
    
    
    _newsPwd2 = [[UIView alloc]initWithFrame:CGRectMake(0, _newsPwd1.bottom, kScreenWidth, 70)];
    [self.view addSubview:_newsPwd2];
    _newsPwd2.backgroundColor = [UIColor whiteColor];
    _newTextFile2 = [[UITextField alloc]initWithFrame:CGRectMake(30, 15, kScreenWidth - 60, 40)];
    _newTextFile2.placeholder = @"再次输入新密码";
    [_newsPwd2 addSubview:_newTextFile2];
   
    _newTextFile2.leftViewMode=UITextFieldViewModeAlways;
    _newTextFile2.leftView = [self imageView:image2];
    _newTextFile2.layer.borderWidth = 1;
    _newTextFile2.layer.borderColor= [[UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1]CGColor];
    _newTextFile2.layer.masksToBounds = YES;
    _newTextFile2.layer.cornerRadius = 5;
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(40, _newsPwd2.bottom + 30, kScreenWidth - 80, 40)];
    [button setBackgroundColor:[UIColor colorWithRed:0 green:181 / 255.0 blue:242 / 255.0 alpha:1]];
    [button setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(updateAct:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2:)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    tap1.delegate = self;
    [_oldPwd addGestureRecognizer:tap1];
    [_newsPwd1 addGestureRecognizer:tap1];
    [_newsPwd2 addGestureRecognizer:tap1];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)updateAct:(UIButton *)sender{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *pwd = [accountDefaults objectForKey:@"loginPwd"];
    if (![pwd isEqualToString:_oldTextFile.text]) {
         [self.view endEditing:YES];
        [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:@"旧密码输入错误"];
        return;
    };
    if (![_newTextFile1.text isEqualToString:_newTextFile2.text]) {
         [self.view endEditing:YES];
        [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:@"两次输入的新密码不一致"];
        return;
        
    }
    if([pwd isEqualToString:_oldTextFile.text] && [_newTextFile1.text isEqualToString:_newTextFile2.text]){
        NSDictionary *dic =  [accountDefaults objectForKey:@"userInfo"];
        NSString *url = [NSString stringWithFormat:UpdatePwd,[dic objectForKey:@"userId"],_newTextFile1.text];
        [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
            if ([[response objectForKey:@"code"] integerValue] == 100) {
                [accountDefaults setObject:_newTextFile1.text forKey:@"loginPwd"];
                 [self.view endEditing:YES];
                [self showPopupWithStyle:CNPPopupStyleCentered WithSuccess:[response objectForKey:@"msg"]];
            }else{
                [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:[response objectForKey:@"msg"]];
            }
            
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)tapAction2:(UITapGestureRecognizer *)tap{
    
    if (tap.numberOfTapsRequired == 1) {
        [self.view endEditing:YES];
    }
}

- (UIView *)imageView:(NSString *)image{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    imageView.image = [UIImage imageNamed:image];
    [view addSubview:imageView];
    
    return view;
}


#pragma mark  ----- 自定义提示框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle WithNumber:(NSString *)info {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"密码修改提示" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
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
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"密码修改提示" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:info attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [self.popupController dismissPopupControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
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
