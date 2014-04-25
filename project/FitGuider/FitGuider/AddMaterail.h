//
//  AddMaterail.h
//  FitGuider
//
//  Created by Amelie on 14-4-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMaterail : UIViewController
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *dish_id;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UITextField *unit;
@property (weak, nonatomic) IBOutlet UITextField *discription;
@property (weak, nonatomic) IBOutlet UITextField *type;

- (IBAction)addMaterial:(id)sender;
@end
