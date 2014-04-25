//
//  AddUserWeight.m
//  FitGuider
//
//  Created by AaronYang on 19/04/2014.
//  Copyright (c) 2014 COMP41550. All rights reserved.
//

#import "AddUserWeight.h"


@interface AddUserWeight ()

@end

@implementation AddUserWeight

//set managedObjectContext
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

//@property (nonatomic, retain) NSDate * create_time;
//@property (nonatomic, retain) NSDate * date;
//@property (nonatomic, retain) NSString * unit;
//@property (nonatomic, retain) NSDate * update_time;
//@property (nonatomic, retain) NSNumber * user_id;
//@property (nonatomic, retain) NSNumber * weight;
//@property (nonatomic, retain) NSSet *userweight_user;

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


//查询
-(void)searchData:(NSNumber*) newWeight
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"UserWeight" inManagedObjectContext:self.managedObjectContext]];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date=%@@",self.localeDateTime];//查询条件
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"weight=%d",1];//查询条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date=%@",[self localeDateTime]];//查询条件
    
    
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"password='password3'"];//查询条件
    
    NSMutableArray *sortDescriptors = [NSMutableArray array];    //排序用
    [sortDescriptors addObject:[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] ];  //排序用
    
    [fetchRequest setPredicate:predicate];  //查询条件
    [fetchRequest setFetchBatchSize:100];     //分页
    [fetchRequest setSortDescriptors:sortDescriptors];  //排序
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"date", @"weight", nil]];  //查询的字段，一般不需要
    NSError *error = nil;
    NSArray *fetchedItems = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSLog(@"fetchedItems:%@",fetchedItems);
    if (fetchedItems == nil) {
        NSLog(@"fetch request resulted in an error %@, %@", error, [error userInfo]);
    }else {
        
        for (UserWeight *user in fetchedItems)
        {
            //NSLog(@"user.date:%@",user.date);
            [self updateUserWeight: user newWeight: newWeight];  //更新
        }
        NSLog(@"Yes");
    }
}


//更新：直接修改对象，保存managedObjectContext就好
-(void)updateUserWeight:(UserWeight*)user newWeight:(NSNumber*) newWeight
{
    user.weight = newWeight;   //修改后，直接保存managedObjectContext就可以了
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSLog(@"update success");
}

//Get weights
-(NSArray *)getWeights
{
    NSMutableArray * weightArray =[[NSMutableArray alloc] init];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"UserWeight" inManagedObjectContext:self.managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"weight>%d",0];//查询条件
    
    [fetchRequest setPredicate:predicate];  //查询条件
    [fetchRequest setFetchBatchSize:100];     //分页
    //[fetchRequest setSortDescriptors:sortDescriptors];  //排序
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"date", @"weight", nil]];  //查询的字段，一般不需要
    NSError *error = nil;
    NSArray *fetchedItems = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSLog(@"fetchedItems:%@",fetchedItems);
    if (fetchedItems == nil) {
        NSLog(@"fetch request resulted in an error %@, %@", error, [error userInfo]);
    }else {
        
        for (UserWeight *user in fetchedItems)
        {
            [weightArray addObject:user.weight];
            NSLog(@"user.weight:%@",user.weight);
            NSLog(@"weightArray:%lu",[weightArray count]);
        }
    }
    return weightArray;
}


//Default functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
