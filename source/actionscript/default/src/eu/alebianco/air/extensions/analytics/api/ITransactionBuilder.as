/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 11.36
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {

/**
 * Concrete builder to create and track ecommerce transactions.
 * <p>It exposes methods to setup the optional parameters for a transaction and add products to it.</p>
 */
public interface ITransactionBuilder extends IHitBuilder {

    /**
     * Sets the product's price currency.
     * @see https://developers.google.com/analytics/devguides/platform/features/currencies
     * @param code  the currency code. Must be one of the supported value.
     * @return itself
     */
    function forCurrency(code:String):IProductBuilder;
	/**
	 * Create a new Product builder.
	 * <p>The builder returned can be used to setup the optional parameters of the product and then add it to the
	 * current transaction.</p>
	 * @param sku the product SKU which uniquely identifies it. The sku cannot be null or the empty string.
	 * @param name the name of the product. The name cannot be null or the empty string.
	 * @param price the price of the product, expressed in your currency (will be translated in microns automatically).
	 * @param quantity the quantity purchased.
	 * @return a new Product builder to finalize the product creation
	 */
	function createProduct(sku:String, name:String, price:Number, quantity:uint):IProductBuilder;
}
}
