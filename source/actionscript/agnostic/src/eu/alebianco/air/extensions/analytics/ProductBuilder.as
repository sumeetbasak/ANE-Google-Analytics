/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 11.45
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.IProduct;
import eu.alebianco.air.extensions.analytics.api.IProductBuilder;
import eu.alebianco.air.extensions.analytics.api.ITransactionBuilder;

internal class ProductBuilder implements IProductBuilder {

	private var transaction:TransactionBuilder;

    internal var id:String;
	internal var sku:String;
	internal var name:String;
	internal var price:Number;
	internal var quantity:uint;
	internal var category:String = null;
    internal var currency:String = null;

	public function ProductBuilder(transaction:TransactionBuilder, id:String, sku:String, name:String, price:Number, quantity:uint) {
		this.transaction = transaction;

        this.id = id;
		this.sku = sku;
		this.name = name;
		this.price = price;
		this.quantity = quantity;
	}

	public function inCategory(category:String):IProductBuilder {
		this.category = category;
		return this;
	}

    public function forCurrency(code:String):IProductBuilder {
        if (TransactionBuilder.VALID_CURRENCIES.split(",").indexOf(code) == -1) {
            throw new ArgumentError("Specified currency is not valid.");
        }
        this.currency = code;
        return this;
    }

	public function create():IProduct {
		return new Product(this);
	}

	public function add():ITransactionBuilder {
		transaction.products.push(create());
		return transaction;
	}
}
}
