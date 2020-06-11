NestedVideo {
	id: highlightVideo;
	opacity: videoPlayer.ready ? 1.0 : 0.0;
	radius: mosaicGrid.delegateRadius;

	effects.shadow.blur: 10;
	effects.shadow.color: "#8AF";
	effects.shadow.spread: 2;
	border.width: 1;
	border.color: "#8AF";
	z: display ? 1 : 0;

	ClickMixin { }

	onClicked: { mosaicGrid.play(mosaicGrid.currentIndex) }

	Behavior on opacity { Animation { duration: 300; } }
}
