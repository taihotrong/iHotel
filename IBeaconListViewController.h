//
//  IBeaconListViewController.h
//  iHotel
//
//  Created by HTC on 4/4/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBeaconListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 
@property (nonatomic, strong) IBOutlet UITableView *tableView;

+ (void) setIBeacon:(NSArray *) newBeacons;
@end
