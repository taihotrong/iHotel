//
//  DetailCellMap.h
//  iHotel
//
//  Created by HTC on 4/1/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCellMap : UITableViewCell
@property (strong, nonatomic) IBOutlet DetailCellMap *detailCellMap;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@end
