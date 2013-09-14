/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 14.12
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.core.Enum;

public class HitType extends Enum {
	{
		initEnum(HitType);
	}

	public static const EVENT:HitType = new HitType("event");
	public static const APP_VIEW:HitType = new HitType("appview");
	public static const TRANSACTION:HitType = new HitType("transaction");
	public static const EXCEPTION:HitType = new HitType("exception");
	public static const SOCIAL:HitType = new HitType("social");
	public static const TIMING:HitType = new HitType("timing");

	public static function getConstants():Vector.<HitType> {
		return Vector.<HitType>(Enum.getConstants(HitType));
	}
	public static function parseConstant(constantName:String, caseSensitive:Boolean = false):HitType {
		return HitType(Enum.parseConstant(HitType, constantName, caseSensitive));
	}

    private var _key:String;

	public function HitType(key:String) {
		super();
        this._key = key
	}

    internal function get key():String {
        return _key;
    }

	override public function toString():String {
		return "[HitType (name: " + name + ")]";
	}
}
}
