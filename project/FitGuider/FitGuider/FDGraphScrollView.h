//
//  FDCaptionGraphView.h
//  SampleProj
//
//  Created by Amelie on 14-3-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDGraphView.h"

@class FDGraphScrollView;

@protocol FDCaptionGraphViewDataSource <NSObject>

@optional
- (NSString *)FDGraphScrollView:(FDGraphScrollView *)graphView titleForItemAtIndex:(NSInteger)index;
- (NSString *)FDGraphScrollView:(FDGraphScrollView *)graphView subtitleForItemAtIndex:(NSInteger)index;

@end

@interface FDGraphScrollView : UIScrollView

@property (nonatomic, strong) FDGraphView *graphView;

- (void)setDataPoints:(NSArray *)dataPoints;

@end
