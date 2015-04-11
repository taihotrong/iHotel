//
//  BookingViewController.h
//  iHotel
//
//  Created by HTC on 4/4/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelData.h"
#import "AFNetworking.h"

@interface BookingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *hotelNameLB;
@property (weak, nonatomic) IBOutlet UILabel *roomTypeLB;
@property (weak, nonatomic) IBOutlet UITextField *roomsTF;
@property (weak, nonatomic) IBOutlet UITextField *adultsTF;
@property (weak, nonatomic) IBOutlet UITextField *childrenTF;
@property (weak, nonatomic) IBOutlet UIButton *startBT;
@property (weak, nonatomic) IBOutlet UIButton *endBT;

@property (weak, nonatomic) IBOutlet UILabel *roomChargeLB;
@property (weak, nonatomic) IBOutlet UILabel *addFeeLB;
@property (weak, nonatomic) IBOutlet UILabel *totalLB;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UIButton *bookingBT;

@property int indexHotel;
@end
