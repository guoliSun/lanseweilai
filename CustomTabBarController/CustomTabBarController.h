//
//  CustomTabBarController.h
//  CustomTabBarController
//
//  Created by CORYIL on 15/10/15.
//  Copyright (c) 2015年 CORYIL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolStatusSelectViewController.h"
@interface CustomTabBarController : UITabBarController
{
    UIView *_customTabBar;//自定义tabbar
    
    UIImageView *_selectedImage;//选择图片
}

-(instancetype)initWithSelectImage:(UIImage *)selectImage
                       tabBarImage:(UIImage *)tabBarImage WithIndex:(NSInteger)index;

@end







#pragma mark ----------------CustomTabBarItem------------------------------------
@interface CustomTabBarItem : UIControl

-(id)initWithFrame:(CGRect)frame tabbarItem:(UITabBarItem *)item;
@property (nonatomic,strong)UIImageView *imageView;
@end
