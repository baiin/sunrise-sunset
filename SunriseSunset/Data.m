//
//  Data.m
//  SunriseSunset
//
//  Created by Rj on 5/8/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import "Data.h"

@implementation Data

+ (id) sharedData
{
    static Data *shared = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{shared = [[self alloc] init];});
    
    return shared;
}

- (Data*) init
{
    self = [super init];
    
    if(self)
    {
        self.city = [[City alloc] init];
        self.city.name = [[NSString alloc]init];
        self.city.state = [[NSString alloc] init];
        
        self.recentCities = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
