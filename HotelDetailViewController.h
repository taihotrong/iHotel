//
//  HotelDetailViewController.h
//  iHotel
//
//  Created by HTC on 3/30/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailCellInfo.h"
#import "DetailCellPhoto.h"
#import "DetailCellMap.h"
#import "DetailCellReview.h"
#import "DetailCellRoomTypeLabel.h"
#import "DetailCellRoomType.h"
#import "HotelData.h"
#import "BookingViewController.h"

@interface HotelDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    DetailCellInfo *detailCellInfo;
    DetailCellPhoto *detailCellPhoto;
    DetailCellMap *detailCellMap;
    DetailCellReview *detailCellReview;
    DetailCellRoomTypeLabel *detailCellRoomTypeLabel;
    DetailCellRoomType *detailCellRoomType;

}

@property int indexHotel;
@property (nonatomic, strong) IBOutlet UITableView *tableViews;
@end
