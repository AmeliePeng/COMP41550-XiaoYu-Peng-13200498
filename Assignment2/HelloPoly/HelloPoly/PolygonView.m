//
//  PolygonView.m
//  HelloPoly
//
//  Created by Amelie on 14-1-28.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import "PolygonView.h"

@implementation PolygonView

- (void)initPropertiesToDefaultValues
{
    self.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
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
-(CGFloat)cornerFactor{return self.bounds.size.height/180.0;}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect %@",[NSString stringWithFormat:@"%d",self.numberOfSides]);

    // Drawing code
    CGRect insetRect = CGRectInset(rect, self.lineWidth / 2, self.lineWidth / 2);
    NSArray *points = [self pointsForPolygonInRect:insetRect numberOfSides:self.numberOfSides];
    if (points.count > 2)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGPoint aPoint =  [points[0] CGPointValue];
        CGContextMoveToPoint(context, aPoint.x, aPoint.y);
   
        for (int i = 1; i < points.count; i++)
        {
            aPoint =  [points[i] CGPointValue];
            CGContextAddLineToPoint(context, aPoint.x, aPoint.y);
        }
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
      
    }
    

    
    [self drawCorners:insetRect];
  
}

-(void)drawCorners:(CGRect)rect
{
    UIFont *cornerFont=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont=[cornerFont fontWithSize:cornerFont.pointSize *[self cornerFactor]];
    
    NSAttributedString *CornerText=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[self name]] attributes:@{NSFontAttributeName:cornerFont }];
    
    CGRect textBounds;
    textBounds.origin=CGPointMake((rect.size.width-CornerText.size.width) / 2.0, (rect.size.height-CornerText.size.height) / 2.0);
    textBounds.size=[CornerText size];
    [CornerText drawInRect:textBounds ];
    //[CornerText drawInRect:textBounds withFont:cornerFont  alignment:NSTextAlignmentCenter];

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
