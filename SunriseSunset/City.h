//
//  City.h
//  sqliteTest
//
//  Created by Rj on 4/12/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *state;
@property (nonatomic) NSNumber *longitude;
@property (nonatomic) NSNumber *latitude;
@property (nonatomic) NSTimeZone *timeZone;

- (City*) initWithName: (NSString*) aName state: (NSString*) aState longitude: (NSNumber*) aLongitutde latitude: (NSNumber*) aLatitude timeZone: (NSTimeZone*) aTimeZone;

@end
