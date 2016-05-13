//
//  ViewController.h
//  SunriseSunset
//
//  Created by Rj on 4/23/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EDSunriseSet/EDSunriseSet.h>
#import <CoreLocation/CoreLocation.h>
#import "DBManager.h"
#import "Draw2D.h"
#import "City.h"
#import "Data.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong) EDSunriseSet *riseset;
@property (strong) Data *myData;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet Draw2D *drawView;
@property (weak, nonatomic) IBOutlet UITableView *recentCitiesTableView;

@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *duskTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dawnTimeLabel;

@end

