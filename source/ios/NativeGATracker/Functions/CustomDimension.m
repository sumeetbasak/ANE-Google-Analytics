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

#import "CustomDimension.h"

@implementation CustomDimension

DEFINE_ANE_FUNCTION(setCustomDimension) {
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

    NSUInteger index;
    @try {
        index = [FREConversionUtil toUInt:argv[1]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'index' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'index' parameter on method '%s'.", __FUNCTION__);
    }

    NSString *value;
    @try {
        value = [FREConversionUtil toString:argv[2]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:[GAIFields customDimensionForIndex:index] value:value];

    return result;
}
DEFINE_ANE_FUNCTION(clearCustomDimension) {
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

    NSUInteger index;
    @try {
        index = [FREConversionUtil toUInt:argv[1]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'index' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'index' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:[GAIFields customDimensionForIndex:index] value:NULL];

    return result;
}

@end