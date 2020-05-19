Activity {
	anchors.fill: parent;
	name: "mosaic";

	Mosaic {
		id: mosaicGrid;
		x: 5%;
		y: 5%;
		width: 90%;
		height: 95%;
		animationDuration: 300;
		keyProcessDelay: 300;

		onCurrentIndexChanged: { embedVideo.hide() }

		onBackPressed: { this.focusIndex(this.currentIndex) }

		onPlay(idx): {
			embedVideo.x = 0
			embedVideo.y = 0
			embedVideo.width = root.width
			embedVideo.height = root.height
		}

		focusIndex(idx): {
			var row = this.model.get(idx)
			var item = this.getItemPosition(idx)
			var x = mosaicGrid.x + item[0] - mosaicGrid.contentX - this.x / 10
			var y = mosaicGrid.y + item[1] - mosaicGrid.contentY
			embedVideo.width = mosaicGrid.cellWidth
			embedVideo.height = mosaicGrid.cellHeight
			embedVideo.showPlayerAt(x, y)
			embedVideo.source = row.video
		}

		onItemFocused(idx): { this.focusIndex(idx) }
	}

	NestedVideo {
		id: embedVideo;
		loop: true;

		ClickMixin { }

		onClicked: { mosaicGrid.play(mosaicGrid.currentIndex) }

		Behavior on x, y, width, height { Animation { duration: 300; } }
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
