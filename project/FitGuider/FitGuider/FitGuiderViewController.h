//
//  FitGuiderViewController.h
//  FitGuider
//
//  Created by Amelie on 14-3-8.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTGlassScrollView.h"

@interface FitGuiderViewController : UIViewController <UIScrollViewAccessibilityDelegate>

//Add master by Aaron Yang
- (IBAction)lastNumberAdd:(id)sender;
- (IBAction)lastNumberMinus:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *dailyFoodScrollView;

@property (weak, nonatomic) IBOutlet UIButton *detailWeightButton;

- (IBAction)showDetailWeight:(id)sender;

//show input core data view
@property (nonatomic, retain) IBOutlet UIView *mrView;
-(IBAction)displayNewView:(id)sender;
-(IBAction)displayOldView:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *linearContainerScrollView;



//show dish
@property (strong) NSMutableArray *dishes;
@property (nonatomic) bool strikethrough;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
