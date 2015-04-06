//
//  IBeaconListViewController.m
//  iHotel
//
//  Created by HTC on 4/4/15.
//  Copyright (c) 2015 HTC. All rights reserved.
//

#import "IBeaconListViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface IBeaconListViewController ()

@end

@implementation IBeaconListViewController
NSArray* beacons;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section {
    return beacons.count;
}

+ (void) setIBeacon:(NSArray *) newBeacons {
    beacons = newBeacons;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CLBeacon *beacon = (CLBeacon*)[beacons
                                   objectAtIndex:indexPath.row];
    NSString *proximityLabel = @"";
    switch (beacon.proximity) {
        case CLProximityFar:
            proximityLabel = @"Far";
            break;
        case CLProximityNear:
            proximityLabel = @"Near";
            break;
        case CLProximityImmediate:
            proximityLabel = @"Immediate";
            break;
        case CLProximityUnknown:
            proximityLabel = @"Unknown";
            break;
    }
    
    cell.textLabel.text = proximityLabel;
    
    if (beacon.rssi != 0) {
        double distance = [self calculateAccuracy:-62 :beacon.rssi];
        NSString *detailLabel = [NSString
                                 stringWithFormat:
                                 @"Major: %d, Minor: %d, RSSI: %d, accuracy: %f, distance: %f, UUID: %@",
                                 beacon.major.intValue, beacon.minor.intValue,
                                 (int)beacon.rssi, (double) beacon.accuracy, distance, beacon.proximityUUID.UUIDString];
        cell.detailTextLabel.text = detailLabel;
    }
    
    return cell;
}

- (double) calculateAccuracy:(int) txPower: (double) rssi {
    if (rssi == 0) {
        return -1.0; // if we cannot determine accuracy, return -1.
    }
    
    double ratio = rssi*1.0/txPower;
    if (ratio < 1.0) {
        return pow(ratio,10);
    }
    else {
        double accuracy =  (0.89976)* pow(ratio,7.7095) + 0.111;
        return accuracy;
    }
}
@end
