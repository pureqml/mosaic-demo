Rest {
	baseUrl: "https://api.start.ru";
	property string apiKey: "a20b12b279f744f2b3c7b5c5400c4eb5";

	Method {
		name: "getMain";
		path: "/web/main?apikey=" + parent.apiKey;
	}
}
