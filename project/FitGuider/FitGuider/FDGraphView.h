//
//  FDGraphView.h
//  disegno
//
//  Created by Amelie on 14-3-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDGraphView : UIView

// Data
@property (nonatomic, strong) NSArray *dataPoints;

// Style
@property (nonatomic) UIEdgeInsets edgeInsets;
@property (nonatomic) CGFloat dataPointsXoffset;
// -- colors
@property (nonatomic, strong) UIColor *dataPointColor;
@property (nonatomic, strong) UIColor *dataPointStrokeColor;
@property (nonatomic, strong) UIColor *linesColor;

// Behaviour
@property (nonatomic) BOOL autoresizeToFitData;

@end
