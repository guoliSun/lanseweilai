//
//  backButton.m
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "backButton.h"

@implementation backButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addInfo];
    }
    return self;
}

- (void)addInfo{
    [self setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
}

@end
