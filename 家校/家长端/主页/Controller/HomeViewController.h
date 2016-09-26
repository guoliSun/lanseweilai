//
//  HomeViewController.h
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectBlock)(NSInteger index);
@interface HomeViewController : UIViewController
@property (nonatomic ,copy)selectBlock block;
-(void)setBlock:(selectBlock)block;

@end


@interface BannerView : UIView
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic ,assign)NSInteger index;


@end
