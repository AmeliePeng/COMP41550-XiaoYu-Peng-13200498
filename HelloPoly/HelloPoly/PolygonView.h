//
//  PolygonView.h
//  HelloPoly
//
//  Created by Amelie on 14-1-28.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolygonView : UIView

@property (assign,nonatomic) int numberOfSides;
@property (strong,nonatomic) NSString *name;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;
@end
