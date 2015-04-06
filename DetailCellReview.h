//
//  DetailCellReview.h
//  iHotel
//
//  Created by HTC on 4/1/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCellReview : UITableViewCell
@property (strong, nonatomic) IBOutlet DetailCellReview *detailCellReview;
@property (weak, nonatomic) IBOutlet UIButton *reviewButton;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *ratingNum;

@end
