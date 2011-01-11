//
//  RootViewController.h
//  ContinuousTableview
//
//  Created by Stephen James on 11/01/11.
//  Copyright 2011 Key Options. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
}
@property (nonatomic,retain) NSArray* arr;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain) IBOutlet UIView *activityIndicatorView;

@property (nonatomic,retain) UIActivityIndicatorView *headerActivityIndicator;
@property (nonatomic,retain) UIActivityIndicatorView *footerActivityIndicator;


- (void) addItemsToEndOfTableView;
- (void) addItemsToStartOfTableView;

@end
