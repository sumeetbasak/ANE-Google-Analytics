/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 12.13
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;

internal class Transaction implements Hit {

	private static const ID_VALIDATOR:RegExp = /.+/i;

	private var _id:String;
	private var _revenue:Number;
	private var _affiliation:String;
	private var _shipping:Number;
	private var _tax:Number;
    private var _currency:String;
    private var _products:Array;

    public function get type():HitType {
        return HitType.TRANSACTION;
    }

    public function Transaction(builder:TransactionBuilder) {

		if (!(builder.id && ID_VALIDATOR.test(builder.id)))
			throw new ArgumentError("Transaction ID is invalid: must be not null or a empty string.");

		_id = builder.id;
		_revenue = builder.revenue;
		_affiliation = builder.affiliation;
		_shipping = builder.shipping;
		_tax = builder.tax;
		_products = builder.products;
		_currency = builder.currency;
	}

	public function get id():String {
		return _id;
	}
	public function get revenue():Number {
		return _revenue;
	}
	public function get affiliation():String {
		return _affiliation;
	}
	public function get shipping():Number {
		return _shipping;
	}
	public function get tax():Number {
		return _tax;
	}
	public function get currency():String {
		return _currency;
	}
	public function get products():Array {
		return _products;
	}
}
}
