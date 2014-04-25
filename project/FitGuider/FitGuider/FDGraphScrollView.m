//
//  FDCaptionGraphView.m
//  SampleProj
//
//  Created by Amelie on 14-3-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import "FDGraphScrollView.h"

@implementation FDGraphScrollView

- (id)initWithFrame:(CGRect)frame {
    if ( (self = [super initWithFrame:frame]) ) {
        
        CGRect graphViewFrame = frame;
        graphViewFrame.origin.x = 0;
        graphViewFrame.origin.y = 0;
        
        _graphView = [[FDGraphView alloc] initWithFrame:graphViewFrame];
        _graphView.autoresizeToFitData = YES;
        self.backgroundColor = self.graphView.backgroundColor;
        
        [self addSubview:_graphView];
    }
    return self;
}

- (CGSize)contentSizeWithWidth:(CGFloat)width {
    return CGSizeMake(width, self.frame.size.height);
}

- (void)setDataPoints:(NSArray *)dataPoints {
    self.graphView.dataPoints = dataPoints;
    self.contentSize = [self contentSizeWithWidth:self.graphView.frame.size.width];
}

@end
