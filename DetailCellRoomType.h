//
//  DetailCellRoomType.h
//  iHotel
//
//  Created by HTC on 4/1/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCellRoomType : UITableViewCell
@property (strong, nonatomic) IBOutlet DetailCellRoomType *detailCellRoomType;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *benefitLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookingButton;

@end
