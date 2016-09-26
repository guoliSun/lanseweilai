//
//  SignUpViewController.h
//  HomeSchool
//
//  Created by Ba by on 16/8/17.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
-(instancetype)initWithDic:(NSDictionary *)dic;
@property (nonatomic,strong)NSDictionary *infoDic;
@end
