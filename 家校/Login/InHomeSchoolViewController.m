//
//  InHomeSchoolViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/26.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "InHomeSchoolViewController.h"

@interface InHomeSchoolViewController ()
{
    NSInteger _index;
}
@end

@implementation InHomeSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor yellowColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.width, view.height)];
    imageView.image = [UIImage imageNamed:@"startBG.jpg"];
    [view addSubview:imageView];
    
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(test:)
                                   userInfo:nil
                                    repeats:YES];

}

-(void)test:(NSTimer *)timer{
    _index ++;
    if (_index == 3) {
        
        
        [timer invalidate];
        _block();
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
