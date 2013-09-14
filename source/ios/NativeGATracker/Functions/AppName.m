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

#import "AppName.h"

@implementation AppName

DEFINE_ANE_FUNCTION(getAppName) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];

    if ([tracker get:kGAIAppName] != NULL) {
        @try {
            result = [FREConversionUtil fromString:[tracker get:kGAIAppName]];
        }
        @catch (NSException *exception) {
            logEvent(context, kError, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
            return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
        }
    }

    return result;
}
DEFINE_ANE_FUNCTION(setAppName) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];

    NSString *name;
    @try {
        name = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'name' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'name' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:kGAIAppName value:name];

    return result;
}

@end