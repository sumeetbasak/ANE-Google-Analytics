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

#import "TrackTransaction.h"

@implementation TrackTransaction

-(FREObject) track:(FREObject *)data onTracker:(id)tracker forContext:(FREContext)context {

    FREObject result = NULL;

    NSString *id;
    NSNumber *revenue;
    NSString *affiliation;
    NSNumber *shipping;
    NSNumber *tax;
    NSString *currency;

    FREObject *products;

    @try {
        id = [FREConversionUtil toString:[FREConversionUtil getProperty:@"id" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'id' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'id' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        affiliation = [FREConversionUtil toString:[FREConversionUtil getProperty:@"affiliation" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'affiliation' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'affiliation' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        revenue = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"revenue" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'revenue' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'revenue' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        shipping = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"shipping" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'shipping' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'shipping' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        tax = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"tax" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read 'tax' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read 'tax' property on method '%s'.", __FUNCTION__);
    }
    
    @try {
        currency = [FREConversionUtil toString:[FREConversionUtil getProperty:@"currency" fromObject:data]];
    }
    @catch (NSException *exception) {
        logEvent(context, kInfo, @"Unable to read 'currency' property, falling back to default label. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        currency = NULL;
    }
    
    NSMutableDictionary *hit = [NSDictionary dictionaryWithObjectsAndKeys:
                                kGAITransaction, kGAIHitType,
                                id, kGAITransactionId,
                                affiliation, kGAITransactionAffiliation,
                                [revenue stringValue], kGAITransactionRevenue,
                                [shipping stringValue], kGAITransactionShipping,
                                [tax stringValue], kGAITransactionTax,
                                nil];
    if (currency) {
        [hit setObject:currency forKey:kGAICurrencyCode];
    }
    
    [tracker send:hit];
    
    @try {
        Track *productTrackCommand = (Track *)[[TrackProduct alloc] init];
        products = [FREConversionUtil getProperty:@"products" fromObject:data];
        NSUInteger prodc = [FREConversionUtil getArrayLength:products];
        for (NSUInteger i = 0; i < prodc; i++) {
            FREObject product = [FREConversionUtil getArrayItemAt:i on:products];
            result = [productTrackCommand track:product onTracker:tracker forContext:context];
            if (result != NULL) {
                return result;
            }
        }
    }
    @catch (NSException *exception) {
        logEvent(context, kError, @"Unable to read a 'products' property. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to read a 'products' property '%s'.", __FUNCTION__);
    }

    return result;
}

@end