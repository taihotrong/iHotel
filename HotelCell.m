//
//  HotelTableCell.m
//  iHotel
//
//  Created by HTC on 3/30/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import "HotelCell.h"

@implementation HotelCell

@synthesize nameLabel = _nameLabel;
@synthesize addressLabel = _addressLabel;
@synthesize thumbnailImageView = _thumbnailImageView;
@synthesize ratingLabel = _ratingLabel;
@synthesize ratingNumLabel = _ratingNumLabel;
@synthesize distanceLabel = _distanceLabel;
@synthesize priceLabel = _priceLabel;
@synthesize phoneLabel = _phoneLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
