//
//  HotelData.m
//  iHotel
//
//  Created by HTC on 4/1/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import "HotelData.h"
#import <stdlib.h>

@implementation HotelData

NSMutableArray *hid;
NSMutableArray *hImagesURL;
NSMutableArray *hImages;
NSMutableArray *hAddresses;
NSMutableArray *hListImages;
NSMutableArray *hPhone;
NSMutableArray *hNames;
NSMutableArray *hRating;
NSMutableArray *hRatingNum;
NSMutableArray *hDistance;
NSMutableArray *hPrice;
NSMutableArray *curNameRow;
NSMutableArray *arrayName;
NSMutableArray *curImageRow;
NSMutableArray *arrayImage;
NSDictionary* listHotel;

+ (void) initData:(NSDictionary*) listHotel {
    NSArray *a = listHotel[@"listHotels"];
    hid= [[NSMutableArray alloc] init];
    hImagesURL= [[NSMutableArray alloc] init];
    hImages= [[NSMutableArray alloc] init];
    hAddresses= [[NSMutableArray alloc] init];
    hListImages= [[NSMutableArray alloc] init];
    hPhone= [[NSMutableArray alloc] init];
    hNames= [[NSMutableArray alloc] init];
    hRating= [[NSMutableArray alloc] init];
    hRatingNum= [[NSMutableArray alloc] init];
    hDistance= [[NSMutableArray alloc] init];
    hPrice= [[NSMutableArray alloc] init];
    NSDictionary *b;
    
    NSString *ImageURL = @"YourURLHere";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
//    imageView.image = [UIImage imageWithData:imageData];
    for (int i = 0; i < [a count]; i ++) {
        b = a[i];
        [hid addObject:b[@"id"]];
        [hImagesURL addObject:b[@"thumb"]];
        ImageURL = b[@"thumb"];
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        [hImages addObject:[UIImage imageWithData:imageData]];
        
        [hAddresses addObject:b[@"address"]];
        [hListImages addObject:b[@"list_image_name"]];
        [hPhone addObject:b[@"phone_number"]];
        [hNames addObject:b[@"name"]];
        [hRating addObject:b[@"rate"]];
        [hPrice addObject:b[@"price"]];
        
        // Add-in info
        NSInteger temp = arc4random_uniform(1000);
        [hRatingNum addObject:[NSNumber numberWithInteger:temp]];
        [hDistance addObject:[[NSString alloc] initWithFormat:@"%.01f km",(float) rand() / RAND_MAX * 10]];
    }
}

+ (NSMutableArray*) getArrayName {
    return arrayName;
}
+ (NSArray*) getID {
    return hid;
}
+ (NSArray*) getNames {
    return hNames;
}
+ (NSArray*) getAddresses {
    return hAddresses;
}
+ (NSArray*) getImagesURL {
    return hImagesURL;
}
+ (NSArray*) getImages {
    return hImages;
}
+ (NSArray*) getRating {
    return hRating;
}
+ (NSArray*) getRatingNum {
    return hRatingNum;
}
+ (NSArray*) getDistance {
    return hDistance;
}
+ (NSArray*) getPrice {
    return hPrice;
}
+ (NSArray*) getPhone {
    return hPhone;
}

@end
