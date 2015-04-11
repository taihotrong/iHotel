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
NSArray *hImages;
NSArray *hRating;
NSArray *hRatingNum;
NSArray *hDistance;
NSArray *hPrice;
NSArray *hPhone;

static NSString * const getListHotelURL = @"http://ibeacon.itlabs4u.com/ApiProtocol/GetListHotels?page_size=1&page_num=20";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableViews.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableViews.bounds.size.width, 0.01f)];
    self.tableViews.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableViews.bounds.size.width, 0.01f)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void) applicationBecomeActive {
    [self getListHotel];
}

- (void) getDataToListView {
    NSLog(@"getDataToListView");
    hNames = [HotelData getNames];
    hAddresses = [HotelData getAddresses];
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
    [SVProgressHUD showWithStatus:@"Loading data ..."];
    NSString *string = getListHotelURL;
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setListHotelData:responseObject];
        [self getDataToListView];
        [self.tableViews reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
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

NSMutableArray *fullArray;
- (void) setListHotelData:(NSDictionary *) listHotelData {
    NSArray *a = listHotelData[@"listHotels"];
    NSMutableArray *hid= [[NSMutableArray alloc] init];
    NSMutableArray *hImagesURL= [[NSMutableArray alloc] init];
    NSMutableArray *hImages= [[NSMutableArray alloc] init];
    NSMutableArray *hAddresses= [[NSMutableArray alloc] init];
    NSMutableArray *hListImages= [[NSMutableArray alloc] init];
    NSMutableArray *hPhone= [[NSMutableArray alloc] init];
    NSMutableArray *hNames= [[NSMutableArray alloc] init];
    NSMutableArray *hRating= [[NSMutableArray alloc] init];
    NSMutableArray *hRatingNum= [[NSMutableArray alloc] init];
    NSMutableArray *hDistance= [[NSMutableArray alloc] init];
    NSMutableArray *hPrice= [[NSMutableArray alloc] init];
    NSDictionary *b;
    fullArray = [[NSMutableArray alloc] init];
    NSString *imageURL = @"YourURLHere";
    
    // 1
    for (int i = 0; i < [a count]; i ++) {
        b = a[i];
        [hid addObject:b[@"id"]];
        [hImagesURL addObject:b[@"thumb"]];
        imageURL = b[@"thumb"];
        [hImages addObject:[UIImage imageNamed:@"ic_action_picture"]];
        [self isExistImage:imageURL index:i imageArray:hImages];
        
        [hAddresses addObject:b[@"address"]];
        [hListImages addObject:b[@"list_image_name"]];
        [hPhone addObject:b[@"phone_number"]];
        [hNames addObject:b[@"name"]];
        [hRating addObject:b[@"rate"]];
        [hPrice addObject:b[@"price"]];
        
        // Add-in info
        NSInteger temp = arc4random_uniform(1000);
        [hRatingNum addObject:[NSNumber numberWithInteger:temp]];
        [hDistance addObject:[[NSString alloc] initWithFormat:@"%.01f km",(float) rand() / RAND_MAX * 10]];
        
        NSLog(@"Data %d",i);
    }
    
    //2
    [fullArray addObject:hid];
    [fullArray addObject:hImagesURL];
    [fullArray addObject:hImages];
    [fullArray addObject:hAddresses];
    [fullArray addObject:hListImages];
    [fullArray addObject:hPhone];
    [fullArray addObject:hNames];
    [fullArray addObject:hRating];
    [fullArray addObject:hRatingNum];
    [fullArray addObject:hDistance];
    [fullArray addObject:hPrice];
    
    [HotelData initData:fullArray];
}

- (BOOL) isExistImage: (NSString *) imageURL index:(int) index imageArray:(NSMutableArray *) hImages {
    NSArray *tmps = [imageURL componentsSeparatedByString:@"/"];
    NSString *imageName = tmps[[tmps count] - 1];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithString: imageName] ];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    
    // image is exist in local directory
    if (fileExists) {
        NSLog(@"Load image from local dir: %@", path);
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [hImages replaceObjectAtIndex:index withObject:image];
        return true;
    }
    
    // new image
    else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            UIImage *image = [UIImage imageWithData:imageData];
            [imageData writeToFile:path atomically:YES];
            NSLog(@"Load image from URL & save to dir: %@", path);
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                [hImages replaceObjectAtIndex:index withObject:image];
                [fullArray replaceObjectAtIndex:2 withObject:hImages];
                [self getDataToListView];
                [self.tableViews reloadData];
            });
        });
    }
    return false;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"numberOfRowsInSection, count = %d", [hNames count]);
    return [hNames count];
}

HotelCell *cell;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"HotelCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
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
        destViewController.indexHotel = (int) indexPath.row;
    }
}

@end
