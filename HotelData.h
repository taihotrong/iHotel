//
//  HotelData.h
//  iHotel
//
//  Created by HTC on 4/1/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HotelData : NSObject {
}
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (void) initData:(NSDictionary*) listHotel withUIImageView:(UIImageView *) imageView;
/*
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
 */
+ (void) initData:(NSMutableArray *) fullListHotel;
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
