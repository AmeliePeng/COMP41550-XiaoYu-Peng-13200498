//
//  UserProfile.h
//  FitGuider
//
//  Created by Amelie on 14-4-24.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserProfile : NSManagedObject

@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSDate * create_time;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * job;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSDate * update_time;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSNumber * weight;

@end
