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

	private var _sessionStarted:Boolean = false;

	public function Tracker(id:String, context:ExtensionContext) {
		this.id = id;
		this.context = context;
		parseAppDescriptor();
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
	public function get appName():String {
		return handleResultFromExtension(context.call("getAppName", id), String) as String;
	}
	public function set appName(value:String):void {
		handleResultFromExtension(context.call("setAppName", id, value));
	}
	public function get appVersion():String {
		return handleResultFromExtension(context.call("getAppVersion", id), String) as String;
	}
	public function set appVersion(value:String):void {
		handleResultFromExtension(context.call("setAppVersion", id, value));
	}
	public function get clientID():String {
		return handleResultFromExtension(context.call("getClientID", id), String) as String;
	}
	public function set clientID(value:String):void {
		handleResultFromExtension(context.call("setClientID", id, value));
	}
	public function get anonymous():Boolean {
		const raw:String = handleResultFromExtension(context.call("getAnonymous", id), String) as String;
		return raw == "true";
	}
	public function set anonymous(value:Boolean):void {
		const normalized:String = value ? "true" : "false";
		handleResultFromExtension(context.call("setAnonymous", id, normalized));
	}
	public function get secure():Boolean {
		const raw:String = handleResultFromExtension(context.call("getSecure", id), String) as String;
		return raw == "true";
	}
	public function set secure(value:Boolean):void {
		const normalized:String = value ? "true" : "false";
		handleResultFromExtension(context.call("setSecure", id, normalized));
	}
	public function get sampleRate():Number {
		const raw:String = handleResultFromExtension(context.call("getSampleRate", id), String) as String;
		return Number(raw);
	}
	public function set sampleRate(value:Number):void {
		const normalized:Number = Math.max(0, Math.min(100, value));
		handleResultFromExtension(context.call("setSampleRate", id, normalized.toString()));
	}
	public function startNewSession():void {
		handleResultFromExtension(context.call("setSessionControl", id, "start"));
		_sessionStarted = true;
	}
	public function setCustomMetric(index:uint, value:int):void {
		if (index == 0)
			throw new ArgumentError("Metrics and Dimensions indexes are 1-based.");

		const normalized:String = value.toString();
		handleResultFromExtension(context.call("setCustomMetric", id, index, normalized));
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
		handleResultFromExtension(context.call("trackData", id, data.type.key, data));
		if (_sessionStarted) {
			handleResultFromExtension(context.call("setSessionControl", id, null));
			_sessionStarted = false;
		}
	}
	public function buildView(screenName:String):IViewBuilder {
		return new AppViewBuilder(this, screenName);
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
	public function buildTransaction(id:String, affiliation:String, revenue:Number, tax:Number, shipping:Number):ITransactionBuilder {
		return new TransactionBuilder(this, id, affiliation, revenue, tax, shipping);
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
