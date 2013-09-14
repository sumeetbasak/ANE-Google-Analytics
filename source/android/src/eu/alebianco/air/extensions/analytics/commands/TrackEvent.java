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
public class TrackEvent implements ITrackHit {
    @Override
    public FREObject track(FREContext context, Tracker tracker, FREObject data) {

        String category;
        String action;
        String label;
        Long value;

        try {
            category = data.getProperty("category").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'category' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'category' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            action = data.getProperty("action").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'action' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'action' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            label = data.getProperty("label").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read 'label' property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            label = null;
        }

        try {
            value = (long) data.getProperty("value").getAsInt();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read 'value' property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            value = null;
        }

        HashMap<String, String> hit = new HashMap<String, String>();
        hit.put(Fields.HIT_TYPE, HitTypes.EVENT);
        hit.put(Fields.EVENT_CATEGORY, category);
        hit.put(Fields.EVENT_ACTION, action);
        if (label != null) {
            hit.put(Fields.EVENT_LABEL, label);
        }
        if (value != null) {
            hit.put(Fields.EVENT_VALUE, value.toString());
        }
        tracker.send(hit);

        return null;
    }
}
