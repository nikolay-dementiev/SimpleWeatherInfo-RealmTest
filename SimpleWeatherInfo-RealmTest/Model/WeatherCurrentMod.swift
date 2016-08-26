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

//	var realmInstance: RealmUtil? = RealmUtil.sharedInstance

	//MARK: Create Realm Obj. from JSON
	class func createObject (json: JSON) -> WeatherCurrentMod? {
		var valueToReturn: WeatherCurrentMod?
		//convert the JSON to a raw String // from SwiftyJSON
		//valueToReturn = Mapper<WeatherCurrentMod>().map(json.dictionaryObject)

		if let jsonString = json.rawString() {
			let context = self.Context(inputJsonString: jsonString)
			valueToReturn = Mapper<WeatherCurrentMod>(context: context).map(jsonString)

			// Realms are used to group data together

		}
		return valueToReturn
	}


	//MARK: Internal function of class

	dynamic var city: WeatherCityMod?
	dynamic var weatherMain: String = ""
	dynamic var weatherDescription: String = ""
	dynamic var weatherIcon: String?
	dynamic var base: String = ""
	dynamic var mainTemp: Double = 0
	dynamic var mainPressure: Double = 0
	dynamic var mainHumidity: Double = 0
	dynamic var mainTempMin: Double = 0
	dynamic var mainTempMax: Double = 0
	dynamic var windSpeed: Double = 0
	dynamic var windDeg: Double = 0
	let rain3h: RealmOptional<Double> = RealmOptional()
	let snow3h: RealmOptional<Double> = RealmOptional()
	dynamic var dt: NSDate?
	dynamic var sysType: String = ""
	dynamic var sysId: Int = 0
	dynamic var sysMessage: String = ""
	dynamic var sysSunrise: NSDate?
	dynamic var sysSunset: NSDate?

	struct Context: MapContext {
		var inputJsonString: String?
	}

//	override static func ignoredProperties() -> [String] {
//		return ["realmInstance"]
//	}

	required convenience init?(_ map: Map) {
		self.init()
		//mapping(map)
	}

	func mapping(map: Map) {

		if let context = map.context as? Context {
			city = WeatherCityMod.createObject(context.inputJsonString)//map["city"]
		}

		weatherMain					<- map["weather.0.main"]
		weatherIcon					<- map["weather.0.icon"]
		weatherDescription	<- map["weather.0.description"]
		base								<- map["base"]
		mainTemp						<- map["main.temp"]
		mainPressure				<- map["main.pressure"]
		mainHumidity				<- map["main.humidity"]
		mainTempMin					<- map["main.temp_min"]
		mainTempMax					<- map["main.temp_max"]
		windSpeed						<- map["wind.speed"]
		windDeg							<- map["wind.deg"]
		rain3h.value				<- map["rain.3h"]
		snow3h.value				<- map["snow.3h"]
		dt									<- (map["dt"], DateTransform())
		sysType							<- map["sys.type"]
		sysId								<- map["sys.id"]
		sysMessage					<- map["sys.message"]
		sysSunrise					<- (map["sys.sunrise"], DateTransform())
		sysSunset						<- (map["sys.sunset"], DateTransform())

//		let arrayOfData: [Object] = [self.city!, self]
//		realmInstance?.saveCurrentObject(arrayOfData)

		saveRealmObject()
	}

	func saveRealmObject() {
		let realm = try! Realm()

		realm.beginWrite()
		if let cityT = city {
			realm.add(cityT)
		}

		realm.add(self)

		try! realm.commitWrite()
	}

	func getRepresentOfObject() -> [CellDataTemp] {
		var valueForReturn: [CellDataTemp] = []

		valueForReturn.append(CellDataTemp(k: "City ID", v: self.city!._id.getStringFormat()))
		valueForReturn.append(CellDataTemp(k: "City name", v: self.city!.name ?? ""))
		valueForReturn.append(CellDataTemp(k: "Country code", v: self.city!.country!))
		valueForReturn.append(CellDataTemp(k: "City geo location, longitude", v: self.city!.coordLon.value!.getStringFormat(4)))
		valueForReturn.append(CellDataTemp(k: "City geo location, latitude", v: self.city!.coordLat.value!.getStringFormat(4)))
		valueForReturn.append(CellDataTemp(k: "Group of weather parameters", v: self.weatherMain))
		valueForReturn.append(CellDataTemp(k: "Weather condition within the group", v: self.weatherDescription))
		valueForReturn.append(CellDataTemp(k: "Weather icon id", v: self.weatherIcon!))
		valueForReturn.append(CellDataTemp(k: "Internal parameter (base)", v: self.base))
		valueForReturn.append(CellDataTemp(k: "Temperature, C", v: self.mainTemp.getStringFormat(2)))
		valueForReturn.append(CellDataTemp(k: "Atmospheric pressure, hPa", v: self.mainPressure.getStringFormat(2)))
		valueForReturn.append(CellDataTemp(k: "Humidity, %", v: self.mainHumidity.getStringFormat()))
		valueForReturn.append(CellDataTemp(k: "Minimum temp. now", v: self.mainTempMin.getStringFormat(2)))
		valueForReturn.append(CellDataTemp(k: "Maximum temp. now", v: self.mainTempMax.getStringFormat(2)))
		valueForReturn.append(CellDataTemp(k: "Wind speed. (meter/sec)", v: self.windSpeed.getStringFormat(2)))
		valueForReturn.append(CellDataTemp(k: "Wind direction, degrees", v: self.windDeg.getStringFormat(2)))
		valueForReturn.append(CellDataTemp(k: "Rain volume for the last 3 hours", v: self.rain3h.value!.getStringFormat(4)))
		valueForReturn.append(CellDataTemp(k: "Snow volume for the last 3 hours", v: self.snow3h.value!.getStringFormat(4)))
		valueForReturn.append(CellDataTemp(k: "Time of data calculation, UTC", v: self.dt!.getStringFormat()))
		valueForReturn.append(CellDataTemp(k: "Internal parameter (type)", v: self.sysType))
		valueForReturn.append(CellDataTemp(k: "Internal parameter (id)", v: self.sysId.getStringFormat()))
		valueForReturn.append(CellDataTemp(k: "Internal parameter (message)", v: self.sysMessage))
		valueForReturn.append(CellDataTemp(k: "Sunrise time, UTC", v: self.sysSunrise!.getStringFormat()))
		valueForReturn.append(CellDataTemp(k: "Sunset time, UTC", v: self.sysSunset!.getStringFormat()))

		return valueForReturn
		}

}

private	extension Int {
	func getStringFormat() -> String {return String(self)}
}

private	extension Double {
	func getStringFormat(digits: Int = 2) -> String {return String(format: "%.\(digits)f", self)}
}

private	extension NSDate {
	func getStringFormat() -> String {return String(self.description)}
}
