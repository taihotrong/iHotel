//
//  ViewController.m
//  iHotel
//
//  Created by HTC on 3/30/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import "HotelListViewController.h"
#import "HotelCell.h"
#import "HotelDetailViewController.h"
#import "HotelData.h"

@interface HotelListViewController ()

@end

@implementation HotelListViewController

NSArray *hNames;
NSArray *hAddresses;
NSArray *hImagesURL;
NSArray *hImages;
NSArray *hRating;
NSArray *hRatingNum;
NSArray *hDistance;
NSArray *hPrice;
NSArray *hPhone;
//@synthesize tableViews;
static NSString * const getListHotelURL = @"http://ibeacon.itlabs4u.com/ApiProtocol/GetListHotels?page_size=1&page_num=20";
NSDictionary* listHotel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getListHotel];
//    tableViews.contentInset = UIEdgeInsetsZero;
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

- (void)getListHotel {
    NSString *string = getListHotelURL;
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        listHotel = (NSDictionary *)responseObject;
        [HotelData initData:listHotel];
        [self getDataToListView];
        [self.tableViews reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Hotel Detail"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"numberOfRowsInSection, count = %d", [hNames count]);
    return [hNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"HotelCell";
    
    HotelCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[HotelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.nameLabel.text = [hNames objectAtIndex:indexPath.row];
    cell.addressLabel.text = [hAddresses objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image = [hImages objectAtIndex:indexPath.row];
    cell.ratingLabel.text = [NSString stringWithFormat:@"%@.0", [hRating objectAtIndex:indexPath.row]];
    cell.ratingNumLabel.text = [NSString stringWithFormat:@"%@", [hRatingNum objectAtIndex:indexPath.row]];
    cell.distanceLabel.text = [hDistance objectAtIndex:indexPath.row];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@",[hPrice objectAtIndex:indexPath.row]];
    cell.phoneLabel.text = [hPhone objectAtIndex:indexPath.row];
    
    return cell;
}

//  Click on hotel Cell
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showHotelDetail"]) {
        NSIndexPath *indexPath = [self.tableViews indexPathForSelectedRow];
        HotelDetailViewController *destViewController = segue.destinationViewController;
        destViewController.indexHotel = indexPath.row;
    }
}

@end
