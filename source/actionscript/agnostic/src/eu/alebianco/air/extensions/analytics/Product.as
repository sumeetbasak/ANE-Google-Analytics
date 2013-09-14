/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 11.47
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.IProduct;

internal class Product implements IProduct {

    private static const ID_VALIDATOR:RegExp = /.+/i;
    private static const SKU_VALIDATOR:RegExp = /.+/i;
    private static const NAME_VALIDATOR:RegExp = /.+/i;

	private var _id:String;
	private var _sku:String;
	private var _name:String;
	private var _price:Number;
	private var _quantity:uint;
	private var _category:String;
	private var _currency:String;

	public function Product(builder:ProductBuilder) {

        if (!(builder.id && ID_VALIDATOR.test(builder.id)))
            throw new ArgumentError("Transaction ID is invalid: must be not null or a empty string.");

		if (!(builder.sku && SKU_VALIDATOR.test(builder.sku)))
			throw new ArgumentError("Product sku is invalid: must be not null or a empty string.");

		if (!(builder.name && NAME_VALIDATOR.test(builder.name)))
			throw new ArgumentError("Product name is invalid: must be not null or a empty string.");

		_id = builder.id;
		_sku = builder.sku;
		_name = builder.name;
		_price = builder.price;
		_quantity = builder.quantity;
		_category = builder.category;
		_currency = builder.currency;
	}

	public function get id():String {
		return _id;
	}
	public function get sku():String {
		return _sku;
	}
	public function get name():String {
		return _name;
	}
	public function get price():Number {
		return _price;
	}
	public function get quantity():uint {
		return _quantity;
	}
	public function get category():String {
		return _category;
	}
	public function get currency():String {
		return _currency;
	}
}
}
