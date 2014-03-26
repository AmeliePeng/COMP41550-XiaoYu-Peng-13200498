//
//  main.m
//  calledFlickrBrowser
//
//  Created by Amelie on 14-3-20.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "calledFlickrBrowserAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
       // return UIApplicationMain(argc, argv, nil, NSStringFromClass([calledFlickrBrowserAppDelegate class]));
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([calledFlickrBrowserAppDelegate class]));
        } @catch (NSException *e) {
            NSLog(@"CRASH: %@", e);
            NSLog(@"Stack Trace: %@", [e callStackSymbols]);
        }
    }
}
