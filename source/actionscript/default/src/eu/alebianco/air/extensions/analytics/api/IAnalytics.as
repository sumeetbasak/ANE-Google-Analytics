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

/**
 * Manages the trackers and provide facilities to dispatch the collected hits and set behavioral flags.
 */
public interface IAnalytics extends IDisposable {
	/**
	 * Current version of the extension.
	 */
	function get version():String;
	/**
	 * Sets or resets the application-level opt out flag.
	 * <p>If set, no hits will be sent to Google Analytics. The value of this flag will persist across app starts.</p>
	 * @default false
	 */
	function get optOut():Boolean;
	/**
	 * @private
	 */
	function set optOut(value:Boolean):void;
	/**
	 * Toggles dry run mode.
	 * <p>In dry run mode, the normal code paths are executed locally, but hits are not sent to Google Analytics servers.</p>
	 * @default false
	 */
	function get dryRun():Boolean;
	/**
	 * @private
	 */
	function set dryRun(value:Boolean):void;
	/**
	 * Returns a tracker for the specified Google Analytics account ID.
	 * <p>When the tracker is created, some information about the current application (id, name and version) are
	 * automatically set. They can be overridden before tracking any kind of data.</p>
	 * <p>Multiple trackers can be created for multiple accounts. If a tracker for a given ID has already been created,
	 * and not yet disposed, the existing instance will be returned.</p>
	 * @param trackingId String in the form UA-xxxx-y
	 * @return The tracker from which send tracking events to Google Analytics
	 * @throws ArgumentError if the trackingId specified doesn't match the requested format.
	 */
	function getTracker(trackingId:String):ITracker;
	/**
	 * Checks whether a tracker for the given ID already exists or not.
	 * @param trackingId String in the form UA-xxxx-y
	 * @return true if the tracker already exists, false otherwise.
	 * @throws ArgumentError if the trackingId specified doesn't match the requested format.
	 */
	function hasTracker(trackingId:String):Boolean;
	/**
	 * Dispose the tracker for the given ID, if it exists.
	 * <p>After being disposed the tracker can't be used anymore and should be recreated using getTracker().</p>
	 * @see #getTracker()
	 * @param trackingId String in the form UA-xxxx-y
	 * @throws ArgumentError if the trackingId specified doesn't match the requested format.
	 */
	function closeTracker(trackingId:String):void;
}
}