//
//  SegmentView.h
//  FTMovie
//
//  Created by CORYIL on 15/11/4.
//  Copyright (c) 2015年 徐锐. All rights reserved.
//

#import <UIKit/UIKit.h>

//I.定义block类型

typedef void(^SegmentBlock)(NSInteger index);

@interface SegmentView : UIView

@property (nonatomic,copy)SegmentBlock segmentBlock;

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)array;

- (void)setSegmentBlock:(SegmentBlock)segmentBlock;



@end
