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

#import "OptOut.h"

@implementation OptOut

DEFINE_ANE_FUNCTION(setOptOut) {
    FREObject result = NULL;

    BOOL value;
    @try {
        value = [FREConversionUtil toBoolean:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    [[GAI sharedInstance] setOptOut:value];

    return result;
}
DEFINE_ANE_FUNCTION(getOptOut) {
    FREObject result = NULL;

    BOOL value = [[GAI sharedInstance] optOut];

    @try {
        result = [FREConversionUtil fromBoolean:value];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }

    return result;
}

@end