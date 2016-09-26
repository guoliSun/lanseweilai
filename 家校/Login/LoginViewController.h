//
//  LoginViewController.h
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//
typedef void(^loginBlock)(NSInteger index);
typedef void(^InfoBlock)(NSDictionary *dic);
#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (nonatomic ,copy)loginBlock block;
@property (nonatomic, copy)InfoBlock infoBlock;

- (void)setBlock:(loginBlock)block;
- (void)setInfoBlock:(InfoBlock)infoBlock;
@end
