//
//  WeatherCurrentMod.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 24.08.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import RealmSwift
import SwiftyJSON
import ObjectMapper


class WeatherCurrentMod: Object, Mappable {

	//MARK: Create Realm Obj. from JSON
	class func createObject (json: JSON) -> WeatherCurrentMod? {
		var valueToReturn: WeatherCurrentMod?
		//convert the JSON to a raw String // from SwiftyJSON
		//valueToReturn = Mapper<WeatherCurrentMod>().map(json.dictionaryObject)

		if let jsonString = json.rawString() {
			let context = self.Context(inputJsonString: jsonString)
			valueToReturn = Mapper<WeatherCurrentMod>(context: context).map(jsonString)
		}
		return valueToReturn
	}



//MARK: Internal function of class

	 dynamic var city: WeatherCityMod?
	dynamic var weatherMain: String = ""
//	let weatherDescription: String
//	let weatherIcon: String?
	dynamic var base: String = ""
//	let mainTemp: Double
//	let mainPressure: Int
//	let mainHumidity: Int
//	let mainTempMin: Double
//	let mainTempMax: Double
//	let windSpeed: Int
//	let windDeg: Int
//	let rain3h: Double?
//	let snow3h: Double?
//	let dt: Int
//	let sysType: String
//	let sysId: Int
//	let sysMessage: String
//	//	let sysCountry: String
//	let sysSunrise: Int
//	let sysSunset: Int

	struct Context: MapContext {
		var inputJsonString: String?
	}

	required convenience init?(_ map: Map) {
		self.init()
		//mapping(map)
	}

	func mapping(map: Map) {
		if let context = map.context as? Context {
			city = WeatherCityMod.createObject(context.inputJsonString)//map["city"]
		}

		weatherMain   <- map["weather.0.main"]
		base					<- map["base"]
	}
	//static func objectForMapping(map: Map) -> Mappable? // Optional


//	init(json: JSON) throws {
//
////		city = try WeatherCity(jsonCurrent: json)
////
////*		weatherMain					= json["weather"][0]["main"].stringValue
////		weatherDescription	= json["weather"][0]["description"].stringValue
////		weatherIcon					= json["weather"][0]["icon"].stringValue
////		base								= json["base"].stringValue
////		mainTemp						= json["main"]["temp"].doubleValue
////		mainPressure				= json["main"]["pressure"].intValue
////		mainHumidity				= json["main"]["humidity"].intValue
////		mainTempMin					= json["main"]["temp_min"].doubleValue
////		mainTempMax					= json["main"]["temp_max"].doubleValue
////		windSpeed						= json["wind"]["speed"].intValue
////		windDeg							= json["wind"]["deg"].intValue
////		rain3h							= json["rain"]["3h"].doubleValue
////		snow3h							= json["snow"]["3h"].doubleValue
////		dt									= json["dt"].intValue
////		sysType							= json["sys"]["type"].stringValue
////		sysId								= json["sys"]["id"].intValue
////		sysMessage					= json["sys"]["message"].stringValue
////		//sysCountry					= city.country!
////		sysSunrise					= json["sys"]["sunrise"].intValue
////		sysSunset						= json["sys"]["sunset"].intValue
//
//	}



}
