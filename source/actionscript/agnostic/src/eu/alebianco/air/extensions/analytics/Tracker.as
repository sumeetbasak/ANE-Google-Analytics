/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 18.55
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;
import eu.alebianco.air.extensions.analytics.api.IEventBuilder;
import eu.alebianco.air.extensions.analytics.api.IExceptionBuilder;
import eu.alebianco.air.extensions.analytics.api.ISocialBuilder;
import eu.alebianco.air.extensions.analytics.api.ITimingBuilder;
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.api.ITransactionBuilder;
import eu.alebianco.air.extensions.analytics.api.IViewBuilder;

import flash.desktop.NativeApplication;
import flash.external.ExtensionContext;

internal class Tracker implements ITracker {

	private var context:ExtensionContext;

	private var id:String;

	private var _appName:String;
	private var _appVersion:String;
	private var _lockAppData:Boolean = false;

	private var _sessionStarted:Boolean = false;

	public function Tracker(id:String, context:ExtensionContext) {
		this.id = id;
		this.context = context;
		parseAppDescriptor();
	}

	public function get appName():String {
		return _appName;
	}
	public function set appName(value:String):void {
		if (_lockAppData) return;
		_appName = value;
		handleResultFromExtension(context.call("setAppName", id, _appName));
	}
	public function get appVersion():String {
		return _appVersion;
	}
	public function set appVersion(value:String):void {
		if (_lockAppData) return;
		_appVersion = value;
		handleResultFromExtension(context.call("setAppVersion", id, _appVersion));
	}
	public function get trackingID():String {
		return id;
	}
	public function get appID():String {
		return handleResultFromExtension(context.call("getAppID", id), String) as String;
	}
	public function set appID(value:String):void {
		handleResultFromExtension(context.call("setAppID", id, value));
	}
	public function get anonymous():Boolean {
		return handleResultFromExtension(context.call("getAnonymous", id), Boolean) as Boolean;
	}
	public function set anonymous(value:Boolean):void {
		handleResultFromExtension(context.call("setAnonymous", id, value));
	}
	public function get secure():Boolean {
		return handleResultFromExtension(context.call("getSecure", id), Boolean) as Boolean;
	}
	public function set secure(value:Boolean):void {
		handleResultFromExtension(context.call("setSecure", id, value));
	}
	public function get sampleRate():Number {
		return handleResultFromExtension(context.call("getSampleRate", id), Number) as Number;
	}
	public function set sampleRate(value:Number):void {
		handleResultFromExtension(context.call("setSampleRate", id, Math.max(0, Math.min(100, value))));
	}
	public function startNewSession():void {
		handleResultFromExtension(context.call("setSessionControl", id, "start"));
		_sessionStarted = true;
	}
	public function setCustomMetric(index:uint, value:int):void {
		if (index == 0)
			throw new ArgumentError("Metrics and Dimensions indexes are 1-based.");

		handleResultFromExtension(context.call("setCustomMetric", id, index, value));
	}
	public function setCustomDimension(index:uint, value:String):void {
		if (index == 0)
			throw new ArgumentError("Metrics and Dimensions indexes are 1-based.");

		handleResultFromExtension(context.call("setCustomDimension", id, index, value));
	}
	public function clearCustomDimension(index:uint):void {
		if (index == 0)
			throw new ArgumentError("Metrics and Dimensions indexes are 1-based.");

		handleResultFromExtension(context.call("clearCustomDimension", id, index));
	}
	public function clearCustomMetric(index:uint):void {
		if (index == 0)
			throw new ArgumentError("Metrics and Dimensions indexes are 1-based.");

		handleResultFromExtension(context.call("clearCustomDimension", id, index));
	}
	public function send(data:Hit):void {
		_lockAppData = true;
		handleResultFromExtension(context.call("trackData", id, data.type.name, data));
		if (_sessionStarted) {
			handleResultFromExtension(context.call("setSessionControl", id, null));
			_sessionStarted = false;
		}
	}
	public function buildView(screenName:String):IViewBuilder {
		return new ViewBuilder(this, screenName);
	}
	public function buildEvent(category:String, action:String):IEventBuilder {
		return new EventBuilder(this, category, action);
	}
	public function buildException(fatal:Boolean):IExceptionBuilder {
		return new ExceptionBuilder(this, fatal);
	}
	public function buildTiming(category:String, interval:uint):ITimingBuilder {
		return new TimingBuilder(this, category, interval);
	}
	public function buildSocial(network:String, action:String):ISocialBuilder {
		return new SocialBuilder(this, network, action);
	}
	public function buildTransaction(id:String, cost:Number):ITransactionBuilder {
		return new TransactionBuilder(this, id, cost);
	}
	public function dispose():void {
		handleResultFromExtension(context.call("closeTracker", id));
		context = null;
	}
	private function parseAppDescriptor():void {
		const descriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
		const ns:Namespace = descriptor.namespace();
		if (appID == null) appID = descriptor.ns::id[0];
		appName = descriptor.ns::filename[0] || "";
		appVersion = descriptor.ns::versionLabel[0] || "";
	}
}
}
