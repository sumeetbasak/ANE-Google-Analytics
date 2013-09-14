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

#import "TrackException.h"

@implementation TrackException

-(FREObject) track:(FREObject *)data onTracker:(id)tracker forContext:(FREContext)context {

    BOOL fatal;
    NSString *description;

    @try {
        fatal = [FREConversionUtil toBoolean:[FREConversionUtil getProperty:@"fatal" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'fatal' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'fatal' property on method '%s'.", __FUNCTION__);
    }

    @try {
        description = [FREConversionUtil toString:[FREConversionUtil getProperty:@"description" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kInfo, @"Unable to read 'description' property, falling back to default description. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        description = @"";
    }

    NSMutableDictionary *hit = [NSDictionary dictionaryWithObjectsAndKeys:
                                kGAIException, kGAIHitType,
                                fatal ? @"true" : @"false", kGAIEventCategory,
                                nil];
    if (description) {
        [hit setObject:description forKey:kGAIExDescription];
    }
    
    [tracker send:hit];
    
    return NULL;
}

@end