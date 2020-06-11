Activity {
	id: mosaicPageProto;
	property int delegateRadius: 10s;
	anchors.fill: parent;
	name: "mosaic";

	Item {
		width: 100%;
		height: 100%;

		//OverflowMixin { value: OverflowMixin.ScrollY; }

		Mosaic {
			y: 5%;
			x: 5%;
			width: 90%;
			animationDuration: 300;
			keyProcessDelay: 300;
			delegateRadius: mosaicPageProto.delegateRadius;
			spacing: 20s;
			playing: videoPlayer.ready;
			highlight: MosaicHighlight { }

			onPlay(idx): {
				this.focusIndex(idx)
				if (videoPlayer.ready)
					videoPlayer.fullscreen = true
			}

			onCurrentIndexChanged: { highlightVideo.hide() }

			focusIndex(idx): {
				videoPlayer.fullscreen = false
				var row = this.model.get(idx)
				highlightVideo.showAndPlay(row.video)
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
