//
//  FitGuiderViewController.m
//  FitGuider
//
//  Created by Amelie on 14-3-8.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import "FitGuiderViewController.h"
#import "SampleCell.h"
#import "DetailViewController.h"
#import "ADTickerLabel.h"
#import "FDGraphView.h"
#import "FDGraphScrollView.h"
#import "MWWindow.h"
#import "SubViewController.h"
#import "InputDish.h"
#import "UIBaseClass.h"
#import "CalendarDateUtil.h"
#import "AddUserWeight.h"

#define TABLE_HEIGHT 130
#define kWindowHeaderHeight 80

#define dailyFoodScrollView_TAG 1
#define linearContainerScrollView_TAG 2

@interface FitGuiderViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) MWWindow *nextWindow;
@property (nonatomic, retain) NSMutableArray* arrayForPlaces;
@property (nonatomic, strong) ADTickerLabel *firstTickerLabel;
@property (nonatomic, strong) ADTickerLabel *secondTickerLabel;
@property (nonatomic, strong) NSArray *numbersArray;
@property (nonatomic, unsafe_unretained) NSInteger currentIndex;
@property(nonatomic) NSInteger weight;
@property (nonatomic, strong) FDGraphScrollView *lineScrollView;


@end

@implementation FitGuiderViewController
{
//    BTGlassScrollView *_glassScrollView1;
//    BTGlassScrollView *_glassScrollView2;
//    BTGlassScrollView *_glassScrollView3;
    UIView *_glassScrollView1;
    UIView *_glassScrollView2;
    UIView *_glassScrollView3;
    
    
    int _page;
    float startContentOffsetX;
    float willEndContentOffsetX;
    float endContentOffsetX;
    bool showDetailWeightLine;
    
    //show dish
    NSInteger arrayCount;
    NSInteger currentPage;
    NSArray *dishArray;
    NSMutableArray *array;
    //UITableView  *table;
    //NSMutableArray *items;
    UIView *_glassScrollView;

    
    //show dish
    NSString* _timeString;
    
    NSString* _nowDateString;
    NSMutableArray* _btnArray;
   
    
    UIScrollView* _scrollView;
    UIView* _dateView;
    UIView* _workView;
    
    UILabel* dateLable;
    int _scrollDate;                    // middle data
    int _btnDate;
    
    int _changeWeek;                    //scroll data
    int _btnSelectDate;                 //btn position
    UIView* _changeDateR;
    UIView* _changeWorkR;
    UIView* _changeDateL;
    UIView* _changeWorkL;
    NSMutableArray* _changeBtnArrayR;   //RView Btn array
    NSMutableArray* _changeBtnArrayL;   //LView Btn array
    
    int _mmMainFX;
    int _mmMainFY;
    int _vFX;
    int _vFY;
    
}
@synthesize dailyFoodScrollView;
@synthesize detailWeightButton;
@synthesize linearContainerScrollView;

NSInteger installOnce = 0;


-(void)updateWeightChart
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Load the data of the table
    //[self loadDataOfTable];
    //End load the data of the table
    

    //Install the number of the weight
    [self loadNumberWeight];
    //End install the number of the weight

    //Add the line
    [self showLine];
    //End add the line
    
    //Load a button
    //[self loadAButton];
    //End Load a button
    /////////////////////////////
    _page = 0;
    
    showDetailWeightLine = false;
    
//    _scrollView.tag = 1;
    dailyFoodScrollView.tag = 1;
    linearContainerScrollView.tag = 2;
    [linearContainerScrollView setContentOffset:CGPointMake(321, 0)];
    
    
//    CGFloat blackSideBarWidth = 2;
//    _glassScrollView1 = [[BTGlassScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, 300) BackgroundImage:[UIImage imageNamed:@"images-1.jpeg"] blurredImage:nil viewDistanceFromBottom: 1000 foregroundView:[self customView]];
//    _glassScrollView2 = [[BTGlassScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, 300) BackgroundImage:[UIImage imageNamed:@"images-2.jpeg"] blurredImage:nil viewDistanceFromBottom:1000  foregroundView:[self customView]];
//    _glassScrollView3 = [[BTGlassScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, 300) BackgroundImage:[UIImage imageNamed:@"images-3.jpeg"] blurredImage:nil viewDistanceFromBottom:1000
//        foregroundView:[self customView]];
    
    
    //[dailyFoodScrollView setPagingEnabled:YES];
    [dailyFoodScrollView setDelegate:self];
    [linearContainerScrollView setDelegate:self];

//
    
    //show dish
    currentPage=0;
    
    [self putViewInArray];
//     UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
//     backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 320, 14, 0)];//(top,left,bottom,right)
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
//    //(top,left,bottom,right)
//
//    [self.view addSubview:backgroundView];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage *image = [UIImage imageNamed:@"back6.jpg"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0) resizingMode: UIImageResizingModeTile];
    imageView.image = image;
    
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];

    
}


//initial scroll view
-(void) putViewInArray{
    //set scroll view
    NSInteger count=[self getArrayCount];
    //NSInteger count=5;
    array = [NSMutableArray arrayWithCapacity:count];
    [dailyFoodScrollView setDelegate:self];
    currentPage=0;
    [array removeAllObjects];
    for (int i = 0; i < count; i++) {
        _glassScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 450)];
        _glassScrollView.backgroundColor=[UIColor whiteColor];
        //_fetchedResultsController=nil;
        //[self fetchedResultsController];
        //[table reloadData];
        [_glassScrollView addSubview:[self customView]];
        [array addObject:_glassScrollView];
        [dailyFoodScrollView addSubview:_glassScrollView];
    }
    
}

//show dish get subview count
-(NSInteger)getArrayCount{
    
    _fetchedResultsController=nil;
    [self fetchedResultsController];
    NSLog(@"arraycount %f,%lu",floor(_dishes.count/3)+1,(unsigned long)_dishes.count);
    return floor(_dishes.count/3)+1;
    
}


//////
//Insert code from Amelie
//////

//-(void) scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    int offsetX = scrollView.contentOffset.x;
//    NSLog(@"offsetX: %d",offsetX);
//    if(offsetX < 0){
//        [linearContainerScrollView setContentOffset:CGPointMake(320*2, 0)animated:YES];
//    }
//    if(offsetX > 320*2){
//        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
//}


//Dish scrollView drag
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
        startContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    endContentOffsetX = scrollView.contentOffset.x;
    
    if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { //move，前一页
        NSLog(@"left");
        if ([self _getCurrentPageWithScrollView:scrollView] ==1) {
            NSLog(@"left_1");
            
        }
        
        currentPage =[self _getCurrentPageWithScrollView:scrollView];
        _fetchedResultsController=nil;
        [self fetchedResultsController];
        _glassScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 450)];
        _glassScrollView.backgroundColor=[UIColor clearColor];
        [_glassScrollView addSubview:[self customView]];
        [array addObject:_glassScrollView];
        
        
        CGFloat blackSideBarWidth = 0;
        [_glassScrollView setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, 450)];
        [_glassScrollView setFrame:CGRectOffset(_glassScrollView.bounds, currentPage*dailyFoodScrollView.frame.size.width, 0)];
        [dailyFoodScrollView addSubview:_glassScrollView];
        
        
    } else if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {//scroll move to left，back page
        NSLog(@"right");

        currentPage =[self _getCurrentPageWithScrollView:scrollView];
        _fetchedResultsController=nil;
        [self fetchedResultsController];
        _glassScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 450)];
        _glassScrollView.backgroundColor=[UIColor clearColor];
        //_fetchedResultsController=nil;
        //[self fetchedResultsController];
        //[table reloadData];
        [_glassScrollView addSubview:[self customView]];
        [array addObject:_glassScrollView];
        
        
        CGFloat blackSideBarWidth = 0;
        [_glassScrollView setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, 450)];
        [_glassScrollView setFrame:CGRectOffset(_glassScrollView.bounds, currentPage*dailyFoodScrollView.frame.size.width, 0)];
        [dailyFoodScrollView addSubview:_glassScrollView];
        
        //NSLog(@"currentpage %i %i",[self _getCurrentPageWithScrollView:scrollView],array.count);
        NSInteger count=[self getArrayCount];
//        if ([self _getCurrentPageWithScrollView:scrollView] ==count) {
//            NSLog(@"lastpage %i",count);
//            currentPage=0;
//            [dailyFoodScrollView setContentOffset:CGPointMake(0 * dailyFoodScrollView.frame.size.width, 0)];
//            
//            
//        }
        
        if ([self _getCurrentPageWithScrollView:scrollView] ==1) {
            NSLog(@"right_1");
            
        }
    }
    
}

//calculate page index
- (NSInteger)_getCurrentPageWithScrollView:(UIScrollView *)scrollView {
    // get width of subview
    CGFloat pageWidth = scrollView.frame.size.width;
    // calculate the position of subview by subview width
    int currentPage = floor((scrollView.contentOffset.x - pageWidth/ 2) / pageWidth)+ 1;
    return currentPage;
}

//End dish scrollView drag


- (void)viewWillAppear:(BOOL)animated
{
      [self  showScrollView];
    
}

-(void)showScrollView{
    
    int page = _page; // resize scrollview can cause setContentOffset off for no reason and screw things up
    CGFloat blackSideBarWidth = 0;
    
    [dailyFoodScrollView setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, 450)];
    [dailyFoodScrollView setContentSize:CGSizeMake(array.count*dailyFoodScrollView.frame.size.width, 450)];
    
    //set background
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    UIImage *buttonBackgroundImage = [[UIImage imageNamed:@"background.jpg"]
//                                      resizableImageWithCapInsets:UIEdgeInsetsMake(0,800,0,800)];
//    [self.m_Btn setBackgroundImage:buttonBackgroundImage
//                          forState:UIControlStateNormal];
    
//    UIImage *image = [UIImage imageNamed:@"background.jpg"];
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0) resizingMode: UIImageResizingModeTile];
    //imageView.image = image;
//    [dailyFoodScrollView setBackgroundColor:[UIColor colorWithPatternImage:buttonBackgroundImage]];
    //[self.view addSubview:imageView];
    
    
    //UIImage*img =[UIImage imageNamed:@"background.jpg"];
    //[dailyFoodScrollView setBackgroundColor:[UIColor colorWithPatternImage:img]];
    for (int i = 0; i < array.count; i++) {
        [array[i] setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, 450)];
        //[_glassScrollView2 setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, 330)];
        //[_glassScrollView3 setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, 330)];
        [array[i] setFrame:CGRectOffset(_glassScrollView2.bounds, i*dailyFoodScrollView.frame.size.width, 0)];
        //[_glassScrollView3 setFrame:CGRectOffset(_glassScrollView3.bounds, 2*dailyFoodScrollView.frame.size.width, 0)];
    }
    // [dailyFoodScrollView setContentOffset:CGPointMake(2 * dailyFoodScrollView.frame.size.width, 0)];
    [dailyFoodScrollView setContentOffset:CGPointMake(0 * dailyFoodScrollView.frame.size.width, 0)];
    _page = page;
    
    NSLog(@"_page %i",_page);
}

- (UIView *)customView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 450)];
    //    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 310, 125)];
    //    tableView.layer.cornerRadius = 3;
    //    tableView.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    //
    //
    //
    //    _sdvc = [[ShowDishController  alloc] initWithNibName:@"ShowDishController" bundle:nil];
    //    _sdvc.view.frame = CGRectMake(0, 0, 320, 325);
    // [view addSubview:_sdvc.view];
    
    //   UITableView *dailyFoodTableView = [[UITableView  alloc] initWithNibName:@"DailyFoodViewController" bundle:nil];
    // ShowDishController *sdvc = [[ShowDishController  alloc] initWithNibName:@"ShowDishController" bundle:nil];
    //vc.view.backgroundColor = [UIColor clearColor];
    // _nextWindow.rootViewController = sdvc;
    
    //UITableView  *table;
    
    UITableView *table1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0.00, 300, 450)];
    table1.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
    //table1.backgroundColor=[UIColor whiteColor];
    table1.backgroundColor = [UIColor clearColor];
    table1.rowHeight = 300;
    table1.separatorStyle = UITableViewCellSeparatorStyleNone;
    //添加到view窗体上
    //[view addSubview:table1];
    table1.delegate=self;
    table1.dataSource=self;
    [table1 reloadData];
    
    [view addSubview: table1];
    //table=table1;
    return view;
}


//calculate the weight
- (void)loadNumberWeight
{
    self.currentIndex = 0;
    self.numbersArray = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9];
    
    UIFont *font = [UIFont boldSystemFontOfSize: 30];
    
    self.firstTickerLabel = [[ADTickerLabel alloc] initWithFrame: CGRectMake(300, 36, 0, font.lineHeight)];
    self.firstTickerLabel.font = font;
    self.firstTickerLabel.characterWidth = 22;
    self.firstTickerLabel.changeTextAnimationDuration = 0.3;
    [self.view addSubview: self.firstTickerLabel];
    self.firstTickerLabel.text = [NSString stringWithFormat:@"%@", @"0"];
}

- (void)loadDataOfTable
{
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"SampleData" ofType:@"plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    self.arrayForPlaces = [plistDict objectForKey:@"Data"];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.arrayForPlaces count];
    return dishArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SampleCell *cell = (SampleCell*) [tableView dequeueReusableCellWithIdentifier:@"SampleCell"];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SampleCell" owner:[SampleCell class] options:nil];
        cell = (SampleCell *)[nib objectAtIndex:0];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    //NSDictionary* dict = [self.arrayForPlaces objectAtIndex:indexPath.row];
    NSManagedObject *dish = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
//    cell.labelForPlace.text = [NSString stringWithFormat:@"%@",[dish valueForKey:@"dish_tittle"]];
//    cell.labelForCountry.text = [NSString stringWithFormat:@"%@",[dish valueForKey:@"dish_describe"]];
    
 
    
    cell.iconview.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[dish valueForKey:@"dish_type"]]];
    cell.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[dish valueForKey:@"image_id"]]];
    
    //UIImage *image = [UIImage imageWithData:[dish valueForKey:@"image_id"]];
//    UIImage* smallImage = [image scaleToSize:CGSizeMake(100.0f,100.0f)];
//    
//   cell.imageview.
    
    cell.iconview.layer.masksToBounds = YES;
    cell.iconview.layer.cornerRadius = 10.0;
    
    //appIconImage.image = [UIImage imageWithContentsOfFile:@"image.png"];
    cell.imageview.layer.masksToBounds = YES;
    cell.imageview.layer.cornerRadius = 10.0;
    cell.imageview.layer.borderWidth = 8.0;
    cell.imageview.layer.borderColor = [[UIColor whiteColor] CGColor];
    
//    UIImage *image = [UIImage imageWithData:[dish valueForKey:@"image_id"]];
//    image.layer.cornerRadius = 5.0;
//    image.layer.masksToBounds = YES;
//    
//    //And to add a border:
//    image.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    image.layer.borderWidth = 1.0;
//    image.image = [dish valueForKey:@"image_id"];
//    UIImage* smallImage = [image scaleToSize:CGSizeMake(100.0f,100.0f)];
//    
//    cell.imageView.image=smallImage;
//    [cell.imageView sizeToFit];

   // cell.imageView.image=smallImage;
    [cell.imageView sizeToFit];

    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect cellFrameInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect cellFrameInSuperview = [tableView convertRect:cellFrameInTableView toView:[tableView superview]];
    
    DetailViewController* detailViewController = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
    
    NSMutableDictionary* dict = [self.arrayForPlaces objectAtIndex:indexPath.row];
    detailViewController.dictForData = dict;
    detailViewController.yOrigin = cellFrameInSuperview.origin.y;
    NSLog(@"Self:%@",self.navigationController);
    
    [self.navigationController pushViewController:detailViewController animated:NO];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; [self presentViewController:detailViewController animated:YES completion:nil];
}


//get Dish data

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    //NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dish" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    // Edit the sort key as appropriate.
    NSSortDescriptor    *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dish_id"  ascending:YES];
    NSArray             *sortDescriptors = @[sortDescriptor];
    // Set the batch size to a suitable number.
    //[fetchRequest setFetchBatchSize:20];
    NSError *error1      = nil;
    NSArray *results1    = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error1];
    _dishes= [results1 valueForKey:@"dish_id"];
    
    [fetchRequest setFetchLimit:3];
    [fetchRequest setFetchOffset:currentPage*3];
    
    
    //NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employees"];
    fetchRequest.resultType = NSDictionaryResultType;
    
    NSError *error      = nil;
    NSArray *results    = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                                   error:&error];
    dishArray=results;
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    //[fetchRequest setFetchLimit:3];
    // int currentPage=[self _getCurrentPageWithScrollView:_scrollView];
    
    //[fetchRequest setFetchOffset:3];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    // NSError *error = nil;
    
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
    //test
    NSUInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    assert(error == nil);
    
    NSLog(@"Total count: %u", count);
    
    //fetchRequest.fetchOffset = 0;
    //fetchRequest.fetchLimit = 3;
    
    NSLog(@"Fetch offset: %u, limit: %u", fetchRequest.fetchOffset, fetchRequest.fetchLimit);
    
    NSArray* page1 = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    assert(error == nil);
    
    NSLog(@"Page 1 count: %u", page1.count);
    
    //fetchRequest.fetchOffset = 3;
    //fetchRequest.fetchLimit = 3;
    
    NSLog(@"Fetch offset: %u, limit: %u", fetchRequest.fetchOffset, fetchRequest.fetchLimit);
    
    NSArray* page2 = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    assert(error == nil);
    
    NSLog(@"Page 2 count: %u", page2.count);
    
    //[fetchRequest release];
    
    return _fetchedResultsController;
    
}
//subview
- (void)viewDidAppear:(BOOL)animated
{
    if(installOnce == 0)
    {
        
        _nextWindow = [[MWWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _nextWindow.windowLevel = UIWindowLevelStatusBar;
        
        SubViewController *vc = [[SubViewController  alloc] initWithNibName:@"SubViewController" bundle:nil];
        //vc.view.backgroundColor = [UIColor clearColor];
        _nextWindow.rootViewController = vc;
        //
        _nextWindow.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight([UIScreen mainScreen].bounds) - kWindowHeaderHeight);
        //
        [_nextWindow makeKeyAndVisible];
        
        installOnce++;
    }
}

/*write the weiht number in the property list
*premeter  float,the increase or decrease weight number
*property list with a dicinary include current time and weight arraylist
*weight arrylist include first time of weight,increase or dicrease number each day
*/

//The old name is writeDict
- (void)writeDynamicNumber:(float)weightNum {
    NSDictionary *innerDict;
    NSString *name;
    NSArray *weightNumList;
    name=@"Amelie";
    NSDate *now=[NSDate date];
    weightNumList=[NSArray arrayWithObjects:[NSNumber numberWithFloat:97],[NSNumber numberWithFloat:weightNum],nil];
    NSString* plistPath_weight = [[NSBundle mainBundle] pathForResource:@"weight" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath_weight];

    innerDict = [NSDictionary dictionaryWithObjects:
                 [NSArray arrayWithObjects: name, now, weightNumList, nil]
    forKeys:[NSArray arrayWithObjects:@"Name", @"Time", @"Weight", nil]];
    //[rootObj setObject:innerDict forKey:@"Washington"];
    
    //NSInteger *weightNumStr=&weightNum;
    [data setObject:@"weightNum" forKey:@"weight"];
    [data setObject:@"now" forKey:@"date"];
    // get path
    NSString *home = NSHomeDirectory();
    NSString *documents = [home stringByAppendingPathComponent:@"Documents"];

    NSString *path = [documents stringByAppendingPathComponent:@"weight.plist"];
    
    [data writeToFile:path atomically:YES];
}

//The old name is readDict
- (void)showLine
{
//    NSString* plistPath_weight = [[NSBundle mainBundle] pathForResource:@"weight" ofType:@"plist"];
//    NSDictionary *dict_weight = [[NSDictionary alloc] initWithContentsOfFile:plistPath_weight];
//    self.weight = (long)[dict_weight objectForKey:@"weight"];
    //FDGraphScrollView
    
    
    //Remove first subview from linearContainerScrollView.
    //And load a new line to it
    //[[linearContainerScrollView.subviews objectAtIndex:0] removeFromSuperview];
    //linearContainerScrollView.hidden = false;
    //self.lineScrollView.hidden = false;
    //End
    
    //The right value is 900
    self.lineScrollView = [[FDGraphScrollView alloc] initWithFrame:CGRectMake(0, 0, 900, 80)];
    //self.lineScrollView.dataPoints = [dict_weight objectForKey:@"weight"];
    
    //Add weights to line
    AddUserWeight *add = [AddUserWeight alloc];
    self.lineScrollView.dataPoints = [add getWeights];
    //NSLog(@"[add getWeights]:%@", [add getWeights]);
    //self.lineScrollView.dataPoints = @[@0, @0, @30, @0, @30, @0, @30, @0, @30, @0];
    
    self.lineScrollView.hidden = true;
    linearContainerScrollView.hidden = true;
    [linearContainerScrollView setContentSize:CGSizeMake(3*linearContainerScrollView.frame.size.width, linearContainerScrollView.frame.size.height)];
    linearContainerScrollView.backgroundColor = [UIColor colorWithRed:0.5 green:1 blue:1 alpha:1.0];
    [linearContainerScrollView addSubview: self.lineScrollView];
    [self.view addSubview: linearContainerScrollView];
}

/////////////////////////////////////////////////
-(void)resetLineWeights:(NSArray*) weightArray
{
    self.lineScrollView = [[FDGraphScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    //self.lineScrollView.dataPoints = [dict_weight objectForKey:@"weight"];
    
    //Add weights to line
    AddUserWeight *add = [AddUserWeight alloc];
    self.lineScrollView.dataPoints = [add getWeights];
    //NSLog(@"[add getWeights]:%@", [add getWeights]);
    self.lineScrollView.dataPoints = weightArray;
    
    self.lineScrollView.hidden = true;
    linearContainerScrollView.hidden = true;
    [linearContainerScrollView setContentSize:CGSizeMake(3*linearContainerScrollView.frame.size.width, linearContainerScrollView.frame.size.height)];
    linearContainerScrollView.backgroundColor = [UIColor clearColor];
    [linearContainerScrollView addSubview: self.lineScrollView];
    [self.view addSubview: linearContainerScrollView];
}


- (IBAction)lastNumberAdd:(id)sender{

    //[self.firstTickerLabel setScrollDirection:ADTickerLabelScrollDirectionUp];
    
    self.currentIndex++;
    if(self.currentIndex == [self.numbersArray count])
        self.currentIndex = 0;
    self.firstTickerLabel.text = [NSString stringWithFormat:@"%@", self.numbersArray[self.currentIndex]];
   //
    // NSLog(@"weight:%ld",(long)self.weight);
    [self writeDynamicNumber:self.currentIndex];
    
    //[self addUserWeight:[NSNumber numberWithInt:(int)self.currentIndex]];
    //[self readDict];
    
    // Insert weight into coredata
    AddUserWeight *add = [AddUserWeight alloc];
    
    //[add addUserWeight: [NSNumber numberWithInt:(int)self.currentIndex]];
    
    [add addUserWeight: [NSNumber numberWithInt:(int)90]];
    
    //[add searchData:[NSNumber numberWithInt:(int)self.currentIndex]];
    //[self.lineScrollView ];
    [add getWeights];
    
    [self showLine];
    
    
    
    //Remove first subview from linearContainerScrollView.
    //And load a new line to it
    [[linearContainerScrollView.subviews objectAtIndex:0] removeFromSuperview];
    linearContainerScrollView.hidden = false;
    self.lineScrollView.hidden = false;
    //End
}



- (IBAction)lastNumberMinus:(id)sender {
    //[self.firstTickerLabel setScrollDirection:ADTickerLabelScrollDirectionDown];
    if(self.currentIndex == 0)
        self.currentIndex = [self.numbersArray count];
    self.currentIndex--;
    self.firstTickerLabel.text = [NSString stringWithFormat:@"%@", self.numbersArray[self.currentIndex]];
 //
    // NSLog(@"weight:%ld",(long)self.weight);
    [self writeDynamicNumber:self.currentIndex];
    //[self readDict];
    
    // Insert weight into coredata
    AddUserWeight *add = [AddUserWeight alloc];
    //[add addUserWeight: [NSNumber numberWithInt:(int)self.currentIndex]];
    [add searchData:[NSNumber numberWithInt:(int)self.currentIndex]];
    [add getWeights];
    
    [self showLine];
    
    //Remove first subview from linearContainerScrollView.
    //And load a new line to it
    [[linearContainerScrollView.subviews objectAtIndex:0] removeFromSuperview];
    linearContainerScrollView.hidden = false;
    self.lineScrollView.hidden = false;
    //End
}

//show input core data view
-(IBAction)displayNewView:(id)sender {
    [[NSBundle mainBundle] loadNibNamed:@"InputDish" owner:self options:nil];
    [self.view addSubview:_mrView];
}




- (IBAction)showDetailWeight:(id)sender {
    if(showDetailWeightLine == false)
    {
        dailyFoodScrollView.frame = CGRectMake(0, 200, dailyFoodScrollView.frame.size.width, dailyFoodScrollView.frame.size.height);
    
        //Add the line
        linearContainerScrollView.hidden = false;
        self.lineScrollView.hidden = false;
        //End add the line
        showDetailWeightLine = true;
    }
    else
    {
        dailyFoodScrollView.frame = CGRectMake(0, 112, dailyFoodScrollView.frame.size.width, dailyFoodScrollView.frame.size.height);
        linearContainerScrollView.hidden = true;
        self.lineScrollView.hidden = true;
        showDetailWeightLine = false;
    }
    
}

//Set Weight
//set managedObjectContext
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)addUserWeight:(NSNumber*) weight;
{
    NSManagedObjectContext *context = [self managedObjectContext];
    // NSString *unique = [self.photoArray objectAtIndex:5];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserWeight"];
    //request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", unique];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    NSManagedObject *userWeight = [NSEntityDescription insertNewObjectForEntityForName:@"UserWeight" inManagedObjectContext:context];
    
    [userWeight setValue: self.localeDateTime forKey :@"date"];
    [userWeight setValue: weight forKey:@"weight"];
    [userWeight setValue: @"KG" forKey:@"unit"];
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Success");
    
}

//Get date
-(NSString *) localeDateTime
{
    //    NSDate * seldate = [NSDate date];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate: seldate];
    //    NSDate * date = [seldate dateByAddingTimeInterval: interval];
    
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMdd"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    NSLog(@"locationString:%@",locationString);
    
    return locationString;
}


@end
