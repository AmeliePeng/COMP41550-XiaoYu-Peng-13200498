//
//  PolygonView.m
//  HelloPoly
//
//  Created by Amelie on 14-1-26.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import "PolygonView.h"


@implementation PolygonView

- (void)initPropertiesToDefaultValues
{
     NSLog(@"init %@",[NSString stringWithFormat:@"%d",_numberOfSides]);
    self.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    self.strokeColor = [UIColor blackColor];
    self.lineWidth = 2.0;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initPropertiesToDefaultValues];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initPropertiesToDefaultValues];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{CGContextRef context = UIGraphicsGetCurrentContext(); // 取得現在的context
    [[UIColor grayColor] set]; // 將顏色設定成灰色
    UIRectFill ([self bounds]); // 將現在的View填滿灰色
    
    CGContextBeginPath (context); // 開始建立路徑
    CGContextMoveToPoint (context, 75, 10); // 先移動到(75, 10)這個點
    CGContextAddLineToPoint (context, 10, 150); // 從(75, 10)畫一條線道(10, 150)，注意，現在的定位點也同時移動到(10, 150)
    CGContextAddLineToPoint (context, 160, 150); // 從(10, 150)畫一條線到(160, 150)
    CGContextClosePath (context); // 關閉路徑
    
    [[UIColor redColor] setFill]; // 設定紅色為填滿路徑的顏色
    [[UIColor blackColor] setStroke]; // 設定黑色為邊的顏色
    CGContextDrawPath (context, kCGPathFillStroke); // 將路徑繪製出來，kCGPathFillStroke代表要填滿顏色並且塗邊
}


- (NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides {
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = 0.9 * center.x; NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / numberOfSides;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5 * exteriorAngle);
    
    for (int currentAngle = 0; currentAngle < numberOfSides; currentAngle++) {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:
                           CGPointMake(center.x+curX,center.y+curY)]];
    }
    return result; }

@end
