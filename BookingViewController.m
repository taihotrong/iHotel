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

@implementation BookingViewController

NSString* hotelName;
NSString* roomType;
NSNumber* hotelID;
NSDate* startDate;
NSDate* endDate;
NSDate* today;

int baseRoomCharge;
int fullRoomCharge;
int addFee;
int totalFee;
int rooms;
int adults;
int childrens;

NSString* firstName;
NSString* lastName;
NSString* email;
NSString* phone;

NSDateFormatter* dateFormat;
NSCalendar *gregorianCalendar;
NSDateComponents *components;

UIAlertView* alert;
NSString* errorString;


typedef enum {
    START,
    END,
    BOOKING
} Button;

typedef enum {
    ROOMS,
    ADULTS,
    CHILDRENS
} TextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getDataToView];
    [self setDataToView];
    [self initBookingDetails];
    [self initViewComponents];
    [self calculateBookingFee];
}

- (void) initViewComponents {
    [self.startBT setTitle:[dateFormat stringFromDate:startDate] forState:UIControlStateNormal];
    [self.endBT setTitle:[dateFormat stringFromDate:endDate] forState:UIControlStateNormal];
    
    self.startBT.tag = START;
    self.endBT.tag = END;
    self.bookingBT.tag = BOOKING;
    [self.startBT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.endBT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.bookingBT addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    self.roomsTF.tag = ROOMS;
    self.adultsTF.tag = ADULTS;
    self.childrenTF.tag = CHILDRENS;
    [self.roomsTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.childrenTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.adultsTF.enabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    alert = [[UIAlertView alloc] initWithTitle:@"Wrong Info"
                                       message:@"You must be connected to the internet to use this app."
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    rooms =  [self.roomsTF.text intValue];
    childrens = [self.childrenTF.text intValue];
    [self calculateBookingFee];
}

-(void)dismissKeyboard {
    [self.roomsTF resignFirstResponder];
    [self.childrenTF resignFirstResponder];
    [self.firstNameTF resignFirstResponder];
    [self.lastNameTF resignFirstResponder];
    [self.emailTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
}

- (void) initBookingDetails {
    fullRoomCharge = (int) baseRoomCharge;
    rooms = 1;
    adults = 2;
    childrens = 0;
    addFee = 0;
    totalFee = fullRoomCharge + addFee;
    dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MM/YYYY HH:mm:ss"];
    
    startDate = [NSDate date];
    today = startDate;
    endDate = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:startDate];
}

- (void) getDataToView {
    hotelName = [HotelData getNames][self.indexHotel];
    roomType = @"Superior";
    hotelID = [HotelData getID][self.indexHotel];
    NSNumber* baseRoom = [HotelData getPrice][self.indexHotel];
    baseRoomCharge = [baseRoom integerValue];
}

- (void) setDataToView {
    self.hotelNameLB.text = hotelName;
    self.roomTypeLB.text = roomType;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonClick:(UIButton*)sender
{
    switch (sender.tag) {
        case START:
        case END:
            [self showDatePicker:sender];
            break;
        case BOOKING:
            [self bookingHotel];
            break;
        default:
            break;
    }
}

NSDictionary* resultDict;
NSDictionary* resultInfo;
NSString* alertTitle;
NSString* alertMessage;
- (void)bookingHotel {
    if ([self isValidBooking]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMYYYYHHmmss"];
        NSString *startTimeString = [dateFormatter stringFromDate:startDate];
        NSString *endTimeString = [dateFormatter stringFromDate:endDate];
        firstName = self.firstNameTF.text;
        lastName = self.lastNameTF.text;
        phone = self.phoneTF.text;
        
        NSDictionary *params = @{@"hotel_id": hotelID,
                                 @"str_start_time": startTimeString,
                                 @"str_end_time": endTimeString,
                                 @"first_name": firstName,
                                 @"last_name": lastName,
                                 @"customer_phone_number": phone,
                                 };
        [manager POST:@"http://ibeacon.itlabs4u.com/ApiProtocol/bookHotelPost" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            resultInfo = responseObject[@"Info"];
            NSString* result = responseObject[@"status"];
            NSLog(@"phone = %@, result = %@", phone, result);
            if ([result isEqual:@"success"]) {
                alertTitle = @"Booking success !";
                alertMessage = [NSString stringWithFormat:@"Your booking code is %@",resultInfo[@"ordertbl_code"]];
                [self writeOrderCodeToFile:resultInfo[@"ordertbl_code"]];
            }
            else {
                alertTitle = @"Booking failed !";
                alertMessage = responseObject[@"message"];
            }
            [self showAlertView:alert titleString:alertTitle messageString:alertMessage];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            alertTitle = @"Booking failed !";
            alertMessage = [NSString stringWithFormat:@"%@", error];
            [self showAlertView:alert titleString:alertTitle messageString:alertMessage];
        }];
    }
    else {
        alertTitle = @"Booking failed";
        alertMessage = errorString;
        [self showAlertView:alert titleString:alertTitle messageString:alertMessage];
    }
}

- (void) writeOrderCodeToFile: (NSString *) orderCode {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentTXTPath = [documentsDirectory stringByAppendingPathComponent:@"ordercodes.txt"];
    NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:documentTXTPath];
    [myHandle seekToEndOfFile];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:documentTXTPath];
    
    NSString *tmp = [NSString stringWithFormat:@",%@",orderCode];
    // firstOrdercode
    if (fileExists) {
        tmp = orderCode;
    }
    [myHandle writeData:[orderCode dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void) showAlertView:(UIAlertView*) alertView titleString: (NSString*) title messageString: (NSString*) message {
    [alertView setTitle:title];
    [alertView setMessage:message];
    [alertView show];
}

- (bool)isValidBooking {
    if (fullRoomCharge <= 0) {
        errorString = @"Check booking details";
        return false;
    }
    else if ([self.firstNameTF.text isEqual: @""]) {
        errorString = @"First name is null";
        return false;
    }
    else if ([self.lastNameTF.text isEqual: @""]) {
        errorString = @"Last name is null";
        return false;
    }
    else if ([self.phoneTF.text isEqual: @""]) {
        errorString = @"Phone is null";
        return false;
    }
    return true;
}

- (void)showDatePicker:(UIButton *)sender {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:textField];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle   = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *itemDone  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:textField action:@selector(resignFirstResponder)];
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = @[itemSpace,itemDone];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    datePicker.minimumDate   = [NSDate date];
    datePicker.date          = [NSDate date];
    datePicker.tag = sender.tag;
    [datePicker addTarget:self action:@selector(didChangePickerDate:) forControlEvents:UIControlEventValueChanged];
    
    textField.inputAccessoryView = toolbar;
    textField.inputView          = datePicker;
    
    [textField becomeFirstResponder];
}

-(void) didChangePickerDate:(UIDatePicker *)sender {
    NSDate* datePick = [sender date];
    NSString* datePickString = [dateFormat stringFromDate:datePick];
    switch (sender.tag) {
        case START:
            [self.startBT setTitle:datePickString forState:UIControlStateNormal];
            startDate = datePick;
            break;
        case END:
            [self.endBT setTitle:datePickString forState:UIControlStateNormal];
            endDate = datePick;
            break;
        default:
            break;
    }
    [self calculateBookingFee];
}

- (void) calculateBookingFee {
    gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    int days = [components day];
    bool error = TRUE;
    if (rooms <= 0) {
        errorString = @"Rooms must be equal or greater than 0";
    }
    else if (childrens < 0) {
        errorString = @"Childrens must be equal or greater than 0";
    }
    else if (days < 0) {
        errorString = @"End date must be after start date";
    }
    else {
        error = false;
    }
    if (error) {
        [alert setMessage:errorString];
        [alert show];
    }
    else {
        fullRoomCharge  = baseRoomCharge * rooms * days;
        addFee          = (int) baseRoomCharge * childrens / 2 * days;
        totalFee        = fullRoomCharge + addFee;
        self.roomChargeLB.text = [NSString stringWithFormat:@"%d", fullRoomCharge];
        self.addFeeLB.text = [NSString stringWithFormat:@"%d", addFee];
        self.totalLB.text = [NSString stringWithFormat:@"%d", totalFee];
    }
}

@end
