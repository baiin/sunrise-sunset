//
//  CitiesTableViewController.m
//  SunriseSunset
//
//  Created by Rj on 5/3/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import "CitiesTableViewController.h"

@interface CitiesTableViewController ()

@end

@implementation CitiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myData = [Data sharedData];
    
    self.thisManager = [[DBManager alloc] init];
    self.options = [[NSMutableArray alloc] init];
    
    NSArray *states = @[@"AL", @"AK", @"AZ", @"AR", @"CA", @"CO", @"CT", @"DE",@"FL",
                        @"GA",@"HI", @"ID", @"IL", @"IN", @"IA", @"KS", @"KY", @"LA",
                        @"ME", @"MD", @"MA", @"MI", @"MN", @"MS",@"MO", @"MT", @"NE",
                        @"NV", @"NH", @"NJ", @"NM", @"NY",@"NC", @"ND", @"OH", @"OK",
                        @"OR", @"PA",@"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VT",
                        @"VA", @"WA", @"WV", @"WI", @"WY"];
    
    self.options = [NSMutableArray arrayWithArray: states];
    
    self.stateSelected = @"";
    self.citySelected = [[City alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionCell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"optionCell"];
    }
    
    if([self.stateSelected isEqualToString: @""])
    {
        cell.textLabel.text = [self.options objectAtIndex: indexPath.row];
    }
    else
    {
        City *thisCity = [self.options objectAtIndex: indexPath.row];
        
        cell.textLabel.text = thisCity.name;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // state was not selected yet
    if([self.stateSelected isEqualToString: @""])
    {
        // clear options
        self.options = [[NSMutableArray alloc] init];
        
        self.stateSelected = cell.textLabel.text;
        
        // get all cities and store in options
        NSMutableArray *cities = [[NSMutableArray alloc] init];
        cities = [NSMutableArray arrayWithArray: [self.thisManager getAllFromState:self.stateSelected]];
        
        NSLog(@"num cities: %ld", [cities count]);
        
        self.options = cities;
        
        [tableView reloadData];
    }
    else
    {
        self.citySelected = [self.options objectAtIndex: indexPath.row];
        NSLog(@"city selected: %@", self.citySelected.name);
        self.myData.city = self.citySelected;
        
        // add to recent cities list
        [self.myData.recentCities addObject: self.citySelected];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
