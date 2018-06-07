//
//  IotTabBar.h
//  PljTabBarController
//
//  Created by Edward on 2018/6/7.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IotTabBar;

@protocol IotTabBarDelegate <NSObject>

@optional
- (void)tabBarPlusBtnClick:(IotTabBar *)tabBar;

- (void)tabBar:(IotTabBar *)tabBar didClickPlusButton:(UIButton *)btn;

@end

@interface IotTabBar : UITabBar

@property (nonatomic,weak)id<IotTabBarDelegate>myDelegate;

@end
