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

#import "SessionControl.h"

@implementation SessionControl

DEFINE_ANE_FUNCTION(setSessionControl) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    NSString *value;
    @try {
        trackingId = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        value = NULL;
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
    [tracker set:kGAISessionControl value:value];

    return result;
}

@end