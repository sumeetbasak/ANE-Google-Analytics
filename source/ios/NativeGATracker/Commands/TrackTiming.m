/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 10/09/13 14:04
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "TrackTiming.h"

@implementation TrackTiming

-(FREObject) track:(FREObject *)data onTracker:(id)tracker forContext:(FREContext)context {

    NSString *category;
    NSInteger interval;
    NSString *name;
    NSString *label;

    @try {
        category = [FREConversionUtil toString:[FREConversionUtil getProperty:@"category" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'category' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'category' property on method '%s'.", __FUNCTION__);
    }

    @try {
        interval = [FREConversionUtil toInt:[FREConversionUtil getProperty:@"interval" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'interval' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'interval' property on method '%s'.", __FUNCTION__);
    }

    @try {
        name = [FREConversionUtil toString:[FREConversionUtil getProperty:@"name" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kInfo, @"Unable to read 'name' property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        name = NULL;
    }

    @try {
        label = [FREConversionUtil toString:[FREConversionUtil getProperty:@"label" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kInfo, @"Unable to read 'label' property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        label = NULL;
    }

    NSMutableDictionary *hit = [NSDictionary dictionaryWithObjectsAndKeys:
                                kGAITiming, kGAIHitType,
                                category, kGAITimingCategory,
                                [NSString stringWithFormat:@"%d", interval], kGAITimingValue,
                                nil];
    if (name) {
        [hit setObject:name forKey:kGAITimingVar];
    }
    if (label) {
        [hit setObject:label forKey:kGAITimingLabel];
    }
    
    [tracker send:hit];
    
    return NULL;
}

@end