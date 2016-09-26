//
//  DeanMailViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/29.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "DeanMailViewController.h"

@interface DeanMailViewController ()<CNPPopupControllerDelegate,UITextViewDelegate>
{
    UILabel *_label;
}
@property (strong, nonatomic)  UITextView *textView;
@property (strong, nonatomic)  UIButton *button;
@property (nonatomic, strong) CNPPopupController *popupController;

@end

@implementation DeanMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    self.title = @"园长信箱";
    backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    //重新定义返回按钮
    
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(30, 64 + 20, kScreenWidth - 60, 250)];
    _textView.contentInset = UIEdgeInsetsMake(-65.f, 0.f, -8.f, 0.f);
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [[UIColor colorWithRed:181 / 255.0 green:181 / 255.0 blue:181 / 255.0 alpha:1]CGColor];
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
    _label.text = @"请简述您对我们的问题和意见";
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1];
    [_textView addSubview:_label];
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake(30, _textView.bottom + 40, kScreenWidth - 60, 40)];
    [_button setTitle:@"提交" forState:UIControlStateNormal];
    [_button setTintColor:[UIColor whiteColor]];
    [_button addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [_button setBackgroundColor:[UIColor colorWithRed:0 green:180 / 255.0 blue:240 / 255.0 alpha:1]];
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 5;
    [self.view addSubview:_button];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _button.bottom + 5, kScreenWidth, kScreenHeight - _button.bottom - 5)];
    imageView.image = [UIImage imageNamed:@"yuanzhangxinxiang"];
    [self.view addSubview:imageView];
    
}
- (void)btnAct:(UIButton *)sender{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *studentInfo = [accountDefaults objectForKey:@"studentInfo"];
    NSString *url = [NSString stringWithFormat:SchoolMailUrl,[studentInfo objectForKey:@"studentId"],_textView.text];
    NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [AFNetManager postRequestWithURL:encodingString withParameters:nil success:^(id response) {
        [self.view endEditing:YES];
        if ([[response objectForKey:@"code"] integerValue] == 100) {
            [self showPopupWithStyle:CNPPopupStyleCentered WithSuccess:[response objectForKey:@"msg"]];
        }else{
            [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:[response objectForKey:@"msg"]];
        }

        
    }];
}

- (void)doBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        _label.hidden = NO;
    }else{
        _label.hidden = YES;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
