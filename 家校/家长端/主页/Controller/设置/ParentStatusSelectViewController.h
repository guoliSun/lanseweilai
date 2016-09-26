//
//  ParentStatusSelectViewController.h
//  HomeSchool
//
//  Created by Ba by on 16/8/25.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectBlock)(NSInteger index);
@interface ParentStatusSelectViewController : UIViewController
@property (nonatomic,copy)selectBlock block;
- (void)setBlock:(selectBlock)block;
@end
