//
//  IotTabBar.m
//  PljTabBarController
//
//  Created by Edward on 2018/6/7.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#import "IotTabBar.h"
#import "UIView+Iot.h"

#define Magin 5

@interface IotTabBar ()

@property (nonatomic,strong) UIButton *plusBtn;
@property (nonatomic,strong) UILabel *plusTitleLabel;

@end

@implementation IotTabBar
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self plusBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    
    self.plusBtn.centerX = self.centerX;
    //调整发布按钮的中线点Y值
    self.plusBtn.centerY = 0;
    
    self.plusBtn.size = CGSizeMake(self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    
    self.plusTitleLabel.centerX = self.plusBtn.centerX;
    self.plusTitleLabel.centerY = CGRectGetMaxY(self.plusBtn.frame) + Magin*2 ;
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的五分之一
            btn.width = self.width / 5;
            
            btn.x = btn.width * btnIndex;
            
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    [self bringSubviewToFront:self.plusBtn];
}

#pragma mark - Lazy Load
- (UIButton *)plusBtn {
    if (!_plusBtn) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tab_btn_plus_normal"] forState:UIControlStateNormal];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tab_btn_plus_selected"] forState:UIControlStateHighlighted];
        [_plusBtn addTarget:self action:@selector(plusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}

- (UILabel *)plusTitleLabel {
    if (!_plusTitleLabel) {
        _plusTitleLabel = [[UILabel alloc] init];
        _plusTitleLabel.text = @"发布";
        _plusTitleLabel.font = [UIFont systemFontOfSize:11];
        [_plusTitleLabel sizeToFit];
        _plusTitleLabel.textColor = [UIColor grayColor];
        [self addSubview:_plusTitleLabel];
    }
    return _plusTitleLabel;
}

#pragma mark - Action
- (void)plusBtnAction:(UIButton *)sender {
    if ([self.myDelegate respondsToSelector:@selector(tabBar:didClickPlusButton:)]) {
        [self.myDelegate tabBar:self didClickPlusButton:sender];
    }
}

#pragma mark - Internal Method
//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    else {
        //tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
