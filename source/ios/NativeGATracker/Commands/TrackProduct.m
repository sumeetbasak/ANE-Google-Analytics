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

#import "TrackProduct.h"

@implementation TrackProduct

-(FREObject) track:(FREObject *)data onTracker:(id)tracker forContext:(FREContext)context {

    NSString *id;
    NSString *sku;
    NSString *name;
    NSNumber *price;
    NSInteger quantity;
    NSString *currency;
    
    @try {
        id = [FREConversionUtil toString:[FREConversionUtil getProperty:@"id" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'id' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'id' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        sku = [FREConversionUtil toString:[FREConversionUtil getProperty:@"sku" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'sku' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'sku' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        name = [FREConversionUtil toString:[FREConversionUtil getProperty:@"name" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'name' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'name' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        price = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"price" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'price' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'price' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        quantity = [FREConversionUtil toInt:[FREConversionUtil getProperty:@"quantity" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'quantity' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'quantity' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        currency = [FREConversionUtil toString:[FREConversionUtil getProperty:@"currency" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kInfo, @"Unable to read 'currency' property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        currency = NULL;
    }
}

@end