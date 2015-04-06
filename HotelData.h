//
//  HotelData.h
//  iHotel
//
//  Created by HTC on 4/1/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface HotelData : NSObject {
//    NSArray *hNames = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich",nil];
}
+ (void) initData:(NSDictionary*) listHotel;
+ (NSMutableArray*) getArrayName;
+ (NSArray*) getID;
+ (NSArray*) getNames;
+ (NSArray*) getAddresses;
+ (NSArray*) getImages;
+ (NSArray*) getRating;
+ (NSArray*) getRatingNum;
+ (NSArray*) getDistance;
+ (NSArray*) getPrice;
+ (NSArray*) getPhone;

@end
