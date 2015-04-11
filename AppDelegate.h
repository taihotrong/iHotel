//
//  AppDelegate.h
//  iHotel
//
//  Created by HTC on 3/30/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class HotelListViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) HotelListViewController *viewController;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property CLProximity lastProximity;

- (void)sendLocalNotificationWithMessage:(NSString*)message;

@end

