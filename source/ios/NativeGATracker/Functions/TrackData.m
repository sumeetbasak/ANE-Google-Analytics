/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/12/12 14:37
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "TrackData.h"

@implementation TrackData

DEFINE_ANE_FUNCTION(trackData) {
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

    NSString *type;
    @try {
        type = [FREConversionUtil toString:argv[1]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read the 'type' parameter. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read the 'type' parameter on method '%s'.", __FUNCTION__);
    }

    FREObject data = argv[2];
    
    NSDictionary *typeNameMap = [NSDictionary dictionaryWithObjectsAndKeys:
           (id) kGAIAppView, @"appview",
           (id) kGAIEvent, @"event",
           (id) kGAISocial, @"social",
           (id) kGAITransaction, @"transaction",
           (id) kGAIException, @"exception",
           (id) kGAITiming, @"timing",
           nil];

    GAILogLevel key = (GAILogLevel)[typeNameMap objectForKey:type];

    NSDictionary *commandMap = [NSDictionary dictionaryWithObjectsAndKeys:
        [[TrackAppView alloc] init], (id) kGAIAppView,
        [[TrackEvent alloc] init], (id) kGAIEvent,
        [[TrackSocial alloc] init], (id) kGAISocial,
        [[TrackTransaction alloc] init], (id) kGAITransaction,
        [[TrackException alloc] init], (id) kGAIException,
        [[TrackTiming alloc] init], (id) kGAITiming,
        nil];

    Track *command = (Track *)[commandMap objectForKey:key];

    [command track:data onTracker:tracker forContext:context];

    return result;
}

@end