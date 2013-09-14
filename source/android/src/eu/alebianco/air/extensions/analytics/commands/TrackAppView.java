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
public class TrackAppView implements ITrackHit {
    @Override
    public FREObject track(FREContext context, Tracker tracker, FREObject data) {

        String screen;
        try {
            screen = data.getProperty("screen").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read 'screen' property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read 'screen' property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        HashMap<String, String> hit = new HashMap<String, String>();
        hit.put(Fields.HIT_TYPE, HitTypes.APP_VIEW);
        hit.put(Fields.SCREEN_NAME, screen);
        tracker.send(hit);

        return null;
    }
}
