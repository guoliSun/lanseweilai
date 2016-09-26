//
//  ParentStatusSelectViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/25.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "ParentStatusSelectViewController.h"

@interface ParentStatusSelectViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *teacherView;

@end

@implementation ParentStatusSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.title = @"身份选择";
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //self.interactivePopGestureRecognizer.enabled = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //重新定义返回按钮
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240/255.0 blue:240/255.0 alpha:1];
    backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    //重新定义返回按钮
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2:)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    tap1.delegate = self;
    [_teacherView addGestureRecognizer:tap1];
}

- (void)doBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)tapAction2:(UITapGestureRecognizer *)tap{
    
    if (tap.numberOfTapsRequired == 1) {
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -3)] animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            _block(2);//教师端
        });
        
    }
    
}

@end
