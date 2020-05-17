Rest {
	baseUrl: "";
	property string apiKey: "";

	Method {
		name: "getMain";
		path: "/web/main?apikey=" + parent.apikey;
	}
}
