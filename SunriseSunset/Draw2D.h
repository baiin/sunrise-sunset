//
//  Draw2D.h
//  coreGraphicsPractice
//
//  Created by Rj on 4/24/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EDSunriseSet.h>

@interface Draw2D : UIView

@property (strong) NSNumber *sunriseStart;
@property (strong) NSNumber *sunriseEnd;
@property (strong) NSNumber *sunsetStart;
@property (strong) NSNumber *sunsetEnd;

@property (strong) EDSunriseSet *riseset;

@end
