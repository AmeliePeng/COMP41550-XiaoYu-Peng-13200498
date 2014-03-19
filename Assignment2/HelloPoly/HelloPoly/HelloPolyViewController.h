//
//  HelloPolyViewController.h
//  HelloPoly
//
//  Created by Amelie on 14-1-23.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"
#import "PolygonView.h"

@interface HelloPolyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *numberOfSidesLabel;
@property (strong, nonatomic) IBOutlet PolygonShape *model;
- (IBAction)decrease:(id)sender;
- (IBAction)increase:(id)sender;

@property (weak, nonatomic) IBOutlet PolygonView *polygonView;



@end

