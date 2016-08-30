////
////  WeatherCurrent.swift
////  SimpleWeatherInfo-RealmTest
////
////  Created by Nikolay Dementiev on 28.07.16.
////  Copyright © 2016 mc373. All rights reserved.
////
//
//

import SwiftyJSON
import RealmSwift

struct WeatherCurrent {
	let realmObjectUUID: String?

	init(json: JSON) {
		realmObjectUUID = WeatherCurrentMod.createObjectAndGetUUID(json)
	}

	func getRepresentOfObject() -> [CellDataTemp] {
		var valueForReturn: [CellDataTemp] = []

		guard let tempRealmObjectUUID = realmObjectUUID where !tempRealmObjectUUID.isEmpty else {return valueForReturn}

		if let tmpRealm = RealmUtil.getRealmObj(nil) {

			let predicate = NSPredicate(format: "uuid = %@", tempRealmObjectUUID)
			let currentWeatherThatExists = tmpRealm.objects(WeatherCurrentMod.self).filter(predicate)
			if currentWeatherThatExists.count > 0 {
				let cWeather: WeatherCurrentMod = currentWeatherThatExists.first!

				valueForReturn.append(CellDataTemp(k: "City ID", v: cWeather.city!.id.getStringFormat()))
				valueForReturn.append(CellDataTemp(k: "City name", v: cWeather.city!.name ?? ""))
				valueForReturn.append(CellDataTemp(k: "Country code", v: cWeather.city!.country!))
				valueForReturn.append(CellDataTemp(k: "City geo location, longitude", v: cWeather.city!.coordLon.value!.getStringFormat(4)))
				valueForReturn.append(CellDataTemp(k: "City geo location, latitude", v: cWeather.city!.coordLat.value!.getStringFormat(4)))

				valueForReturn.append(CellDataTemp(k: "Group of weather parameters", v: cWeather.weatherMain))
				valueForReturn.append(CellDataTemp(k: "Weather condition within the group", v: cWeather.weatherDescription))
				valueForReturn.append(CellDataTemp(k: "Weather icon id", v: cWeather.weatherIcon!))
				valueForReturn.append(CellDataTemp(k: "Internal parameter (base)", v: cWeather.base))
				valueForReturn.append(CellDataTemp(k: "Temperature, C", v: cWeather.mainTemp.getStringFormat(2)))
				valueForReturn.append(CellDataTemp(k: "Atmospheric pressure, hPa", v: cWeather.mainPressure.getStringFormat(2)))
				valueForReturn.append(CellDataTemp(k: "Humidity, %", v: cWeather.mainHumidity.getStringFormat()))
				valueForReturn.append(CellDataTemp(k: "Minimum temp. now", v: cWeather.mainTempMin.getStringFormat(2)))
				valueForReturn.append(CellDataTemp(k: "Maximum temp. now", v: cWeather.mainTempMax.getStringFormat(2)))
				valueForReturn.append(CellDataTemp(k: "Wind speed. (meter/sec)", v: cWeather.windSpeed.getStringFormat(2)))
				valueForReturn.append(CellDataTemp(k: "Wind direction, degrees", v: cWeather.windDeg.getStringFormat(2)))
				valueForReturn.append(CellDataTemp(k: "Rain volume for the last 3 hours", v: (cWeather.rain3h.value ?? 00).getStringFormat(4)))
				valueForReturn.append(CellDataTemp(k: "Snow volume for the last 3 hours", v: (cWeather.snow3h.value ?? 00).getStringFormat(4)))
				valueForReturn.append(CellDataTemp(k: "Time of data calculation, UTC", v: cWeather.dt!.parseDate() ))
				valueForReturn.append(CellDataTemp(k: "Internal parameter (type)", v: cWeather.sysType))
				valueForReturn.append(CellDataTemp(k: "Internal parameter (id)", v: cWeather.sysId.getStringFormat()))
				valueForReturn.append(CellDataTemp(k: "Internal parameter (message)", v: cWeather.sysMessage))

				let parserString = "HH:mm:ss"
				valueForReturn.append(CellDataTemp(k: "Sunrise time, UTC", v: cWeather.sysSunrise!.parseDate(parserString) ))
				valueForReturn.append(CellDataTemp(k: "Sunset time, UTC", v: cWeather.sysSunset!.parseDate(parserString) ))

			}
		}

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
