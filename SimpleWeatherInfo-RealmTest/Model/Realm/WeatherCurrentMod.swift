////
////  WeatherCurrentMod.swift
////  SimpleWeatherInfo-RealmTest
////
////  Created by Nikolay Dementiev on 24.08.16.
////  Copyright © 2016 mc373. All rights reserved.
////
//
//import RealmSwift
//import SwiftyJSON
//import ObjectMapper
//
//class WeatherCurrentMod: Object, Mappable {
//
//	var realmInstance: RealmUtil?
//
//	//MARK: Create Realm Obj. from JSON
//	class func createObject (json: JSON) -> WeatherCurrentMod? {
//		var valueToReturn: WeatherCurrentMod?
//		//convert the JSON to a raw String // from SwiftyJSON
//		//valueToReturn = Mapper<WeatherCurrentMod>().map(json.dictionaryObject)
//
//		if let jsonString = json.rawString() {
//			let context = self.Context(inputJsonString: jsonString)
//			valueToReturn = Mapper<WeatherCurrentMod>(context: context).map(jsonString)
//		}
//		return valueToReturn
//	}
//
//	class func createObjectAndGetUUID (json: JSON) -> String? {
//
//		var valueToReturn: String?
//		if let realmObject = createObject (json) {
//			valueToReturn = realmObject.uuid
//		}
//
//		return valueToReturn
//	}
//
//	//MARK: Internal function of class
//
//	dynamic var city: WeatherCityMod?
//
//	//dynamic var cityUuid: String? = ""
//	dynamic var uuid: String? = ""
//
//	dynamic var dateOfCreation: NSDate?
//	dynamic var weatherMain: String = ""
//	dynamic var weatherDescription: String = ""
//	dynamic var weatherIcon: String?
//	dynamic var base: String = ""
//	dynamic var mainTemp: Double = 0
//	dynamic var mainPressure: Double = 0
//	dynamic var mainHumidity: Double = 0
//	dynamic var mainTempMin: Double = 0
//	dynamic var mainTempMax: Double = 0
//	dynamic var windSpeed: Double = 0
//	dynamic var windDeg: Double = 0
//	let rain3h: RealmOptional<Double> = RealmOptional()
//	let snow3h: RealmOptional<Double> = RealmOptional()
//	dynamic var dt: NSDate?
//	dynamic var sysType: String = ""
//	dynamic var sysId: Int = 0
//	dynamic var sysMessage: String = ""
//	dynamic var sysSunrise: NSDate?
//	dynamic var sysSunset: NSDate?
//
//	struct Context: MapContext {
//		var inputJsonString: String?
//	}
//
//	override static func primaryKey() -> String? {
//		return "uuid"
//	}
//
//	override static func indexedProperties() -> [String] {
//		return ["uuid,dateOfCreation"]
//	}
//
//	required convenience init?(_ map: Map) {
//		self.init()
//	}
//
//	func mapping(map: Map) {
//
//		realmInstance = RealmUtil.sharedInstance
//
//		if let context = map.context as? Context {
//
//			city = WeatherCityMod.createObject(context.inputJsonString)
//			RealmUtil.saveRealmObject(realmInstance?.realm, object: city)
//		}
//
//		uuid								= NSUUID().UUIDString
//		dateOfCreation			= NSDate()
//		weatherMain					<- map["weather.0.main"]
//		weatherIcon					<- map["weather.0.icon"]
//		weatherDescription	<- map["weather.0.description"]
//		base								<- map["base"]
//		mainTemp						<- map["main.temp"]
//		mainPressure				<- map["main.pressure"]
//		mainHumidity				<- map["main.humidity"]
//		mainTempMin					<- map["main.temp_min"]
//		mainTempMax					<- map["main.temp_max"]
//		windSpeed						<- map["wind.speed"]
//		windDeg							<- map["wind.deg"]
//		rain3h.value				<- map["rain.3h"]
//		snow3h.value				<- map["snow.3h"]
//		dt									<- (map["dt"], DateTransform())
//		sysType							<- map["sys.type"]
//		sysId								<- map["sys.id"]
//		sysMessage					<- map["sys.message"]
//		sysSunrise					<- (map["sys.sunrise"], DateTransform())
//		sysSunset						<- (map["sys.sunset"], DateTransform())
//
//		RealmUtil.saveRealmObject(realmInstance?.realm, object: self)
//	}
//
//}
