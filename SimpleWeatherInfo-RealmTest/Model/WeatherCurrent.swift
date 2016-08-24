//
//  WeatherCurrent.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 28.07.16.
//  Copyright © 2016 mc373. All rights reserved.
//


import SwiftyJSON

struct WeatherCurrent {

	let city: WeatherCity
	let weatherMain: String
	let weatherDescription: String
	let weatherIcon: String?
	let base: String
	let mainTemp: Double
	let mainPressure: Int
	let mainHumidity: Int
	let mainTempMin: Double
	let mainTempMax: Double
	let windSpeed: Int
	let windDeg: Int
	let rain3h: Double?
	let snow3h: Double?
	let dt: Int
	let sysType: String
	let sysId: Int
	let sysMessage: String
//	let sysCountry: String
	let sysSunrise: Int
	let sysSunset: Int


	init(json: JSON) throws {

		city = try WeatherCity(jsonCurrent: json)

		weatherMain					= json["weather"][0]["main"].stringValue
		weatherDescription	= json["weather"][0]["description"].stringValue
		weatherIcon					= json["weather"][0]["icon"].stringValue
		base								= json["base"].stringValue
		mainTemp						= json["main"]["temp"].doubleValue
		mainPressure				= json["main"]["pressure"].intValue
		mainHumidity				= json["main"]["humidity"].intValue
		mainTempMin					= json["main"]["temp_min"].doubleValue
		mainTempMax					= json["main"]["temp_max"].doubleValue
		windSpeed						= json["wind"]["speed"].intValue
		windDeg							= json["wind"]["deg"].intValue
		rain3h							= json["rain"]["3h"].doubleValue
		snow3h							= json["snow"]["3h"].doubleValue
		dt									= json["dt"].intValue
		sysType							= json["sys"]["type"].stringValue
		sysId								= json["sys"]["id"].intValue
		sysMessage					= json["sys"]["message"].stringValue
		//sysCountry					= city.country!
		sysSunrise					= json["sys"]["sunrise"].intValue
		sysSunset						= json["sys"]["sunset"].intValue

	}


	func getRepresentOfObject() -> [String: String] {

		var dictOfRepresent = [String: String]()

		dictOfRepresent.updateValue(self.city._id.getStringFormat(0), forKey: "City ID")
		dictOfRepresent.updateValue(self.city.name ?? "", forKey: "City name")
		dictOfRepresent.updateValue(self.city.country!, forKey: "Country code (GB, JP etc.)")
		dictOfRepresent.updateValue(self.city.coordLon!.getStringFormat(4), forKey: "City geo location, longitude")
		dictOfRepresent.updateValue(self.city.coordLat!.getStringFormat(4), forKey: "City geo location, latitude")
		dictOfRepresent.updateValue(self.weatherMain, forKey: "Group of weather parameters")
		dictOfRepresent.updateValue(self.weatherDescription, forKey: "Weather condition within the group")
		dictOfRepresent.updateValue(self.weatherIcon!, forKey: "Weather icon id")
		dictOfRepresent.updateValue(self.base, forKey: "Internal parameter (base)")

		dictOfRepresent.updateValue(self.mainTemp.getStringFormat(2), forKey:"Temperature (celsius)")
		dictOfRepresent.updateValue(self.mainPressure.getStringFormat(2), forKey: "Atmospheric pressure, hPa")
		dictOfRepresent.updateValue(self.mainHumidity.getStringFormat(0), forKey: "Humidity, %")
		dictOfRepresent.updateValue(self.mainTempMin.getStringFormat(2), forKey: "Minimum temp. now")
		dictOfRepresent.updateValue(self.mainTempMax.getStringFormat(2), forKey: "Maximum temp. now")
		dictOfRepresent.updateValue(self.windSpeed.getStringFormat(0), forKey: "Wind speed. (meter/sec)")
		dictOfRepresent.updateValue(self.windDeg.getStringFormat(0), forKey: "Wind direction, degrees")
		dictOfRepresent.updateValue(self.rain3h!.getStringFormat(4), forKey: "Rain volume for the last 3 hours")
		dictOfRepresent.updateValue(self.snow3h!.getStringFormat(4), forKey: "Snow volume for the last 3 hours")
		dictOfRepresent.updateValue(self.dt.getStringFormat(0), forKey: "Time of data calculation, UTC")
		dictOfRepresent.updateValue(self.sysType, forKey: "Internal parameter (type)")
		dictOfRepresent.updateValue(self.sysId.getStringFormat(0), forKey: "Internal parameter (id)")
		dictOfRepresent.updateValue(self.sysMessage, forKey: "Internal parameter (message)")

		dictOfRepresent.updateValue(self.sysSunrise.getStringFormat(0), forKey: "Sunrise time, UTC")
		dictOfRepresent.updateValue(self.sysSunset.getStringFormat(0), forKey: "Sunset time, UTC")

		return dictOfRepresent
	}

}

private	extension Int {
	func getStringFormat(digits: Int = 2) -> String {return String(self)}
}

private	extension Double {
	func getStringFormat(digits: Int = 2) -> String {return String(format: "%.\(digits)f", self)}
}
