/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 17.33
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.*;
import com.google.analytics.tracking.android.*;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.analytics.commands.*;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

import java.util.HashMap;

public class TrackData implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        String trackingId;
        try {
            trackingId = args[0].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read the 'trackingId' parameter. [Exception:(type:%s, method:%s)].",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'trackingId' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        String type;
        try {
            type = args[1].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read the 'type' parameter. [Exception:(type:%s, method:%s)].",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'type' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        Tracker tracker = GoogleAnalytics.getInstance(context.getActivity()).getTracker(trackingId);

        FREObject data = args[2];

        HashMap<String, ITrackHit> map = new HashMap<String, ITrackHit>();
        map.put(HitTypes.APP_VIEW, new TrackAppView());
        map.put(HitTypes.EVENT, new TrackEvent());
        map.put(HitTypes.EXCEPTION, new TrackException());
        map.put(HitTypes.TIMING, new TrackTiming());
        map.put(HitTypes.SOCIAL, new TrackSocial());
        map.put(HitTypes.TRANSACTION, new TrackTransaction());

        ITrackHit command = map.get(type);

        if (command != null) {
            result = command.track(context, tracker, data);
        } else {
            FREUtils.logEvent(context, LogLevel.WARNING, "Hit type not recognized: {0}", type);
        }

        return result;
    }
}