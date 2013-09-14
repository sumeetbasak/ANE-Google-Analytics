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
public class TrackSocial implements ITrackHit {
    @Override
    public FREObject track(FREContext context, Tracker tracker, FREObject data) {

        String network;
        String action;
        String target;

        try {
            network = data.getProperty("network").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'network' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'network' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
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
            target = data.getProperty("target").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read 'target' property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            target = null;
        }

        HashMap<String, String> hit = new HashMap<String, String>();
        hit.put(Fields.HIT_TYPE, HitTypes.SOCIAL);
        hit.put(Fields.SOCIAL_NETWORK, network);
        hit.put(Fields.SOCIAL_ACTION, action);
        if (target != null) {
            hit.put(Fields.SOCIAL_TARGET, target);
        }
        tracker.send(hit);

        return null;
    }
}
