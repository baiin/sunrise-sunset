//
//  City.m
//  sqliteTest
//
//  Created by Rj on 4/12/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import "City.h"

@implementation City

@synthesize name;
@synthesize state;
@synthesize longitude;
@synthesize latitude;
@synthesize timeZone;

- (City *)initWithName:(NSString *)aName state:(NSString *)aState longitude:(NSNumber *)aLongitutde latitude:(NSNumber *)aLatitude timeZone:(NSTimeZone *)aTimeZone
{
    self = [super init];
    
    if(self)
    {
        name = aName;
        state = aState;
        longitude = aLongitutde;
        latitude = aLatitude;
        timeZone = aTimeZone;
    }

    return self;
}

@end
