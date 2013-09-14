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

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"
#import "GAI.h"
#import "GAIFields.h"

@interface Track : NSObject

-(FREObject) track:(FREObject *)data onTracker:(id)tracker forContext:(FREContext)context;


@end