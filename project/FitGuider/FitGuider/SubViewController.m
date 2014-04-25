//
//  SubViewController.m
//  FitGuider
//
//  Created by Amelie on 14-3-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import "SubViewController.h"
#import "SampleCell.h"
#import "DetailViewController.h"
#import "ADTickerLabel.h"
#import "FDGraphView.h"
#import "FDGraphScrollView.h"
#import "MWWindow.h"
#import "InputDish.h"

#define TABLE_HEIGHT 80
#define kWindowHeaderHeight 80

@interface SubViewController ()

@property (nonatomic, retain) NSMutableArray* arrayForPlaces;
@property (nonatomic, strong) ADTickerLabel *firstTickerLabel;
@property (nonatomic, strong) ADTickerLabel *secondTickerLabel;
@property (nonatomic, strong) NSArray *numbersArray;
@property (nonatomic, unsafe_unretained) NSInteger currentIndex;
@property(nonatomic) NSInteger weight;
//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end

@implementation SubViewController
bool _strikethrough;
CALayer* _strikethroughLayer;

//initial data array
NSArray *tableData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data
    // tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    //Execute Fetch
    //[_fetchedResultsController performFetch:nil];
    //[NSFetchedResultsController];
    
    //Refresh Data
    //UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    //tableView.delegate = self;
    //tableView.dataSource = self;
   // [self.view addSubview:tableView];
   // [self fetchedResultsController];
    [self.tableView reloadData];
}



//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [tableData count];
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *simpleTableIdentifier = @"SimpleTableItem";
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
//
//    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
//    return cell;
//}


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

//- (void)viewDidAppear:(BOOL)animated
//{
//  [super viewDidAppear:animated];

// Fetch the devices from persistent data store
//  NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Material"];
// self.materials = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

// [self.tableView reloadData];
//}



//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//     //Return the number of rows in the section.
//    return self.materials.count;
//}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [[self.fetchedResultsController sections] count];
    //[self.tableView reloadData];
   // return 1;
    //return [self.fetchedCoursesArray count];
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    //return [sectionInfo numberOfObjects];
   // return [self.fetchedRoundsArray count];
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    NSManagedObject *material = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@ %@", [material valueForKey:@"name"], [material valueForKey:@"weight"],[material valueForKey:@"unit"]]];
    [cell.detailTextLabel setText:[material valueForKey:@"describe"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    CGSize size = [cell.textLabel.text sizeWithFont:cell.textLabel.font];
    CGFloat y = cell.contentView.frame.size.height / 2;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5,y,size.width, 3)];
    line.backgroundColor = [UIColor redColor];
    [cell.textLabel addSubview:line];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
}

-(void)setCellStyle
{
    //    CGSize expectedLabelSize = [string sizeWithFont:cell.titleLabel.font constrainedToSize:cell.titleLabel.frame.size lineBreakMode:UILineBreakModeClip];
    //    UIView *viewUnderline = [[UIView alloc] init];
    //    viewUnderline.frame = CGRectMake(20, 12, expectedLabelSize.width, 1);
    //    viewUnderline.backgroundColor = [UIColor grayColor];
    //    [cell addSubview:viewUnderline];
    //    [viewUnderline release];
    
    
    //    CGSize size = [cell.textLabel.text sizeWithFont:cell.textLabel.font];
    //    CGFloat y = cell.contentView.frame.size.height / 2;
    //
    //    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5,y,size.width, 3)];
    //    line.backgroundColor = [UIColor redColor];
    //    [cell.textLabel addSubview:line];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nodepad"]];
        // UIGraphicsBeginImageContext(self.view.frame.size);
        //[[UIImage imageNamed:@"nodepad"] drawInRect:self.view.bounds];
        //UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        // UIGraphicsEndImageContext();
        
        //self.view.backgroundColor = [UIColor colorWithPatternImage:image];
        
    }
    return self;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Material" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor    *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dish_id" ascending:NO];
    NSArray             *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"type" cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //Courses * courses = [self.fetchedCoursesArray objectAtIndex:section];
   // return courses.name;
    NSArray *sections = [[self fetchedResultsController] sections]; id <NSFetchedResultsSectionInfo> sectionInfo = nil;
    sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo name];
//    NSArray *sections = [[self fetchedResultsController] sections]; id <NSFetchedResultsSectionInfo> sectionInfo = nil;
//    sectionInfo = [sections objectAtIndex:section];
//    
//    return [sectionInfo name];
}

- (void)addStrikethrough:(UITableViewCell*)cell
{
    CGRect frame = cell.textLabel.frame;
    UILabel *strikethrough = [[UILabel alloc] initWithFrame:frame];
    strikethrough.opaque = YES;
    strikethrough.backgroundColor = [UIColor clearColor];
    strikethrough.text = @"------------------------------------------------";
    strikethrough.lineBreakMode = UILineBreakModeClip;
    [cell addSubview:strikethrough];
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    [self configureCell:cell atIndexPath:indexPath];
//    return cell;
//}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *material = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", [material valueForKey:@"name"], [material valueForKey:@"weight"],[material valueForKey:@"unit"]];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//
//    //Fetch the devices from persistent data store
//    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Material"];
//    self.materials = [[NSManagedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
//
//    [self.tableView reloadData];
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   static NSString *CellIdentifier = @"Cell";
//   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

// Configure the cell...
//   NSManagedObject *material = [self.materials objectAtIndex:indexPath.row];
//  [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@ %@", [material valueForKey:@"name"], [material valueForKey:@"weight"],[material valueForKey:@"unit"]]];
//[cell.detailTextLabel setText:[device valueForKey:@"company"]];

//  return cell;
//}


//- (NSManagedObjectContext *)managedObjectContext
//{
//    NSManagedObjectContext *context = nil;
//    id delegate = [[UIApplication sharedApplication] delegate];
//    if ([delegate performSelector:@selector(managedObjectContext)]) {
//        context = [delegate managedObjectContext];
//    }
//    return context;
//}




//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
// Return the number of rows in the section.
// return self.materials.count;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   static NSString *CellIdentifier = @"Cell";
//   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

// Configure the cell...
//   NSManagedObject *material = [self.materials objectAtIndex:indexPath.row];
//  [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@ %@", [material valueForKey:@"name"], [material valueForKey:@"weight"],[material valueForKey:@"unit"]]];
//[cell.detailTextLabel setText:[device valueForKey:@"company"]];

//  return cell;
//}


- (void)didReceiveMemoryWarning
{//
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
