//
//  InHomeSchoolViewController.h
//  HomeSchool
//
//  Created by Ba by on 16/8/26.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//
typedef void(^changeBlock)(void);
#import <UIKit/UIKit.h>

@interface InHomeSchoolViewController : UIViewController
@property (nonatomic,copy)changeBlock block;
- (void)setBlock:(changeBlock)block;
@end
