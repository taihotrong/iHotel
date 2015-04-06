//
//  BookingViewController.m
//  iHotel
//
//  Created by HTC on 4/4/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import "BookingViewController.h"

@interface BookingViewController ()

@end

NSString* hotelName;
NSString* roomType;
NSNumber* hotelID;
NSString* startDate;
NSString* endDate;
NSNumber* baseRoomCharge;
int fullRoomCharge;
int addFee;
int totalFee;
NSString* firstName;
NSString* lastName;
NSString* email;
NSString* phone;

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getDataToView];
}

- (void) getDataToView {
    hotelName = [HotelData getNames][self.indexHotel];
    roomType = @"Superior";
    hotelID = [HotelData getID][self.indexHotel];
    baseRoomCharge = [HotelData getPrice][self.indexHotel];
}

- (void) setDataToView {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
