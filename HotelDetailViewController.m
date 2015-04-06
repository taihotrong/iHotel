//
//  HotelDetailViewController.m
//  iHotel
//
//  Created by HTC on 3/30/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import "HotelDetailViewController.h"

@implementation HotelDetailViewController
@synthesize indexHotel;
NSArray *hNames;
NSArray *hAddresses;
NSArray *hImagesURL;
NSArray *hImages;
NSArray *hRating;
NSArray *hRatingNum;
NSArray *hDistance;
NSArray *hPrice;
NSArray *hPhone;

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"index = %d",indexHotel);
    self.tableViews.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableViews.bounds.size.width, 0.01f)];
    self.tableViews.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableViews.bounds.size.width, 0.01f)];
}

- (void) getDataToListView {
    NSLog(@"getDataToListView");
    hNames = [HotelData getNames];
    hAddresses = [HotelData getAddresses];
    hImagesURL = [HotelData getImages];
    hRating = [HotelData getRating];
    hRatingNum = [HotelData getRatingNum];
    hDistance = [HotelData getDistance];
    hPrice = [HotelData getPrice];
    hPhone = [HotelData getPhone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    int feedIndex = [indexPath indexAtPosition:[indexPath length] - 1];
    static NSString *simpleTableIdentifier1 = @"DetailCell";
    if(feedIndex == 0) {
        DetailCellInfo *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier1];
        
        if (cell == nil) {
            //cell = [[DetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier1];
            [[NSBundle mainBundle] loadNibNamed:@"DetailCellInfo" owner:self options:nil];
            
            cell = detailCellInfo;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.nameLabel.text = [hNames objectAtIndex:indexHotel];
        cell.addressLabel.text = [hAddresses objectAtIndex:indexHotel];
        cell.phoneLabel.text = [hPhone objectAtIndex:indexHotel];
        return cell;
    }
    else if(feedIndex == 1) {
        DetailCellPhoto *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier1];
        
        if (cell == nil) {
            //cell = [[DetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier1];
            [[NSBundle mainBundle] loadNibNamed:@"DetailCellPhoto" owner:self options:nil];
            
            cell = detailCellPhoto;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.imageView2.image = [hImages objectAtIndex:indexHotel];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@",[hPrice objectAtIndex:indexHotel]];
        cell.morePhotoButton.tag = indexPath.row;
        [cell.morePhotoButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        return cell;
    }
    else if(feedIndex == 2) {
        DetailCellReview *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier1];
        
        if (cell == nil) {
            //cell = [[DetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier1];
            [[NSBundle mainBundle] loadNibNamed:@"DetailCellReview" owner:self options:nil];
            
            cell = detailCellReview;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.rating.text = [NSString stringWithFormat:@"%@.0", [hRating objectAtIndex:indexHotel]];
        cell.ratingNum.text = [NSString stringWithFormat:@"%@", [hRatingNum objectAtIndex:indexHotel]];
        return cell;
    }
    else if(feedIndex == 3) {
        DetailCellMap *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier1];
        
        if (cell == nil) {
            //cell = [[DetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier1];
            [[NSBundle mainBundle] loadNibNamed:@"DetailCellMap" owner:self options:nil];
            
            cell = detailCellMap;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.distance.text = [hDistance objectAtIndex:indexHotel];
        return cell;
    }
    else if(feedIndex == 4) {
        DetailCellRoomTypeLabel *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier1];
        
        if (cell == nil) {
            //cell = [[DetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier1];
            [[NSBundle mainBundle] loadNibNamed:@"DetailCellRoomTypeLabel" owner:self options:nil];
            
            cell = detailCellRoomTypeLabel;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    else {
        DetailCellRoomType *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier1];
        
        if (cell == nil) {
            //cell = [[DetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier1];
            [[NSBundle mainBundle] loadNibNamed:@"DetailCellRoomType" owner:self options:nil];
            
            cell = detailCellRoomType;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.nameLabel.text = @"Superior";
        cell.benefitLabel.text = @"breakfast included";
        cell.imageView3.image = [hImages objectAtIndex:indexHotel];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@",[hPrice objectAtIndex:indexHotel]];
        cell.bookingButton.tag = indexPath.row;
        [cell.bookingButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    int index = indexPath.row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)
    {
        return 60.0f;
    }
    else if(indexPath.row == 1)
    {
        return 100.0f;
    }
    else if(indexPath.row <= 3)
    {
        return 50.0f;
    }
    else if(indexPath.row == 4)
    {
        return 30.0f;
    }
    else
    {
        return 150.0f;
    }
}

-(void)buttonClick:(UIButton*)sender
{
    // more Photo button
    if (sender.tag == 1)
    {
        NSLog(@"Photo click hotel %d", indexHotel);
    }
    // booking button click
    else if (sender.tag == 5)
    {
        NSLog(@"Booking click hotel %d", indexHotel);
        [self performSegueWithIdentifier: @"bookingSegue" sender: self];
    }
}

//  Click on booking Button
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"bookingSegue"]) {
        BookingViewController *destViewController = segue.destinationViewController;
        destViewController.indexHotel = indexHotel;
    }
}

@end
