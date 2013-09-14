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

#import "AppVersion.h"

@implementation AppVersion

DEFINE_ANE_FUNCTION(getAppVersion) {
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

    if ([tracker get:kGAIClientIdkGAIAppVersion] != NULL) {
        @try {
            result = [FREConversionUtil fromString:[tracker get:kGAIClientIdkGAIAppVersion]];
        }
        @catch (NSException *exception) {
            logEvent(context, kError, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
            return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
        }
    }

    return result;
}
DEFINE_ANE_FUNCTION(setAppVersion) {
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

    NSString *version;
    @try {
        version = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'version' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'version' parameter on method '%s'.", __FUNCTION__);
    }

    [tracker set:kGAIClientIdkGAIAppVersion value:version];

    return result;
}

@end