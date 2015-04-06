//
//  ViewController.h
//  iHotel
//
//  Created by HTC on 3/30/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface HotelListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

@property (nonatomic, strong) IBOutlet UITableView *tableViews;

@end

