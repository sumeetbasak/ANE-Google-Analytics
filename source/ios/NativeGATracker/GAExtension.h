/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/12/12 16.04
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

#import "IsSupported.h"
#import "GetVersion.h"

#import "CreateTracker.h"
#import "CloseTracker.h"
#import "OptOut.h"
#import "DryRun.h"
#import "LogLevel.h"

#import "AppID.h"
#import "AppName.h"
#import "AppVersion.h"
#import "ClientID.h"

#import "Anonymous.h"
#import "Secure.h"
#import "SampleRate.h"
#import "SessionControl.h"
#import "TrackData.h"
#import "CustomDimension.h"
#import "CustomMetric.h"

#define MAP_FUNCTION(fn, data) { (const uint8_t *)(#fn), (data), &(fn) }