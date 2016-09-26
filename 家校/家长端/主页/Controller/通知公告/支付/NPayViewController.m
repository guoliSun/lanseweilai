//
//  NPayViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/17.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "NPayViewController.h"
#import "GetTextHeightLabel.h"
@interface NPayViewController ()
{
    UIScrollView *_scrollView;
    UILabel *_titleLabel; //文章标题
    float _height; //计算文本的高度
    UILabel *_timeLabel;//时间文本框
    UIImageView *_logoImageView; //顶部的图片
    UILabel *_detailLabel;//底部详情
    UIButton *_selectPayButton1;//支付选项1
    UIButton *_selectPayButton2;//支付选项2
    UIButton *_payButton;//支付按钮
    

}
@end

@implementation NPayViewController




-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        _infoDic = dic;
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"信息详情";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
    return self;
}

#pragma mark ----返回按钮
- (void)doBack:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _height = 25;
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, kScreenHeight )];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    [self createTitleLabel];
    [self createTimeLable];
    [self createLogoImageView];
    [self createDetailLabel];
    [self createSelectPayButton];
    [self createSignUpBtn];
    _scrollView.contentSize = CGSizeMake(kScreenWidth - 40, _height);
}

#pragma mark ----创建标题  1.
- (void)createTitleLabel{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth - 40, 0)];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1];
    [_scrollView addSubview:_titleLabel];
    CGRect frame = _titleLabel.frame;
    
    //计算文本高度
    GetTextHeightLabel *getTextHeightLabel = [[GetTextHeightLabel alloc]initWithFrame:_titleLabel.frame WithText:[_infoDic objectForKey:@"title"]];
    frame.size.height = getTextHeightLabel.frame.size.height;
    _titleLabel.frame = frame;
    NSMutableAttributedString *attString = [getTextHeightLabel backAttString];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16 weight:16] range:NSMakeRange(0, attString.length)];
    _titleLabel.attributedText = attString;
    
    _height += getTextHeightLabel.frame.size.height;
    
}


#pragma mark ----获取当前的时间 2.
- (void)createTimeLable{
    //距离上一部分控件的高度
    _height += 10;
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _height,kScreenWidth - 40, 14)];
    _timeLabel.text = [_infoDic objectForKey:@"createDate"];
    [_scrollView addSubview:_timeLabel];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1];
    
    _height += 14;
}

#pragma mark ----创建顶部的图片 3.
- (void)createLogoImageView{
    _height += 10;
    
    _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth - 40, 180 * ScaleHeight)];
    _logoImageView.image = [UIImage imageNamed:@"home_bottom_image"];
    [_scrollView addSubview:_logoImageView];
    
    _height+= 180 * ScaleHeight;
}

#pragma mark ----支付选项
- (void)createSelectPayButton{
    _height += 40;
    _selectPayButton1 = [[UIButton alloc]initWithFrame:CGRectMake(20, _height, 70, 20)];
    UIButton *selectBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, _height, 20, 20)];
    [selectBtn1 setBackgroundImage:[UIImage imageNamed:@"statistics_leave.png"] forState:UIControlStateNormal];
    [_scrollView addSubview:selectBtn1];
    [_selectPayButton1 setTitle:@"选项一" forState:UIControlStateNormal];
    [_selectPayButton1 setTitleColor:[UIColor colorWithRed:0.5686 green:0.5686 blue:0.5686 alpha:1] forState:UIControlStateNormal];
    [_scrollView addSubview:_selectPayButton1];
    
    _height += 25 + 20;
    
    UIButton *selectBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, _height, 20, 20)];
    [selectBtn2 setBackgroundImage:[UIImage imageNamed:@"statistics_leave.png"] forState:UIControlStateNormal];
    [_scrollView addSubview:selectBtn2];
    _selectPayButton2 = [[UIButton alloc]initWithFrame:CGRectMake(20, _height, 70, 20)];
    [_selectPayButton2 setTitle:@"选项二" forState:UIControlStateNormal];
    [_selectPayButton2 setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forState:UIControlStateNormal];
    [_scrollView addSubview:_selectPayButton2];
    
    _height += 20;
    
}

#pragma mark ----底部详情 4.
- (void)createDetailLabel{
    _height += 20;
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth - 40, 0)];
    _detailLabel.numberOfLines = 0;
    _detailLabel.textColor = [UIColor colorWithRed:0.49 green:0.498 blue:0.498 alpha:1];
    [_scrollView addSubview:_detailLabel];
    CGRect frame = _detailLabel.frame;
    
    //计算文本高度
    GetTextHeightLabel *getTextHeightLabel = [[GetTextHeightLabel alloc]initWithFrame:_detailLabel.frame WithText1:[_infoDic objectForKey:@"content"]];
    frame.size.height = getTextHeightLabel.frame.size.height;
    _detailLabel.frame = frame;
    NSMutableAttributedString *attString = [getTextHeightLabel backAttString];
    _detailLabel.attributedText = attString;
    
    _height += getTextHeightLabel.frame.size.height;
}

#pragma mark ----点击支付按钮 6.
- (void)createSignUpBtn{
    _height += 40;
    
    _payButton = [[UIButton alloc]initWithFrame:CGRectMake(20, _height, kScreenWidth - 80, 45)];
    [_payButton setTitle:@"支付" forState:UIControlStateNormal];
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payButton setBackgroundColor: [UIColor colorWithRed:0.21 green:0.63 blue:0.95 alpha:1]];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:24];
    _payButton.layer.cornerRadius = 5;
#warning -----修改颜色
    [_payButton setBackgroundColor:[UIColor colorWithRed:0.21 green:0.63 blue:0.95 alpha:1]];
    [_payButton addTarget:self action:@selector(signUpBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_payButton];
    
    _height += 45 + 30 ;
    
}
#pragma mark----点击报名按钮
- (void)signUpBtn:(UIButton *)sender{
   
#warning ----跳转支付页面
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
