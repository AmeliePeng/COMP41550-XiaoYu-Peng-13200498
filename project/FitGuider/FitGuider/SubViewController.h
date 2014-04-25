//
//  SubViewController.h
//  FitGuider
//
//  Created by Amelie on 14-3-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface SubViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong) NSMutableArray *materials;
@property (nonatomic) bool strikethrough;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) NSMutableArray        *destinationsArray;

@property (strong,nonatomic)IBOutlet UITableView *tableView;
//@property (nonatomic,retain) IBOutlet UITableView *tableView;
@end




