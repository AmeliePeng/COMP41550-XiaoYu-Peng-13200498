//
//  ClientCell.h
//  PersonalTraining
//
//  Created by Amelie on 14-3-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.

#import <UIKit/UIKit.h>

@class AsyncImageView;

@interface SampleCell : UITableViewCell {
    
}

@property (retain, nonatomic) IBOutlet UILabel *labelForPlace;
@property (retain, nonatomic) IBOutlet UILabel *labelForCountry;
@property (retain, nonatomic) IBOutlet UIImageView *imageview;
@property (retain, nonatomic) IBOutlet UIImageView *iconview;

@end
