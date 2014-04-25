//
//  UserWeight.h
//  FitGuider
//
//  Created by Amelie on 14-4-24.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserProfile;

@interface UserWeight : NSManagedObject

@property (nonatomic, retain) NSDate * create_time;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSDate * update_time;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSSet *userweight_user;
@end

@interface UserWeight (CoreDataGeneratedAccessors)

- (void)addUserweight_userObject:(UserProfile *)value;
- (void)removeUserweight_userObject:(UserProfile *)value;
- (void)addUserweight_user:(NSSet *)values;
- (void)removeUserweight_user:(NSSet *)values;

@end
