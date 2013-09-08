/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/12/12 10.54
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "Analytics.h"

@implementation Analytics

DEFINE_ANE_FUNCTION(createTracker) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];

    return result;
}
DEFINE_ANE_FUNCTION(closeTracker) {
    FREObject result = NULL;

    NSString *trackingId;
    @try {
        trackingId = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'trackingId' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'trackingId' parameter on method '%s'.", __FUNCTION__);
    }

    id tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
    [tracker close];

    return result;
}
DEFINE_ANE_FUNCTION(setOptOut) {
    FREObject result = NULL;

    BOOL value;
    @try {
        value = [FREConversionUtil toBoolean:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
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
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }

    return result;
}
DEFINE_ANE_FUNCTION(setDryRun) {
    FREObject result = NULL;

    BOOL value;
    @try {
        value = [FREConversionUtil toBoolean:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    [[GAI sharedInstance] setDryRun: value];

    return result;
}
DEFINE_ANE_FUNCTION(getDryRun) {
    FREObject result = NULL;

    BOOL value = [[GAI sharedInstance] dryRun];

    @try {
        result = [FREConversionUtil fromBoolean:value];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }

    return result;
}
DEFINE_ANE_FUNCTION(setLogLevel) {
    FREObject result = NULL;

    NSString *value;
    @try {
        value = [FREConversionUtil toString:argv[0]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to read the 'value' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'value' parameter on method '%s'.", __FUNCTION__);
    }

    NSDictionary *levelNameMap = [NSDictionary dictionaryWithObjectsAndKeys:
        (id) kGAILogLevelVerbose, @"VERBOSE",
        (id) kGAILogLevelInfo, @"INFO",
        (id) kGAILogLevelInfo, @"DEBUG",
        (id) kGAILogLevelWarning, @"WARNING",
        (id) kGAILogLevelError, @"ERROR",
        (id) kGAILogLevelError, @"FATAL",
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
            value = @"WARNING";
    }

    @try {
        result = [FREConversionUtil fromString:value];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }

    return result;
}

@end