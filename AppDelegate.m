//
//  AppDelegate.m
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarController.h"
#import "CustomNavigationController.h"
#import "BWPNavigationController.h"
#import "LoginViewController.h"
#import "StatusSelectViewController.h"
#import "CustomNavigationController.h"
#import "HomeViewController.h"
#import "InHomeSchoolViewController.h"
#import "SchoolMoreViewController.h"
@interface AppDelegate ()
{
    CustomTabBarController *_tabBar;
    CustomTabBarController *_tabBar1;
    CustomNavigationController *nav1;
    LoginViewController *loginViewC;
    NSMutableArray *controllerArr;
    NSMutableArray *controllerArr1;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //引导页
    InHomeSchoolViewController *inVC = [[InHomeSchoolViewController alloc]init];
    [inVC setBlock:^() {
        self.window.rootViewController = nav1;
    }];
    self.window.rootViewController = inVC;
    
    //登录页
    loginViewC = [[LoginViewController alloc]init];
    nav1 = [[CustomNavigationController alloc]initWithRootViewController:loginViewC];
    __weak AppDelegate *weakSelf = self;
    [loginViewC setBlock:^(NSInteger index) {
        __strong AppDelegate *strongSelf = weakSelf;
        [strongSelf loginInfo:index];
    }];
    
    [loginViewC setInfoBlock:^(NSDictionary *dic) {
        __strong AppDelegate *strongSelf3 = weakSelf;
        [strongSelf3 loginUserInfo:dic];
    }];
    
    
    return YES;
}

- (void)loginUserInfo:(NSDictionary *)dic{
    NSString *code = [dic objectForKey:@"code"];
    if ([code integerValue] == 100) {
        controllerArr = [[NSMutableArray alloc]init];
        NSArray *vc_class = @[@"NewsViewController",@"AddressListViewController"];
        HomeViewController *homeVC = [[HomeViewController alloc]init];
        BWPNavigationController *navC = [[BWPNavigationController alloc]initWithRootViewController:homeVC];
        __weak AppDelegate *weakSelf1 = self;
        [homeVC setBlock:^(NSInteger index) {
            __strong AppDelegate *strongSelf1 = weakSelf1;
            [strongSelf1 loginInfo:index];
        }];
        [controllerArr addObject:navC];
        for (int i = 0; i<vc_class.count; i++) {
            //通过类名创建一个视图控制器
            NSString *className = vc_class[i];
            UIViewController *vc = [[NSClassFromString(className) alloc]init];
            //添加导航控制器
            BWPNavigationController *nav = [[BWPNavigationController alloc]initWithRootViewController:vc];
            //添加到数组
            [controllerArr addObject:nav];
        }
        //添加到数组
        CustomTabBarController *tabBar = [[CustomTabBarController alloc]initWithSelectImage:nil tabBarImage:[UIImage imageNamed:@"tabbarbg"] WithIndex:0];
        tabBar.viewControllers = controllerArr;
        self.window.rootViewController = tabBar;
    }
    if ([code integerValue] == 102) {
        controllerArr1 = [[NSMutableArray alloc]init];
        NSArray *vc_class1 = @[@"SchooleNewsViewController",@"SchooleAddressBookViewController",@"SchoolAttRecordViewController"];
        
        for (int i = 0; i<vc_class1.count; i++) {
            //通过类名创建一个视图控制器
            NSString *className = vc_class1[i];
            UIViewController *vc = [[NSClassFromString(className) alloc]init];
            
            
            //添加导航控制器
            BWPNavigationController *nav = [[BWPNavigationController alloc]initWithRootViewController:vc];
            //添加到数组
            [controllerArr1 addObject:nav];
        }
        SchoolMoreViewController *smVC = [[SchoolMoreViewController alloc]init];
        __weak AppDelegate *weakSelf1 = self;
        [smVC setBlock:^(NSInteger index) {
            __strong AppDelegate *strongSelf1 = weakSelf1;
            [strongSelf1 loginInfo:index];
            
        }];
        
        BWPNavigationController *nav3 = [[BWPNavigationController alloc]initWithRootViewController:smVC];
        //添加到数组
        [controllerArr1 addObject:nav3];
        CustomTabBarController *tabBar = [[CustomTabBarController alloc]initWithSelectImage:nil tabBarImage:[UIImage imageNamed:@"tabbarbg"] WithIndex:1];
        tabBar.viewControllers = controllerArr1;
        self.window.rootViewController = tabBar;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
