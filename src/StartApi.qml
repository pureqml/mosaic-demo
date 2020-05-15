Rest {
	// property string deviceGuid;
	// property string token;
	// property string os: context.system.os;
	// property string deviceMac: device.macAddress;
	// property string deviceType: os == "amino" ? 1 : (context.system.device == context.system.Tv ? 5 : 2);
	// property string deviceModel: device.modelName ? device.modelName : "Amino Aria6";
	property string baseUrl: "https://api.start.ru";

	Method {
		name: "getMain";
		path: "/web/main?apikey=a20b12b279f744f2b3c7b5c5400c4eb5";
	}
// https://api.start.ru/web/main?apikey=a20b12b279f744f2b3c7b5c5400c4eb5&for_kids=false
}
