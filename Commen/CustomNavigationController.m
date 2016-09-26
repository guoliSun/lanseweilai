//
//  CustomNavigationController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end
 
@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    

    // Do any additional setup after loading the view.
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
