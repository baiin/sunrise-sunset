//
//  DBManager.m
//  sqliteTest
//
//  Created by Rj on 4/12/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

static DBManager *database;

+ (DBManager*)database
{
    if (database == nil)
    {
        database = [[DBManager alloc] init];
    }
    
    return database;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        NSString* dbpath = [[NSBundle mainBundle] pathForResource:@"us_cities_with_timezones" ofType:@"sl3"];
        
        if (sqlite3_open([dbpath UTF8String], &db) != SQLITE_OK)
        {
            NSLog(@"Failed to open database.");
        }
        else
        {
            NSLog(@"Successful Open: %@", dbpath);
        }
    }
    return self;
}

- (NSArray*)getAllCities
{
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat: @"SELECT * FROM cities;"];
    
    NSLog(@"%@", query);
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            char *name = (char*)sqlite3_column_text(statement, 0);
            char *state = (char*)sqlite3_column_text(statement, 1);
            float latitude = (float)sqlite3_column_double(statement, 2);
            float longitude = (float) sqlite3_column_double(statement, 3);
            char *timeZone = (char*)sqlite3_column_text(statement, 4);
            
            NSString *aName = [[NSString alloc] initWithUTF8String: name];
            NSString *aState = [[NSString alloc] initWithUTF8String: state];
            NSNumber *aLatitude = [[NSNumber alloc] initWithFloat: latitude];
            NSNumber *aLongitude = [[NSNumber alloc] initWithFloat: longitude];
            
            NSString *stringTimeZone = [[NSString alloc] initWithUTF8String: timeZone];
            NSTimeZone *aTimeZone = [[NSTimeZone alloc] initWithName: stringTimeZone];
            
            City *aCity = [[City alloc] initWithName:aName state:aState longitude:aLongitude latitude:aLatitude timeZone:aTimeZone];
            
            [retval addObject: aCity];
        }
        
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"Failed Prepare");
    }
    
    return retval;
}

- (NSArray *)getAllFromState:(NSString *)aState
{
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat: @"SELECT * FROM cities WHERE state = '%@';", [aState uppercaseString]];
    
    NSLog(@"%@", query);
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            char *name = (char*)sqlite3_column_text(statement, 0);
            char *state = (char*)sqlite3_column_text(statement, 1);
            float latitude = (float)sqlite3_column_double(statement, 2);
            float longitude = (float) sqlite3_column_double(statement, 3);
            char *timeZone = (char*)sqlite3_column_text(statement, 4);
            
            NSString *aName = [[NSString alloc] initWithUTF8String: name];
            NSString *aState = [[NSString alloc] initWithUTF8String: state];
            NSNumber *aLatitude = [[NSNumber alloc] initWithFloat: latitude];
            NSNumber *aLongitude = [[NSNumber alloc] initWithFloat: longitude];
            
            NSString *stringTimeZone = [[NSString alloc] initWithUTF8String: timeZone];
            NSTimeZone *aTimeZone = [[NSTimeZone alloc] init];
            
            if([stringTimeZone isEqualToString: @"America/Chicago"]||[stringTimeZone isEqualToString: @"America/New_York"])
            {
                aTimeZone = [NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"%@", stringTimeZone]];
            }
            else
            {
                aTimeZone = [NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"US/%@", stringTimeZone]];
            }
            
            City *aCity = [[City alloc] initWithName:aName state:aState longitude:aLongitude latitude:aLatitude timeZone:aTimeZone];
            
            [retval addObject: aCity];
        }
        
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"Failed Prepare");
    }
    
    return retval;
}

- (NSArray *)getAllCitiesWithName:(NSString *)aName inState: (NSString*) aState
{
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat: @"SELECT * FROM cities WHERE name = '%@' and state = '%@';", aName, [aState uppercaseString]];
    
    NSLog(@"%@", query);
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            char *name = (char*)sqlite3_column_text(statement, 0);
            char *state = (char*)sqlite3_column_text(statement, 1);
            float latitude = (float)sqlite3_column_double(statement, 2);
            float longitude = (float) sqlite3_column_double(statement, 3);
            char *timeZone = (char*)sqlite3_column_text(statement, 4);
            
            NSString *aName = [[NSString alloc] initWithUTF8String: name];
            NSString *aState = [[NSString alloc] initWithUTF8String: state];
            NSNumber *aLatitude = [[NSNumber alloc] initWithFloat: latitude];
            NSNumber *aLongitude = [[NSNumber alloc] initWithFloat: longitude];
            
            NSString *stringTimeZone = [[NSString alloc] initWithUTF8String: timeZone];
            NSTimeZone *aTimeZone = [NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"US/%@", stringTimeZone]];
            
            City *aCity = [[City alloc] initWithName:aName state:aState longitude:aLongitude latitude:aLatitude timeZone:aTimeZone];
            
            //NSLog(@"timezone: %@", aTimeZone);
            
            [retval addObject: aCity];
        }
        
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"Failed Prepare");
    }
    
    return retval;
}

@end
