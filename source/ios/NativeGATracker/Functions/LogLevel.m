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

#import "LogLevel.h"

@implementation LogLevel

DEFINE_ANE_FUNCTION(setLogLevel) {
    FREObject result = NULL;

    NSString *value;
    @try {
        value = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    NSDictionary *levelNameMap = [NSDictionary dictionaryWithObjectsAndKeys:
        (id) kGAILogLevelVerbose, @"VERBOSE",
        (id) kGAILogLevelInfo, @"INFO",
        (id) kGAILogLevelWarning, @"WARNING",
        (id) kGAILogLevelError, @"ERROR",
        nil];
    GAILogLevel level = (GAILogLevel)[levelNameMap objectForKey:value];

    @try {
        [[GAI sharedInstance].logger setLogLevel:level];
    }
    @catch (NSException *exception) {
        logEvent(context, kWarning, @"Unable to set the requested log level '%s'", value);
    }

    return result;
}
DEFINE_ANE_FUNCTION(getLogLevel) {
    FREObject result = NULL;

    NSString *value;
    GAILogLevel level = [[GAI sharedInstance].logger logLevel];
    switch(level) {
        case kGAILogLevelNone:
            value = @"NONE";
            break;
        case kGAILogLevelVerbose:
            value = @"VERBOSE";
            break;
        case kGAILogLevelInfo:
            value = @"INFO";
            break;
        case kGAILogLevelWarning:
            value = @"WARNING";
            break;
        case kGAILogLevelError:
            value = @"ERROR";
            break;
        default:
            value = @"INFO";
    }

    @try {
        result = [FREConversionUtil fromString:value];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }

    return result;
}

@end