//
//  DetailCellPhoto.h
//  iHotel
//
//  Created by HTC on 4/1/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCellPhoto : UITableViewCell
@property (strong, nonatomic) IBOutlet DetailCellPhoto *detailCellPhoto;
@property (nonatomic, weak) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *morePhotoButton;

@end
