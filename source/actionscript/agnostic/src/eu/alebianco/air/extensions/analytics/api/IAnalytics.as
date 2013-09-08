/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 16.34
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

import eu.alebianco.core.IDisposable;

public interface IAnalytics extends IDisposable {

	function get version():String;


	function get optOut():Boolean;
	function set optOut(value:Boolean):void;

	function get dryRun():Boolean;
	function set dryRun(value:Boolean):void;

	function getTracker(trackingId:String):ITracker;
	function hasTracker(trackingId:String):Boolean;
	function closeTracker(trackingId:String):void;
}
}
