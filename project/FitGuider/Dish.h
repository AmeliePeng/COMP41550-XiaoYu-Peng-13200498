//
//  Dish.h
//  FitGuider
//
//  Created by Amelie on 14-4-24.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Material;

@interface Dish : NSManagedObject

@property (nonatomic, retain) NSDate * create_time;
@property (nonatomic, retain) NSString * dish_describe;
@property (nonatomic, retain) NSString * dish_id;
@property (nonatomic, retain) NSString * dish_tittle;
@property (nonatomic, retain) NSString * dish_type;
@property (nonatomic, retain) NSString * image_id;
@property (nonatomic, retain) NSString * process;
@property (nonatomic, retain) NSDate * update_time;
@property (nonatomic, retain) NSNumber * visit_time;
@property (nonatomic, retain) NSNumber * visit_times;
@property (nonatomic, retain) Image *haveimage;
@property (nonatomic, retain) NSSet *havematerial;
@end

@interface Dish (CoreDataGeneratedAccessors)

- (void)addHavematerialObject:(Material *)value;
- (void)removeHavematerialObject:(Material *)value;
- (void)addHavematerial:(NSSet *)values;
- (void)removeHavematerial:(NSSet *)values;

@end
