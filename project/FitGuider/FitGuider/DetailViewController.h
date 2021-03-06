//
//  DetailViewController.h
//  AnimationMaximize
//
//  Created by Amelie on 14-3-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAIN_LABEL_Y_ORIGIN 0
#define IMAGEVIEW_Y_ORIGIN 15

@interface DetailViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *labelForPlace;
@property (retain, nonatomic) IBOutlet UILabel *labelForCountry;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIButton *doneBtn;
@property (retain, nonatomic) IBOutlet UITextView *textviewForDetail;
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (readwrite, nonatomic) int yOrigin;
@property (readwrite, nonatomic) int xOrigin;

@property (retain, nonatomic) NSMutableDictionary *dictForData;

- (IBAction)doneBtnPressed:(id)sender;
@end
