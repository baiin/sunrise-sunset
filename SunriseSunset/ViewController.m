//
//  ViewController.m
//  SunriseSunset
//
//  Created by Rj on 4/23/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong) DBManager *thisManager;
@property (strong) NSDate *date;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myData = [Data sharedData];

    self.date = [NSDate date];
    
    self.thisManager = [[DBManager alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if([self.locationManager respondsToSelector: @selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    [self.locationManager startUpdatingLocation];
    
    self.locationNameLabel.text = @"";
    self.duskTimeLabel.text = @"";
    self.sunriseTimeLabel.text = @"";
    self.sunsetTimeLabel.text = @"";
    self.dawnTimeLabel.text = @"";
    
    [self.drawView setNeedsDisplay];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.recentCitiesTableView reloadData];
    
    if([self.myData.city.name isEqualToString: @""])
    {
        // nothing to display
    }
    else
    {
        EDSunriseSet *riseset = [[EDSunriseSet alloc] initWithDate:self.date timezone:self.myData.city.timeZone latitude:[self.myData.city.latitude doubleValue] longitude:[self.myData.city.longitude doubleValue]];
        
        self.locationNameLabel.text = [NSString stringWithFormat: @"%@, %@", self.myData.city.name, self.myData.city.state];
        
        [self updateLabelsWithRiseSet: riseset];

        self.drawView.riseset = riseset;
        
        [self.drawView setNeedsDisplay];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) adjustMilitaryTime: (NSInteger)militaryTime
{
    if(militaryTime > 12)
    {
        return militaryTime - 12;
    }
    else
    {
        return militaryTime;
    }
}

- (NSString*) isAMorPM: (NSInteger)hour
{
    if(hour < 12)
    {
        return @"AM";
    }
    else
    {
        return @"PM";
    }
}

- (NSString*) createStringFromMinute: (NSInteger)minute
{
    if(minute < 10)
    {
        return [NSString stringWithFormat: @"0%ld", minute];
    }
    else
    {
        return [NSString stringWithFormat: @"%ld", minute];
    }
}

- (void) updateLabelsWithRiseSet: (EDSunriseSet*) riseset;
{
    NSInteger duskHour = [self adjustMilitaryTime:riseset.localCivilTwilightStart.hour];
    NSString *duskMin = [self createStringFromMinute:riseset.localCivilTwilightStart.minute];
    NSString *duskPhase = [self isAMorPM:riseset.localCivilTwilightStart.hour];
    
    NSInteger sunriseHour = [self adjustMilitaryTime:riseset.localSunrise.hour];
    NSString *sunriseMin = [self createStringFromMinute: riseset.localSunrise.minute];
    NSString *sunrisePhase = [self isAMorPM:riseset.localSunrise.hour];
    
    NSInteger sunsetHour = [self adjustMilitaryTime:riseset.localSunset.hour];
    NSString *sunsetMin = [self createStringFromMinute:riseset.localSunset.minute];
    NSString *sunsetPhase = [self isAMorPM:riseset.localSunset.hour];
    
    NSInteger dawnHour = [self adjustMilitaryTime:riseset.localCivilTwilightEnd.hour];
    NSString *dawnMin = [self createStringFromMinute:riseset.localCivilTwilightEnd.minute];
    NSString *dawnPhase = [self isAMorPM:riseset.localCivilTwilightEnd.hour];
    
    self.duskTimeLabel.text = [NSString stringWithFormat: @"%ld:%@ %@", duskHour, duskMin, duskPhase];
    self.sunriseTimeLabel.text = [NSString stringWithFormat: @"%ld:%@ %@", sunriseHour, sunriseMin, sunrisePhase];
    self.sunsetTimeLabel.text = [NSString stringWithFormat: @"%ld:%@ %@", sunsetHour, sunsetMin, sunsetPhase];
    self.dawnTimeLabel.text = [NSString stringWithFormat: @"%ld:%@ %@", dawnHour, dawnMin, dawnPhase];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //NSLog(@"location updated");
    self.location = locations.lastObject;
}

- (IBAction)gpsPressed:(id)sender
{    
    NSTimeZone *myTimeZone = [[NSTimeZone alloc] initWithName:@"Pacific"];
    
    EDSunriseSet *riseset = [[EDSunriseSet alloc] initWithDate:self.date timezone:myTimeZone latitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude];
   
    self.locationNameLabel.text = [NSString stringWithFormat: @"My Position: %.2f, %.2f", self.location.coordinate.latitude, self.location.coordinate.longitude];
    
    [self updateLabelsWithRiseSet:riseset];
    
    self.drawView.riseset = riseset;
    
    [self.drawView setNeedsDisplay];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myData.recentCities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recentCityCell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"optionCell"];
    }
    
    City *thisCity = [self.myData.recentCities objectAtIndex: indexPath.row];
    
    cell.textLabel.text = thisCity.name;
    cell.detailTextLabel.text = thisCity.state;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.myData.city = [self.myData.recentCities objectAtIndex: indexPath.row];
    
    [self viewWillAppear:YES];
}

@end
