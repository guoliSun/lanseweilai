//
//  SegmentView.m
//  FTMovie
//
//  Created by CORYIL on 15/11/4.
//  Copyright (c) 2015年 徐锐. All rights reserved.
//

#import "SegmentView.h"

@interface SegmentView ()
{
    NSInteger _itemsCount;
    
    NSArray *_titles;
    
    float _itemWidth;
    
    UIImageView *_selectImg;

}

@end

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)array{

    if (self = [super initWithFrame:frame]) {
        
        _itemsCount = array.count;
        
        _titles = array;
        
        [self createSegment];
        
    }
    return self;
}

- (void)createSegment{
    
    _itemWidth = self.frame.size.width / _itemsCount;

    
    for (int i = 0; i<_itemsCount; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(i * _itemWidth, 0, _itemWidth, self.frame.size.height);
        
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [btn setTitleColor:[UIColor colorWithRed:140 / 255.0 green:140 / 255.0 blue:140 / 255.0 alpha:1] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        btn.tag = 100 + i;
        
        [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]];
        
        if (i == 0) {
            
            btn.selected = YES;
            
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            
            [btn setBackgroundColor:[UIColor colorWithRed:0 green:0.7 blue:0.96 alpha:1]];
        }
        
        [self addSubview:btn];
        
    }
    _selectImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-2, _itemWidth, 2)];
    
    _selectImg.image = [UIImage imageNamed:@"color_line"];
    
    [self addSubview:_selectImg];

}

- (void)selectAction:(UIButton *)sender{

    //1.获取点击按钮的下标
    NSInteger index = sender.tag - 100;
    
    //2.将视图上所有的button状态变为非选中
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)subView;
            
            button.selected = NO;
            //设置非选中的字体大小为16
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            
            [button setBackgroundColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]];
        }
        
    }
    
    //3.选中的button字体为25
    sender.selected = YES;
    
    sender.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [sender setBackgroundColor:[UIColor colorWithRed:0 green:0.7 blue:0.96 alpha:1]];
    
    //4.选中图片的移动动画
   
//    NSLog(@"%ld",index);
    _segmentBlock(index);

}



@end
