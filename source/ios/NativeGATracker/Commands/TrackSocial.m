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

#import "TrackSocial.h"

@implementation TrackSocial

-(FREObject) track:(FREObject *)data onTracker:(id)tracker forContext:(FREContext)context {

    NSString *network;
    NSString *action;
    NSString *target;

    @try {
        network = [FREConversionUtil toString:[FREConversionUtil getProperty:@"network" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'network' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'network' property on method '%s'.", __FUNCTION__);
    }

    @try {
        action = [FREConversionUtil toString:[FREConversionUtil getProperty:@"action" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'action' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'action' property on method '%s'.", __FUNCTION__);
    }

    @try {
        target = [FREConversionUtil toString:[FREConversionUtil getProperty:@"content" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kInfo, @"Unable to read 'target' property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        target = NULL;
    }

    NSMutableDictionary *hit = [NSDictionary dictionaryWithObjectsAndKeys:
                                kGAISocial, kGAIHitType,
                                network, kGAISocialNetwork,
                                action, kGAISocialAction,
                                nil];
    if (target) {
        [hit setObject:target forKey:kGAISocialTarget];
    }
    
    [tracker send:hit];

    return NULL;
}

@end