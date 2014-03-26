//
//  Photo.h
//  calledFlickrBrowser
//
//  Created by Amelie on 14-3-21.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSData * thumbnail;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * unique;

@end
