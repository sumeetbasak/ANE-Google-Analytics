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
public class TrackException implements ITrackHit {
    @Override
    public FREObject track(FREContext context, Tracker tracker, FREObject data) {

        Boolean fatal;
        String description;

        try {
            fatal = data.getProperty("fatal").getAsBool();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'fatal' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'fatal' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            description = data.getProperty("description").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read 'description' property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            description = null;
        }

        HashMap<String, String> hit = new HashMap<String, String>();
        hit.put(Fields.HIT_TYPE, HitTypes.EXCEPTION);
        hit.put(Fields.EX_FATAL, fatal.toString());
        if (description != null) {
            hit.put(Fields.EX_DESCRIPTION, description);
        }
        tracker.send(hit);

        return null;
    }
}
