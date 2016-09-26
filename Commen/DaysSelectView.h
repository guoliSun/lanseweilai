//
//  DaysSelectView.h
//  DaysSelectDemo
//
//  Created by Ba by on 16/9/5.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^dayBlock)(NSString *dayString);
@interface DaysSelectView : UIView
@property (nonatomic,strong)dayBlock block;
-(void)setBlock:(dayBlock)block;
@end
