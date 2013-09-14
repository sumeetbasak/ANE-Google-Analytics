/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/12/12 14:22
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"
#import "GAI.h"
#import "GAIFields.h"

@interface ClientID : NSObject

DEFINE_ANE_FUNCTION(getClientID);
DEFINE_ANE_FUNCTION(setClientID);

@end