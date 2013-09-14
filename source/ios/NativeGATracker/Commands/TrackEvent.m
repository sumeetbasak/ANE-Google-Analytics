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

#import "TrackEvent.h"

@implementation TrackEvent

-(FREObject) track:(FREObject *)data onTracker:(id)tracker forContext:(FREContext)context {

    NSString *category;
    NSString *action;
    NSString *label;
    NSNumber *value;

    @try {
        category = [FREConversionUtil toString:[FREConversionUtil getProperty:@"category" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'category' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'category' property on method '%s'.", __FUNCTION__);
    }

    @try {
        action = [FREConversionUtil toString:[FREConversionUtil getProperty:@"action" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'action' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'action' property on method '%s'.", __FUNCTION__);
    }

    @try {
        label = [FREConversionUtil toString:[FREConversionUtil getProperty:@"label" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kInfo, @"Unable to read 'label property, falling back to default value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        label = NULL;
    }

    @try {
        value = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"value" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kInfo, @"Unable to read 'value' property, falling back to default value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        value = NULL;
    }

    NSMutableDictionary *hit = [NSDictionary dictionaryWithObjectsAndKeys:
                                kGAIEvent, kGAIHitType,
                                category, kGAIEventCategory,
                                action, kGAIEventAction,
                                nil];
    if (label) {
        [hit setObject:label forKey:kGAIEventLabel];
    }
    if (value) {
        [hit setObject:[value stringValue] forKey:kGAIEventValue];
    }
    
    [tracker send:hit];
    
    return NULL;
}

@end