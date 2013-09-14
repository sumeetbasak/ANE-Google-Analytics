/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 15.22
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.google.analytics.tracking.android.GoogleAnalytics;
import com.google.analytics.tracking.android.Logger;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

public class SetLogLevel implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        String value;
        try {
            value = args[0].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to read the 'value' parameter. [Exception:(type:%s, method:%s)].",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'value' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        Logger.LogLevel level = null;
        switch (LogLevel.valueOf(value)) {
            case VERBOSE:
                level = Logger.LogLevel.VERBOSE;
                break;
            case INFO:
                level = Logger.LogLevel.INFO;
                break;
            case WARNING:
                level = Logger.LogLevel.WARNING;
                break;
            case ERROR:
                level = Logger.LogLevel.ERROR;
                break;
            default:
                level = Logger.LogLevel.INFO;
        }

        try {
            GoogleAnalytics.getInstance(context.getActivity()).getLogger().setLogLevel(level);
        }
        catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.WARNING, "Unable to set the requested log level '%s'", value);
        }

        return result;
    }
}