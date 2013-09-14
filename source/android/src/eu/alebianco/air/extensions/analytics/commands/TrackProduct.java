package eu.alebianco.air.extensions.analytics.commands;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.google.analytics.tracking.android.Fields;
import com.google.analytics.tracking.android.HitTypes;
import com.google.analytics.tracking.android.Tracker;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

import java.util.HashMap;

/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 10/09/2013 09:39
 *
 * Copyright © 2013 Alessandro Bianco
 */
public class TrackProduct implements ITrackHit {
    @Override
    public FREObject track(FREContext context, Tracker tracker, FREObject data) {

        String id;
        String sku;
        String name;
        Double price;
        String category;
        Long quantity;
        String currency;

        try {
            id = data.getProperty("id").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'id' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'id' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            sku = data.getProperty("sku").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'sku' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'sku' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            name = data.getProperty("name").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'name' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'name' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            price = data.getProperty("price").getAsDouble();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'price' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'price' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            quantity = (long) data.getProperty("quantity").getAsInt();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'quantity' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'quantity' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            category = data.getProperty("category").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read 'category' property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            category = null;
        }

        try {
            currency = data.getProperty("currency").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read 'currency' property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            currency = null;
        }

        HashMap<String, String> hit = new HashMap<String, String>();
        hit.put(Fields.HIT_TYPE, HitTypes.ITEM);
        hit.put(Fields.TRACKING_ID, id);
        hit.put(Fields.ITEM_SKU, sku);
        hit.put(Fields.ITEM_NAME, name);
        hit.put(Fields.ITEM_PRICE, price.toString());
        hit.put(Fields.ITEM_QUANTITY, quantity.toString());
        if (category != null) {
            hit.put(Fields.ITEM_CATEGORY, category);
        }
        if (currency != null) {
            hit.put(Fields.CURRENCY_CODE, currency);
        }

        tracker.send(hit);

        return null;
    }
}
