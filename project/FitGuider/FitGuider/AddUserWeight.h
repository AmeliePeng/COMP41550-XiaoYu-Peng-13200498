//
//  AddUserWeight.h
//  FitGuider
//
//  Created by AaronYang on 19/04/2014.
//  Copyright (c) 2014 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserWeight.h"

@interface AddUserWeight : UIViewController
- (void)addUserWeight:(NSNumber*) weight;
-(NSString *) localeDateTime;
-(void)searchData:(NSNumber*) newWeight;
-(void)updateUserWeight:(UserWeight*)user newWeight:(NSNumber*) newWeight;
-(NSArray *)getWeights;
@end
