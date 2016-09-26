//
//  StatusSelectViewController.h
//  HomeSchool
//
//  Created by Ba by on 16/8/24.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//
typedef void(^selectBlock)(NSInteger index);
#import <UIKit/UIKit.h>

@interface StatusSelectViewController : UIViewController
@property (nonatomic,copy)selectBlock block;
- (void)setBlock:(selectBlock)block;
@end
