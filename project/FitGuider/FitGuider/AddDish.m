//
//  AddDish.m
//  FitGuider
//
//  Created by Amelie on 14-4-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import "AddDish.h"

@interface AddDish ()

@end

@implementation AddDish
@synthesize dish_type;
@synthesize image_id;
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
    // Do any additional setup after loading the view from its nib.

    //self.dish_type.delegate = self;
    //self.image_id.delegate = self;

    
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  YES;
}

- (IBAction)addDish:(id)sender;
{
    NSManagedObjectContext *context = [self managedObjectContext];
    // NSString *unique = [self.photoArray objectAtIndex:5];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Dish"];
    //request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", unique];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    NSManagedObject *dish = [NSEntityDescription insertNewObjectForEntityForName:@"Dish" inManagedObjectContext:context];
    
    

    [dish setValue:self.dish_id.text  forKey:@"dish_id"];
    [dish setValue:self.dish_tittle.text forKey:@"dish_tittle"];
    //[material setValue: [NSNumber numberWithInteger:[self.dish_describe.text integerValue]] forKey :@"dish_describe"];
    [dish setValue:self.dish_describe.text forKey:@"dish_describe"];
    //[material setValue:[NSNumber numberWithFloat:[self.weight.text floatValue]] forKey:@"weight"];
    [dish setValue:self.image_id.text forKey:@"image_id"];
    [dish setValue:self.dish_type.text forKey:@"dish_type"];
    [dish setValue:self.process.text forKey:@"process"];
    
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Success");
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) playClickForCustomKeyTap {
    [[UIDevice currentDevice] playInputClick];
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
