//
//  AskInfoViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/29.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "AskInfoViewController.h"

@interface AskInfoViewController ()
{
    NSMutableArray *_dataListArr;
    UIScrollView *_scrollView;
    UIImageView *_userImageView;//用户头像
    UITextView *_textView;
    UIButton *_agreeBtn;
    UIButton *_notAgreeBtn;
    float _height;
    UIImageView *_imageView;//审核结果
}

@end

@implementation AskInfoViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"请假申请详情";
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
    [super viewDidLoad];
    _height = 0;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_scrollView];
    
    [self createUserInfo];
    [self createImageView];
    [self createBtn];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _height);
   
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ----创建头像下面的相关个人信息
- (void)createUserInfo{
    NSArray *nameArr = @[@"学生姓名:",@"申请人:",@"申请时间:",@"请假时间:",@"请假原因:"];
    
    NSArray *infoArr = @[@"王小明",@"王大明",@"班主任",@"11111111111"];
    for (int i = 0; i < 5; i++) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,  50 * i, kScreenHeight, 50)];
        bgView.backgroundColor = [UIColor whiteColor];
        
        if(i == 1){
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, 65, 20)];
            nameLabel.text = nameArr[i];
            nameLabel.font = [UIFont systemFontOfSize:16];
            nameLabel.textColor = [UIColor lightGrayColor];
            [bgView addSubview:nameLabel];
        }else{
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, 70, 20)];
            nameLabel.text = nameArr[i];
            nameLabel.font = [UIFont systemFontOfSize:16];
            nameLabel.textColor = [UIColor lightGrayColor];
            [bgView addSubview:nameLabel];
        }
        if (i < 4) {
            if (i == 1) {
                UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, 120, 20)];
                infoLabel.font = [UIFont systemFontOfSize:16];
                infoLabel.text = infoArr[i];
                infoLabel.textColor = [UIColor lightGrayColor];
                [bgView addSubview:infoLabel];
            }else{
                UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 15, 120, 20)];
                infoLabel.font = [UIFont systemFontOfSize:16];
                infoLabel.text = infoArr[i];
                infoLabel.textColor = [UIColor lightGrayColor];
                [bgView addSubview:infoLabel];
            }
            
        }
        
        if (i < 4) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kScreenWidth, 1)];
            view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
            [bgView addSubview:view];
        }
               
        if (i == 4) {
            _textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 50, kScreenWidth - 40, 130)];
            _textView.backgroundColor = [UIColor colorWithRed:241 / 255.0 green:251 / 255.0 blue:255 / 255.0 alpha:1];
            [bgView addSubview:_textView];
            _textView.text = @"xxxx";
            _textView.font = [UIFont systemFontOfSize:16];
            _textView.textColor = [UIColor lightGrayColor];
            CGRect frame = bgView.frame;
            frame.size.height = 200;
            bgView.frame = frame;
        }
        [_scrollView addSubview:bgView];
        if (i < 4) {
            _height += 50;
        }else{
            _height += 180;
        }
    }
    
}
#pragma mark -----审核结果图片
- (void)createImageView{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_textView.right - 80, _height - 40, 60, 60)];
    _imageView.image = [UIImage imageNamed:@"permitted"];
    _imageView.hidden = YES;
    [_scrollView addSubview:_imageView];
}
#pragma mark -----同意不同意按钮
- (void)createBtn{
    _agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, _height + 30, kScreenWidth / 2 - 35, 30)];
    [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [_scrollView addSubview:_agreeBtn];
    _agreeBtn.layer.masksToBounds = YES;
    _agreeBtn.layer.cornerRadius = 5;
    [_agreeBtn setBackgroundColor:[UIColor colorWithRed:0 green:181 / 255.0 blue:243 / 255.0 alpha:1]];
    [_agreeBtn setTintColor:[UIColor whiteColor]];
    _agreeBtn.tag = 1000;
    
    _notAgreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth / 2 + 15, _height + 30, kScreenWidth / 2 - 35, 30)];
    [_notAgreeBtn setTitle:@"不同意" forState:UIControlStateNormal];
    _notAgreeBtn.tag = 1001;
    [_scrollView addSubview:_notAgreeBtn];
    _notAgreeBtn.layer.masksToBounds = YES;
    _notAgreeBtn.layer.cornerRadius = 5;
    [_notAgreeBtn setBackgroundColor:[UIColor colorWithRed:0 green:181 / 255.0 blue:243 / 255.0 alpha:1]];
    [_notAgreeBtn setTintColor:[UIColor whiteColor]];
    
    _height += 30 + 30;
    
    [_agreeBtn addTarget:self action:@selector(checkBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_notAgreeBtn addTarget:self action:@selector(checkBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)checkBtn:(UIButton *)sender{
    if (sender.tag == 1000) {
        _agreeBtn.hidden = YES;
        _notAgreeBtn.hidden = YES;
        _imageView.hidden = NO;
        _imageView.image = [UIImage imageNamed:@"permitted"];
        _scrollView.contentSize = CGSizeMake(kScreenWidth, _height - 30);
    }
    if (sender.tag == 1001) {
        _agreeBtn.hidden = YES;
        _notAgreeBtn.hidden = YES;
        _imageView.hidden = NO;
        _imageView.image = [UIImage imageNamed:@"nopermit"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
