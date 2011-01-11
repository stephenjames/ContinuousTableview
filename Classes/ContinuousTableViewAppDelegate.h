//
//  ContinuousTableViewAppDelegate.h
//  ContinuousTableView
//
//  Created by Stephen James on 11/01/11.
//  Copyright 2011 Key Options. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContinuousTableViewAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

