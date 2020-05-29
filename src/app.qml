ActivityManager {
	id: root;
	property int contextWidth: context.width;
	property int contextHeight: context.height;
	anchors.fill: context;
	clip: true;

	Rectangle {
		anchors.fill: parent;
		color: "#141414";
	}

	AppApi { id: api; }
	AnotherApi { id: anotherApi; }

	//@using { src.MosaicPage }
	LazyActivity { name: "mosaic"; component: "src.MosaicPage"; }

	onCompleted: {
		this.push("mosaic")
	}
}
