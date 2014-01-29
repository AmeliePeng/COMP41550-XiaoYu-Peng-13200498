//
//  PolygonView.h
//  HelloPoly
//
//  Created by Amelie on 14-1-26.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class PolygonView;
@interface PolygonView : UIView
@property (assign,nonatomic) int numberOfSides;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;
@end
