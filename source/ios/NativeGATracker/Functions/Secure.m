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

#import "Secure.h"

@implementation Secure

DEFINE_ANE_FUNCTION(getSecure) {
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

    @try {
        result = [FREConversionUtil fromBoolean:[tracker get:kGAIUseSecure]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }

    return result;
}
DEFINE_ANE_FUNCTION(setSecure) {
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

    NSString *value;
    @try {
        value = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:kGAIUseSecure value:value];

    return result;
}

@end