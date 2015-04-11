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
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

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

+ (void) initData:(NSDictionary*) listHotel withUIImageView:(UIImageView *) imageView{
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
    
    NSString *imageURL = @"YourURLHere";

    for (int i = 0; i < [a count]; i ++) {
        b = a[i];
        [hid addObject:b[@"id"]];
        [hImagesURL addObject:b[@"thumb"]];
        imageURL = b[@"thumb"];
//        NSArray *tmps = [imageURL componentsSeparatedByString:@","];
//        NSString *imageName = tmps[[tmps count] - 1];
        
        [hImages addObject:[UIImage imageNamed:@"ic_action_picture"]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
                UIImage *image = [UIImage imageWithData:imageData];
                [hImages replaceObjectAtIndex:i withObject:image];
                imageView.image = [hImages objectAtIndex:i];
                NSLog(@"Image %d",i);
            });
        });
        
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
        
        NSLog(@"Data %d",i);
    }
}

//[fullArray addObject:hid];
//[fullArray addObject:hImagesURL];
//[fullArray addObject:hImages];
//[fullArray addObject:hAddresses];
//[fullArray addObject:hListImages];
//[fullArray addObject:hPhone];
//[fullArray addObject:hNames];
//[fullArray addObject:hRating];
//[fullArray addObject:hRatingNum];
//[fullArray addObject:hDistance];
//[fullArray addObject:hPrice];

+ (void) initData:(NSMutableArray *)fullListHotel {
    hid = [fullListHotel objectAtIndex:0];
    hImagesURL = [fullListHotel objectAtIndex:1];
    hImages = [fullListHotel objectAtIndex:2];
    hAddresses = [fullListHotel objectAtIndex:3];
    hListImages = [fullListHotel objectAtIndex:4];
    hPhone = [fullListHotel objectAtIndex:5];
    hNames = [fullListHotel objectAtIndex:6];
    hRating = [fullListHotel objectAtIndex:7];
    hRatingNum = [fullListHotel objectAtIndex:8];
    hDistance = [fullListHotel objectAtIndex:9];
    hPrice = [fullListHotel objectAtIndex:10];
}

+ (void) saveImage:(UIImage *)image withFileName:(NSString *)fileName inDirectory:(NSString *)directoryPath {
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]] options:NSAtomicWrite error:nil];
    
//    if ([[extension lowercaseString] isEqualToString:@"png"]) {
//        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
//    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
//        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
//    } else {
//        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
//    }
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

/**************************************************************************************************************
 *  CORE DATA ZONE
 *
 ***************************************************************************************************************/
- (void)saveContext:(NSString *) URLString
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModelName" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ProjectName.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
