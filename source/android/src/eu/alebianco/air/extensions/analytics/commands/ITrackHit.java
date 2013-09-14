package eu.alebianco.air.extensions.analytics.commands;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.google.analytics.tracking.android.Tracker;

/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 10/09/2013 09:35
 *
 * Copyright © 2013 Alessandro Bianco
 */
public interface ITrackHit {

    FREObject track(FREContext context, Tracker tracker, FREObject data);
}
