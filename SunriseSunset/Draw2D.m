//
//  Draw2D.m
//  coreGraphicsPractice
//
//  Created by Rj on 4/24/16.
//  Copyright © 2016 Rj. All rights reserved.
//

#import "Draw2D.h"

@implementation Draw2D

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// scales a number in relation to the amount of hours in a day
- (NSNumber*)getProportionWithTime: (NSNumber*) aTime
{
    return @(((M_PI*2)*[aTime floatValue])/24);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Get Current Time
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    NSLog(@"current hour: %ld", hour);
    NSLog(@"current minute: %ld", minute);
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    self.sunriseStart = @(self.riseset.localCivilTwilightStart.hour + (self.riseset.localCivilTwilightStart.minute / 60.0f));
    self.sunriseEnd = @(self.riseset.localSunrise.hour + (self.riseset.localSunrise.minute / 60.0f));
    self.sunsetStart = @(self.riseset.localSunset.hour + (self.riseset.localSunset.minute / 60.0f));
    self.sunsetEnd = @(self.riseset.localCivilTwilightEnd.hour + (self.riseset.localCivilTwilightEnd.minute / 60.0f));
    
    NSLog(@"sunrise start: %@", self.sunriseStart);
    NSLog(@"sunrise end: %@", self.sunriseEnd);
    NSLog(@"sunset start: %@", self.sunsetStart);
    NSLog(@"sunset end: %@", self.sunsetEnd);
    
    NSNumber *sunriseStart = [self getProportionWithTime:self.sunriseStart];
    NSNumber *sunriseEnd = [self getProportionWithTime:self.sunriseEnd];
    NSNumber *sunsetStart = [self getProportionWithTime:self.sunsetStart];
    NSNumber *sunsetEnd = [self getProportionWithTime:self.sunsetEnd];
    
    NSNumber *time = @(hour + (minute / 60));
    NSNumber *currTime = [self getProportionWithTime:time];
    
    CGPoint circleCenter = CGPointMake(self.bounds.size.width / 3, self.bounds.size.height / 2);

    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
    
    // draw the entire circle first
    CGContextAddArc(context, circleCenter.x, circleCenter.y, 50, 0, M_PI*2, 0);
    CGContextAddLineToPoint(context, circleCenter.x, circleCenter.y);
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextFillPath(context);
    
    // arc layer : sunset ends (twilight end)
    CGContextAddArc(context, circleCenter.x, circleCenter.y, 50, -[sunsetEnd floatValue], 0, 0);
    CGContextAddLineToPoint(context, circleCenter.x, circleCenter.y);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    
    // arc layer : sunset start
    CGContextAddArc(context, circleCenter.x, circleCenter.y, 50, -[sunsetStart floatValue], 0, 0);
    CGContextAddLineToPoint(context, circleCenter.x, circleCenter.y);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillPath(context);
    
    // arc layer : sunrise official
    CGContextAddArc(context, circleCenter.x, circleCenter.y, 50, -[sunriseEnd floatValue], 0, 0);
    CGContextAddLineToPoint(context, circleCenter.x, circleCenter.y);
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextFillPath(context);
    
    // arc layer : sunrise unofficial (twilight start)
    CGContextAddArc(context, circleCenter.x, circleCenter.y, 50, -[sunriseStart floatValue], 0, 0);
    CGContextAddLineToPoint(context, circleCenter.x, circleCenter.y);
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextFillPath(context);
    
    // draw hand to show current position in time (counter-clockwise orientation)
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, 3);
    CGContextAddArc(context, circleCenter.x, circleCenter.y, 40, -[currTime floatValue], -[currTime floatValue], 0);
    CGContextAddLineToPoint(context, circleCenter.x, circleCenter.y);
    CGContextStrokePath(context);
}


@end
