//
//  ConnectWithUsViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/29.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "ConnectWithUsViewController.h"

@interface ConnectWithUsViewController ()
{
    UIScrollView *_scrollView;
    float _height;
}
@end

@implementation ConnectWithUsViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"关于我们";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}

- (void)doBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    _height = 0;
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    [self createTitle];
    [self createImageView];
    [self createInfoLabel];
}

- (void)createTitle{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 20)];
    label.text = @"蓝色未来";
    label.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottom + 5, kScreenWidth, 14)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"BLUEFUTURE";
    label1.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:label1];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, label1.bottom, kScreenWidth, 14)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"KINDERGARTEN";
    label2.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:label2];
}
- (void)createImageView{
    _height = 90;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, _height, kScreenWidth - 40, 140 * ScaleWidth)];
    imageView.image = [UIImage imageNamed:@"guanyuwomen"];
    [_scrollView addSubview:imageView];
    _height += 140 *ScaleWidth;
}
- (void)createInfoLabel{
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _height + 20, kScreenWidth - 40, 20)];
    infoLabel.numberOfLines = 0;
    
    NSString *text2 = @"测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本\n\n测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本";
    //计算文本高度
    GetTextHeightLabel *getTextHeightLabel = [[GetTextHeightLabel alloc]initWithFrame:infoLabel.frame WithText1:text2];
    CGRect frame = infoLabel.frame;
    frame.size.height = getTextHeightLabel.frame.size.height;
    infoLabel.frame = frame;
    NSMutableAttributedString *attString = [getTextHeightLabel backAttString];
    infoLabel.attributedText = attString;
   infoLabel.textColor = [UIColor colorWithRed:0.49 green:0.498 blue:0.498 alpha:1];
    _height += getTextHeightLabel.frame.size.height +20;
    [_scrollView addSubview:infoLabel];
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
