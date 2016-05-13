//
//  Data.h
//  SunriseSunset
//
//  Created by Rj on 5/8/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

@interface Data : NSObject

@property (strong) City *city;
@property (strong) NSMutableArray *recentCities;

+ (id) sharedData;

@end
