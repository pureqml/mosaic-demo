Activity {
	id: mosaicPageProto;
	property int delegateRadius: 10s;
	anchors.fill: parent;
	name: "mosaic";

	Item {
		width: 100%;
		height: 100%;

		OverflowMixin { value: OverflowMixin.ScrollY; }

		Mosaic {
			id: mosaicGrid;
			y: 5%;
			x: 5%;
			width: 90%;
			height: contentHeight;
			animationDuration: 300;
			keyProcessDelay: 300;
			delegateRadius: mosaicPageProto.delegateRadius;
			highlight: NestedVideo {
				radius: parent.delegateRadius;
				effects.shadow.blur: 10;
				effects.shadow.color: "#8AF";
				effects.shadow.spread: 2;
				border.width: 1;
				border.color: "#8AF";
				z: display ? 1 : 0;

				ClickMixin { }

				onClicked: { mosaicGrid.play(mosaicGrid.currentIndex) }

				Behavior on x, y, width, height { Animation { duration: 300; } }
			}

			OverflowMixin { value: OverflowMixin.Visible; }

			onPlay(idx): {
				if (videoPlayer.ready)
					Modernizr.prefixed('requestFullscreen', videoPlayer.element.dom)()
			}

			onCurrentIndexChanged: { this.highlight.hide() }

			onBackPressed: { this.focusIndex(this.currentIndex) }

			focusIndex(idx): {
				var row = this.model.get(idx)
				this.highlight.showAndPlay(row.video)
			}

			onItemFocused(idx): { this.focusIndex(idx) }
		}
	}

	init: {
		// api.getMain(
		// 	function(res) {
		// 		mosaicGrid.fill(res[0].items, function(row) {
		// 			if (row.thumbnail.image_15x) {
		// 				return {
		// 					video: api.baseUrl + row.video_cover,
		// 					preview: api.baseUrl + row.thumbnail.image_15x,
		// 					title: row.title,
		// 					icon: api.baseUrl + row.logotype.image_15x
		// 				}
		// 			} else {
		// 				return null
		// 			}
		// 		})
		// 	},
		// 	function(e) { log("Failed to get content", e) }
		// )

		anotherApi.getMain(
			function(res) {
				mosaicGrid.fill(res.element.collectionItems.items, function(row) {
					if (row.element.basicCovers.items && row.element.basicCovers.items.length > 0) {
						var videoUrl = ""
						var trailers = row.element.trailers.items
						for (var i in trailers) {
							if (trailers[i].media.mimeType.indexOf("mp4") >= 0) {
								videoUrl = trailers[i].url
								break
							}
						}
						return {
							video: videoUrl,
							preview: row.element.basicCovers.items[0].url,
							title: row.element.name
						}
					} else {
						return null
					}
				})
			},
			function(e) { log("Failed to get content", e) }
		)
	}
}
