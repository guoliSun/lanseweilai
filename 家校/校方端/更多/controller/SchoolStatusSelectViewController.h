//
//  SchoolStatusSelectViewController.h
//  HomeSchool
//
//  Created by Ba by on 16/8/29.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//
@protocol NavDelegate <NSObject>

- (void)changeNavSelect;

@end
#import <UIKit/UIKit.h>
#import "CustomTabBarController.h"
typedef void(^selectBlock)(NSInteger index);
@interface SchoolStatusSelectViewController : UIViewController
@property (nonatomic,copy)selectBlock block;
- (void)setBlock:(selectBlock)block;
@property(nonatomic,assign)id<NavDelegate> delegate;
@end
