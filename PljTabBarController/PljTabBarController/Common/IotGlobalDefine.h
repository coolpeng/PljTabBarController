//
//  IotGlobalDefine.h
//  PljTabBarController
//
//  Created by Edward on 2018/6/7.
//  Copyright © 2018年 coolpeng. All rights reserved.
//

#ifndef IotGlobalDefine_h
#define IotGlobalDefine_h

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kTabBarHeight   (kDevice_Is_iPhoneX ? (49.f+34.f):(49.f))

#endif /* IotGlobalDefine_h */
