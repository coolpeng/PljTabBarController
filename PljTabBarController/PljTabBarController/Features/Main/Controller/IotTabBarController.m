//
//  IotTabBarController.m
//  PljTabBarController
//
//  Created by Edward on 2018/6/7.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import "IotTabBarController.h"
#import "IotTabBar.h"
#import "ThirdViewController.h"

@interface IotTabBarController ()<IotTabBarDelegate>

@end

@implementation IotTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize {
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabBarSubViewController];
    [self  initIotTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
- (void)initTabBarSubViewController {
    
    // 类名
    NSArray *classNames = @[@"FirstViewController",@"SecondViewController"
                            ,@"FourthViewController",@"FifthViewController"];
    // 标题名
    NSArray *titles = @[@"设备",@"场景",@"发现",@"我的"];
    
    // 图标
    NSArray *tabBarImages = @[@"tab_btn_device",@"tab_btn_discovery"
                              ,@"tab_btn_home",@"tab_btn_personal"];
    
    //分别实例化并添加到nav中
    for (int i = 0 ; i<classNames.count; i++) {
        Class class = NSClassFromString(classNames[i]);
        UIViewController *oneVC = [[class alloc] init];
        oneVC.title = titles[i];
        oneVC.view.backgroundColor = [UIColor lightGrayColor];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:oneVC];
        navVC.navigationBar.translucent = NO;
        oneVC.tabBarItem.title = titles[i];
        oneVC.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",tabBarImages[i]]];
        oneVC.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",tabBarImages[i]]];
        [self addChildViewController:navVC];
    }
}

- (void)initIotTabBar {
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换
    IotTabBar *tabbar = [[IotTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
}

#pragma mark - Delegate
#pragma mark IotTabBarDelegate
- (void)tabBar:(IotTabBar *)tabBar didClickPlusButton:(UIButton *)btn {
    
    ThirdViewController *plusVC = [[ThirdViewController alloc] init];
    plusVC.view.backgroundColor = [UIColor orangeColor];
    [self presentViewController:plusVC animated:YES completion:nil];
}


@end
