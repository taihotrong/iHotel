//
//  DetailCell1.h
//  iHotel
//
//  Created by HTC on 3/31/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCellInfo : UITableViewCell
@property (strong, nonatomic) IBOutlet DetailCellInfo *detailCellInfo;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
