//
//  UIBaseClass.h
//  simc_app
//
//  Created by Amelie on 14-3-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "STViewController.h"



#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)




//状态栏高度
#define STATUS_BAR_HEIGHT 20


//状态栏高度
#define NAV_BAR_HEIGHT 44

#define STATUSBAR_HEIGHT 20


@interface UIBaseClass : NSObject


+ (UIBaseClass *)shareInstance;

-(int) getScreenWidth;
-(int) getScreenHeight;
-(int) getViewFramOX;
-(int) getViewFramOY;

@end
