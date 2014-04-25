//
//  AddDish.h
//  FitGuider
//
//  Created by Amelie on 14-4-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDish : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *dish_id;
@property (weak, nonatomic) IBOutlet UITextField *dish_tittle;
@property (weak, nonatomic) IBOutlet UITextField *dish_describe;
@property (weak, nonatomic) IBOutlet UITextField *image_id;
@property (weak, nonatomic) IBOutlet UITextField *dish_type;
@property (weak, nonatomic) IBOutlet UITextField *process;

- (IBAction)addDish:(id)sender;
@end
