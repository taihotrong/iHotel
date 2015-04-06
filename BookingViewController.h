//
//  BookingViewController.h
//  iHotel
//
//  Created by HTC on 4/4/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelData.h"

@interface BookingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UILabel *roomType;
@property (weak, nonatomic) IBOutlet UITextField *rooms;
@property (weak, nonatomic) IBOutlet UITextField *adults;
@property (weak, nonatomic) IBOutlet UITextField *children;
@property (weak, nonatomic) IBOutlet UITextField *startTF;
@property (weak, nonatomic) IBOutlet UITextField *endTF;
@property (weak, nonatomic) IBOutlet UIButton *changeStartBT;
@property (weak, nonatomic) IBOutlet UIButton *changeEndBT;

@property (weak, nonatomic) IBOutlet UITextField *roomChargeTF;
@property (weak, nonatomic) IBOutlet UITextField *addFeeTF;
@property (weak, nonatomic) IBOutlet UITextField *totalTF;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property int indexHotel;
@end
