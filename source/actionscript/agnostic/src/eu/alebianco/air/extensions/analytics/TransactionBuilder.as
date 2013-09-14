/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 12.10
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;
import eu.alebianco.air.extensions.analytics.api.IProductBuilder;
import eu.alebianco.air.extensions.analytics.api.ITransactionBuilder;

internal class TransactionBuilder implements ITransactionBuilder {

    internal static const VALID_CURRENCIES:String = "USD,AED,ARS,AUD,BGN,BOB,BRL,CAD,CHF,CLP,CNY,COP,CZK,DKK,EGP,EUR,FRF,GBP,HKD,HRK,HUF,IDR,ILS,INR,JPY,KRW,LTL,MAD,MXN,MYR,NOK,NZD,PEN,PHP,PKR,PLN,RON,RSD,RUB,SAR,SEK,SGD,THB,TRL,TWD,UAH,VEF,ND,ZAR";

	private var tracker:Tracker;

	internal var id:String;
	internal var revenue:Number;
	internal var affiliation:String;
	internal var shipping:Number;
	internal var tax:Number;
    internal var currency:String;

	private var _products:Array;

	internal function get products():Array {
		return _products ||= [];
	}

	public function TransactionBuilder(tracker:Tracker, id:String, affiliation:String, revenue:Number, tax:Number, shipping:Number) {
		this.tracker = tracker;
		this.id = id;
        this.affiliation = affiliation;
		this.revenue = revenue;
        this.tax = tax;
        this.shipping = shipping;
	}

    public function forCurrency(code:String):ITransactionBuilder {
        if (VALID_CURRENCIES.split(",").indexOf(code) == -1) {
            throw new ArgumentError("Specified currency is not valid.");
        }
        this.currency = code;
        return this;
    }

    public function createProduct(sku:String, name:String, price:Number, quantity:uint):IProductBuilder {
		return new ProductBuilder(this, this.id, sku, name, price, quantity);
	}

	public function create():Hit {
		return new Transaction(this);
	}

	public function track():void {
        tracker.send(create());
	}
}
}
