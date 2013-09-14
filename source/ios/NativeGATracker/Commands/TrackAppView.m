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

#import "TrackAppView.h"

@implementation TrackAppView

-(FREObject) track:(FREObject *)data onTracker:(id)tracker forContext:(FREContext)context {

    NSString *screen;
    @try {
       screen = [FREConversionUtil toString:[FREConversionUtil getProperty:@"screen" fromObject:data]];
    }
    @catch (NSException *exception) {
       logEvent(context, kError, @"Unable to read 'screen' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
       return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'screen' property on method '%s'.", __FUNCTION__);
    }
    
    NSMutableDictionary *hit = [NSDictionary dictionaryWithObjectsAndKeys:
                                kGAIAppView, kGAIHitType,
                                screen, kGAIScreenName,
                                nil];
    
    [tracker send:hit];
    
    return NULL;
}

@end