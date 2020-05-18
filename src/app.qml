ActivityManager {
	id: root;
	property int contextWidth: context.width;
	property int contextHeight: context.height;
	anchors.fill: context;
	clip: true;

	AppApi { id: api; }
	AnotherApi { id: anotherApi; }

	//@using { src.MosaicPage }
	LazyActivity { name: "mosaic"; component: "src.MosaicPage"; }

	onCompleted: {
		this._context.document.dom.body.style.backgroundColor = "#424242"
		this.push("mosaic")
	}
}
