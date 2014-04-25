//
//  AddMaterail.m
//  FitGuider
//
//  Created by Amelie on 14-4-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import "AddMaterail.h"
#import "Material.h"
#import "FitGuiderAppDelegate.h"

@interface AddMaterail ()


@end

@implementation AddMaterail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//set managedObjectContext
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

    

- (IBAction)addMaterial:(id)sender;
{
    NSManagedObjectContext *context = [self managedObjectContext];
    // NSString *unique = [self.photoArray objectAtIndex:5];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Material"];
    //request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", unique];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    NSManagedObject *material = [NSEntityDescription insertNewObjectForEntityForName:@"Material" inManagedObjectContext:context];

  
    [material setValue: [NSNumber numberWithInteger:[self.dish_id.text integerValue]] forKey :@"dish_id"];
    [material setValue:self.name.text forKey:@"name"];
    [material setValue:[NSNumber numberWithFloat:[self.weight.text floatValue]] forKey:@"weight"];
    [material setValue:self.unit.text forKey:@"unit"];
    [material setValue:self.discription.text forKey:@"describe"];
    [material setValue:self.type.text forKey:@"type"];
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Success");

}







- (void)viewDidLoad
{
    [super viewDidLoad];
  
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
