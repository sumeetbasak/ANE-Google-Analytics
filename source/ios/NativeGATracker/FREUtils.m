/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/12/12 16.06
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "FREUtils.h"

@implementation FREUtils

void logEvent(FREContext ctx, enum LogLevel level, NSString *format, ...) {
    va_list ap = NULL;
    va_start(ap, format);
    NSString *message = [[[NSString alloc] initWithFormat:format arguments:ap] autorelease];
    va_end(ap);

    NSString *tag = NULL;
    switch (level) {
        case kVerbose:
            tag = @"VERBOSE";
            break;
        case kInfo:
            tag = @"INFO";
            break;
        case kDebug:
            tag = @"DEBUG";
            break;
        case kWarning:
            tag = @"WARNING";
            break;
        case kError:
            tag = @"ERROR";
            break;
        case kFatal:
            tag = @"FATAL";
            break;
        default:
            tag = @"INFO";
            break;
    }

    NSLog(@"%@: %@", tag, message);
    DISPATCH_EVENT(ctx, (uint8_t *) [[@"INTERNAL_" stringByAppendingString:tag] UTF8String], (uint8_t *) [message UTF8String]);
}
FREObject createRuntimeException(NSString *type, NSInteger id, NSString *format, ...) {
    FREObject object;

    va_list ap = NULL;
    va_start(ap, format);
    NSString *message = [[[NSString alloc] initWithFormat:format arguments:ap] autorelease];
    va_end(ap);

    uint32_t argc = 2;

    FREObject argv[argc];
    argv[0] = [FREConversionUtil fromString:message];
    argv[1] = [FREConversionUtil fromInt:id];

    FREResult result = FRENewObject((uint8_t *) [type UTF8String], argc, argv, &object, NULL);

    if (result == FRE_OK) {
        return object;
    } else {
        NSLog(@"Inception Error: Unable to create the runtime exception to notify the application about the previous error.");
    }

    return NULL;
}

@end
