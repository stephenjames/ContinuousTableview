//
//  RootViewController.m
//  ContinuousTableview
//
//  Created by Stephen James on 11/01/11.
//  Copyright 2011 Key Options. All rights reserved.
//

#import "RootViewController.h"

#define TABLEVIEW_START_INDEX 100
#define TABLEVIEW_PAGE_SIZE 10
#define TABLEVIEW_CELL_HEIGHT 44.0


@implementation RootViewController

@synthesize arr;
@synthesize activityIndicator;
@synthesize activityIndicatorView;
@synthesize headerActivityIndicator;
@synthesize footerActivityIndicator;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
  [super viewDidLoad];
  //set tableview header
  [[NSBundle mainBundle] loadNibNamed:@"ActivityIndicator-iPhone" owner:self options:nil]; //this gets a new instance from the xib
  self.headerActivityIndicator=self.activityIndicator;
  [[self tableView] setTableHeaderView:[self activityIndicatorView]];
  //set tableview footer
  [[NSBundle mainBundle] loadNibNamed:@"ActivityIndicator-iPhone" owner:self options:nil];//this gets a new instance from the xib
  self.footerActivityIndicator=self.activityIndicator;
  [[self tableView] setTableFooterView:[self activityIndicatorView]];  
  //populate the tableview with some data
  [self addItemsToEndOfTableView];
  //hide the header
  [self.tableView setContentOffset:CGPointMake(0, 1*TABLEVIEW_CELL_HEIGHT)];
}

- (void) addItemsToEndOfTableView{
  //if no existing data
  if([[self arr] count]==0){
    //initialise with 10 numbers
    NSInteger i,l;
    NSMutableArray *arr1=[NSMutableArray array];
    l=TABLEVIEW_START_INDEX+TABLEVIEW_PAGE_SIZE;
    for(i=TABLEVIEW_START_INDEX;i<l;i++){
      [arr1 addObject:[NSNumber numberWithInt:i]];
    }
    self.arr=arr1;
    return;
  }
  //copy the existing data
  NSInteger i,l;
  NSMutableArray *arr1=[NSMutableArray arrayWithArray:[self arr]];
  //get the final element of the array
  NSNumber *finalNo=[arr1 objectAtIndex:[arr1 count]-1];
  l=[finalNo intValue]+TABLEVIEW_PAGE_SIZE+1;
  for(i=[finalNo intValue]+1;i<l;i++){
    [arr1 addObject:[NSNumber numberWithInt:i]];
  }
  self.arr=arr1;
}

- (void) addItemsToStartOfTableView{
  //copy the existing data
  NSInteger i,l;
  NSMutableArray *arr1=[NSMutableArray arrayWithArray:[self arr]];
  //get the first element of the array
  NSNumber *no=[arr1 objectAtIndex:0];
  l=[no intValue]-TABLEVIEW_PAGE_SIZE;
  for(i=[no intValue]-1;i>=l;i--){
    [arr1 insertObject:[NSNumber numberWithInt:i] atIndex:0];
  }
  self.arr=arr1;
}


#pragma mark -
#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (([scrollView contentOffset].y + scrollView.frame.size.height) == [scrollView contentSize].height) {
    NSLog(@"scrolled to bottom");
    [[self footerActivityIndicator] startAnimating];
    [self performSelector:@selector(stopAnimatingFooter) withObject:nil afterDelay:0.5];
    return;
	}
	if ([scrollView contentOffset].y == scrollView.frame.origin.y) {
    NSLog(@"scrolled to top %@",[self activityIndicatorView]);
    [[self headerActivityIndicator] startAnimating];
    [self performSelector:@selector(stopAnimatingHeader) withObject:nil afterDelay:0.5];
	}
  
  
}
//stop the header spinner
- (void) stopAnimatingHeader{
  //add the data
  [[self headerActivityIndicator] stopAnimating];
  [self addItemsToStartOfTableView];
  //set an offset so visible cells aren't blasted
  [self.tableView setContentOffset:CGPointMake(0, TABLEVIEW_PAGE_SIZE*TABLEVIEW_CELL_HEIGHT)];
  [[self tableView] reloadData];
}
//stop the footer spinner
- (void) stopAnimatingFooter{
  //add the data
  [[self footerActivityIndicator] stopAnimating];
  [self addItemsToEndOfTableView];
  [[self tableView] reloadData];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self arr] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
	// Configure the cell.
  NSInteger ix=indexPath.row;
  NSInteger num=[[[self arr] objectAtIndex:ix] intValue];
  NSString *cellText = [NSString stringWithFormat:@"%d",num];
  [[cell textLabel] setText:cellText]; 
  return cell;
}



#pragma mark -
#pragma mark Memory management
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  self.arr=nil;
  self.activityIndicator=nil;
  self.activityIndicatorView=nil;
  self.headerActivityIndicator=nil;
  self.footerActivityIndicator=nil;
}


- (void)dealloc {
  [[self arr] release];
  [[self activityIndicator] release];
  [[self activityIndicatorView] release];
  [[self headerActivityIndicator] release];
  [[self footerActivityIndicator] release];
  [super dealloc];
}


@end

