ActivityManager {
	id: root;
	property int contextWidth: context.width;
	property int contextHeight: context.height;
	width: context.system.resolutionWidth;
	height: context.system.resolutionHeight;
	clip: true;

	AppApi { id: api; }

	//@using { src.MosaicPage }
	LazyActivity { name: "mosaic"; component: "src.MosaicPage"; }

	onCompleted: { this.push("mosaic") }
}
