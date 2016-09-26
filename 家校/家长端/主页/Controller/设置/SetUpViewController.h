//
//  SetUpViewController.h
//  HomeSchool
//
//  Created by Ba by on 16/8/18.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//
typedef void(^selectBlock)(NSInteger index);
#import <UIKit/UIKit.h>

@interface SetUpViewController : UIViewController
@property (nonatomic ,copy)selectBlock block;
-(void)setBlock:(selectBlock)block;
@end
