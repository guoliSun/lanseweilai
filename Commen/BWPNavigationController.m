//
//  BWPNavigationController.m
//  BWPNavigationController
//
//  Created by BWP on 16/1/5.
//  Copyright © 2016年 BWP. All rights reserved.
//

#import "BWPNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface BWPNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BWPNavigationController

/*
 将UIGestureRecognizerDelegate放在公共导航类Controller里面遵守，并设置代理为导航类，只需遵守
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // 禁用系统的右滑返回
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // 给NavigationView添加一个拖拽手势 - 此处这个警告没什么影响
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    pan.delegate = self;
    
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion>=7.0) {
        self.navigationBar.barTintColor = [UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:1];
    }else{
        self.navigationBar.tintColor = [UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:1];
    }
    
    //修改navgation title的字体颜色
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationBar.titleTextAttributes = dict;
    
}

+ (void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.titleView.hidden = NO;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        //viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"backImg.png" highImage:@"backImg.png"];
    }
    
    // super 一定要放在最后面调用，不然无法拦截push进来的控制器
    [super pushViewController:viewController animated:animated];
}

/**
 *  返回上级控制器
 */
- (void)back
{
    NSLog(@"返回上一级控制器");
    [self popViewControllerAnimated:YES];
}
/**
 *  返回到跟控制器
 */
- (void)more
{
    NSLog(@"返回跟控制器");
    [self popToRootViewControllerAnimated:YES];
}



#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    return self.childViewControllers.count > 1;
}


@end
