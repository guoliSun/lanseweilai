//
//  SchoolAddressListInfoViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/25.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "SchoolAddressListInfoViewController.h"

@interface SchoolAddressListInfoViewController ()
{
    NSMutableArray *_dataListArr;
    UIScrollView *_scrollView;
    UIImageView *_userImageView;//用户头像
    UITextView *_textView;
    NSInteger _height;
}
@end

@implementation SchoolAddressListInfoViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"详细";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

#pragma mark ----返回按钮
- (void)doBack:(UIButton *)sender{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 620);
    [self createTopImageView];
    [self createUserInfo];
    [self createNewsButton];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark  -----顶部的头像
- (void)createTopImageView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, 90)];
    bgView.backgroundColor = [UIColor whiteColor];
    _userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 30, 15, 60, 60)];
    _userImageView.layer.masksToBounds = YES;
    _userImageView.layer.cornerRadius = 30;
    _userImageView.image = [UIImage imageNamed:@"touxiang.png"];
    [bgView addSubview:_userImageView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 89, kScreenWidth, 1)];
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [bgView addSubview:view];
    [_scrollView addSubview:bgView];
    _height = 90;
}
#pragma mark ----创建头像下面的相关个人信息
- (void)createUserInfo{
    NSArray *nameArr = @[@"学生姓名",@"家长姓名:",@"亲戚关系:",@"电话:",@"班级:",@"备注:"];
    NSArray *imageArr = @[@"info_name",@"family_name",@"family_relation",@"info_phone",@"info_name",@"info_remark"];
    NSArray *infoArr = @[@"王小明",@"王大明",@"班主任",@"11111111111",@"幼儿园大班一班"];
    for (int i = 0; i < 6; i++) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 90 + 50 * i, kScreenHeight, 50)];
        bgView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 9, 32, 32)];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [bgView addSubview:imageView];
        
        if(i < 3){
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, 70, 20)];
            nameLabel.text = nameArr[i];
            nameLabel.font = [UIFont systemFontOfSize:16];
            nameLabel.textColor = [UIColor lightGrayColor];
            [bgView addSubview:nameLabel];
        }else{
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, 38, 20)];
            nameLabel.text = nameArr[i];
            nameLabel.font = [UIFont systemFontOfSize:16];
            nameLabel.textColor = [UIColor lightGrayColor];
            [bgView addSubview:nameLabel];
        }
        
        
        if (i < 5) {
            if (i < 3) {
                UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(95 + 32, 15, 120, 20)];
                infoLabel.font = [UIFont systemFontOfSize:16];
                infoLabel.text = infoArr[i];
                infoLabel.textColor = [UIColor lightGrayColor];
                [bgView addSubview:infoLabel];
            }else{
                UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 15, 120, 20)];
                infoLabel.font = [UIFont systemFontOfSize:16];
                infoLabel.text = infoArr[i];
                infoLabel.textColor = [UIColor lightGrayColor];
                [bgView addSubview:infoLabel];
            }
            
        }
        
        if (i < 5) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kScreenWidth, 1)];
            view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
            [bgView addSubview:view];
        }
        if (i == 3) {
            UIButton *callPhoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 20 - 32, 9, 32, 32)];
            [callPhoneBtn setBackgroundImage:[UIImage imageNamed:@"info_callphone"] forState:UIControlStateNormal];
            [callPhoneBtn addTarget:self action:@selector(callPhoneAct:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:callPhoneBtn];
        }
        
        if (i == 5) {
            UIButton *preserveBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 20 - 35, 13, 35, 24)];
            preserveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            preserveBtn.layer.masksToBounds = YES;
            preserveBtn.layer.cornerRadius = 5;
            [preserveBtn setBackgroundImage:[UIImage imageNamed:@"xiaoxikuang"] forState:UIControlStateNormal];
            [preserveBtn setTitle:@"保存" forState:UIControlStateNormal];
            [bgView addSubview:preserveBtn];
            
            
            UIImageView *imageViewBg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, kScreenWidth - 40, 130)];
            imageViewBg.image = [UIImage imageNamed:@"beizhukuang"];
            [bgView addSubview:imageViewBg];
            imageViewBg.userInteractionEnabled = YES;
            _textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth - 50, 120)];
            
            [imageViewBg addSubview:_textView];
            
            CGRect frame = bgView.frame;
            frame.size.height = 200;
            bgView.frame = frame;
            
            
            
        }
        _height += 300;
        [_scrollView addSubview:bgView];
    }
}
#pragma mark -----发消息
-(void)createNewsButton{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 550, kScreenWidth, 60)];
    UIButton *newsButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, kScreenWidth - 40, 40)];
    [view addSubview:newsButton];
    [newsButton setTitle:@"发消息" forState:UIControlStateNormal];
    [newsButton setBackgroundImage:[UIImage imageNamed:@"xiaoxikuang"] forState:UIControlStateNormal];
    [_scrollView addSubview:view];
}

#pragma mark -----拨打电话
- (void)callPhoneAct:(UIButton *)sender{
    NSLog(@"拨打电话");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
