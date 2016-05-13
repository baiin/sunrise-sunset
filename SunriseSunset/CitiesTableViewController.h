//
//  CitiesTableViewController.h
//  SunriseSunset
//
//  Created by Rj on 5/3/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "City.h"
#import "Data.h"

@interface CitiesTableViewController : UITableViewController

@property (strong) DBManager *thisManager;
@property (strong) NSMutableArray *options;

@property (strong) NSString *stateSelected;
@property (strong) City *citySelected;

@property (strong) Data *myData;

@end
