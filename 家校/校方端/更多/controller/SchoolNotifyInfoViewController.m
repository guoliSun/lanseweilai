//
//  SchoolNotifyInfoViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/29.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "SchoolNotifyInfoViewController.h"

@interface SchoolNotifyInfoViewController ()
{
    UIScrollView *_scrollView;
    UILabel *_titleLabel; //文章标题
    float _height; //计算文本的高度
    UILabel *_timeLabel;//时间文本框
    UIImageView *_logoImageView; //顶部的图片
    UILabel *_detailLabel;//底部详情
    UIButton *_signUpButton;//报名按钮
    
}
@end

@implementation SchoolNotifyInfoViewController

NSString *titleName4 = @"我校定于XX年九月30日参观北方森林动物园";
NSString *text4= @" iOS是由苹果公司开发的移动操作系统[1]  。苹果公司最早于2007年1月9日的Macworld大会上公布这个系统，最初是设计给iPhone使用的，后来陆续套用到\n\n一、活动时间：xx年XX月XX日(星期六)上午9:00\n二、活动目标：\n   1、让幼儿园学生与大自然接触让幼儿园学生与大自然接触让幼儿园学生与大自然接触让幼儿园学生与大自然接触让幼儿园学生与大自然接触\n   2、让幼儿园学生与大自然接触让幼儿园学生与大自然接触让幼儿园学生与大自然接触让幼儿园学生与大自然接触让幼 \n    3、让幼儿园学生与大自然接触\n三、活动地点：xxx草莓园\n四、参加人员：报名参加人员\n五、活动流程\n    1.全体集合全体集合全体集合全体集合全体集合全体集合全体集合全体集合全体集合全体集合全体集合全体集合";

-(instancetype)init{
    
    if (self = [super init]) {
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
    //[self createSignUpBtn];
    _scrollView.contentSize = CGSizeMake(kScreenWidth - 40, _height);
}

#pragma mark ----创建标题  1.
- (void)createTitleLabel{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth - 40, 0)];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor =  [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1];
    [_scrollView addSubview:_titleLabel];
    CGRect frame = _titleLabel.frame;
    
    //计算文本高度
    GetTextHeightLabel *getTextHeightLabel = [[GetTextHeightLabel alloc]initWithFrame:_titleLabel.frame WithText:titleName4];
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
    _timeLabel.text = @"2016-12-20 59:59";
    [_scrollView addSubview:_timeLabel];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1];
    
    _height += 14;
}

#pragma mark ----创建顶部的图片 3.
- (void)createLogoImageView{
    _height += 10;
    
    _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth - 20, 180 * ScaleHeight)];
    _logoImageView.image = [UIImage imageNamed:@"home_bottom_image"];
    [_scrollView addSubview:_logoImageView];
    
    _height+= 180 * ScaleHeight;
}

#pragma mark ----底部详情 4.
- (void)createDetailLabel{
    _height += 10;
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth - 40, 0)];
    _detailLabel.numberOfLines = 0;
    _detailLabel.textColor = [UIColor colorWithRed:0.49 green:0.498 blue:0.498 alpha:1];
    [_scrollView addSubview:_detailLabel];
    CGRect frame = _detailLabel.frame;
    
    //计算文本高度
    GetTextHeightLabel *getTextHeightLabel = [[GetTextHeightLabel alloc]initWithFrame:_detailLabel.frame WithText1:text4];
    frame.size.height = getTextHeightLabel.frame.size.height;
    _detailLabel.frame = frame;
    NSMutableAttributedString *attString = [getTextHeightLabel backAttString];
    _detailLabel.attributedText = attString;
    
    _height += getTextHeightLabel.frame.size.height + 20;
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
