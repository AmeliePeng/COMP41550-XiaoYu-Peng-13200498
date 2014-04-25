//
//  Material.h
//  FitGuider
//
//  Created by Amelie on 14-4-24.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dish, Image;

@interface Material : NSManagedObject

@property (nonatomic, retain) NSDate * create_time;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * describe;
@property (nonatomic, retain) NSNumber * dish_id;
@property (nonatomic, retain) NSNumber * image_id;
@property (nonatomic, retain) NSNumber * isfinish;
@property (nonatomic, retain) NSNumber * material_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSDate * update_time;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) Dish *belongtodish;
@property (nonatomic, retain) Image *haveimage;

@end
