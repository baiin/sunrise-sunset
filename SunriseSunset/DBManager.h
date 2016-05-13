//
//  DBManager.h
//  sqliteTest
//
//  Created by Rj on 4/12/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "City.h"

@interface DBManager : NSObject
{
    sqlite3* db;
}

- (NSArray*) getAllCities;
- (NSArray *)getAllFromState:(NSString *)aState;
- (NSArray *)getAllCitiesWithName:(NSString *)aName inState:(NSString*) aState;

@end
