Activity {
	anchors.fill: parent;
	name: "mosaic";

	Rectangle {
		anchors.fill: parent;
		color: "#000c";
	}

	Mosaic {
		id: nowonTvGrid;
		x: 40s;
		y: 40s;
		width: 1200s;
		height: parent.height - y;
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
			var x = nowonTvGrid.x + item[0] - nowonTvGrid.contentX
			var y = nowonTvGrid.y + item[1] - nowonTvGrid.contentY
			embedVideo.width = 290
			embedVideo.height = 170
			embedVideo.showPlayerAt(x, y)
			embedVideo.source = row.video
		}

		onItemFocused(idx): { this.focusIndex(idx) }
	}

	NestedVideo {
		id: embedVideo;
		loop: true;

		Behavior on x, y, width, height { Animation { duration: 300; } }
	}

	init: {
		api.getMain(
			function(res) {
				var result = []
				for (var i in res[0].items) {
					var row = res[0].items[i]

					if (row.thumbnail.image_15x)
					result.push({
						video: api.baseUrl + row.video_cover,
						preview: api.baseUrl + row.thumbnail.image_15x,
						title: row.title,
						icon: api.baseUrl + row.logotype.image_15x
					})
				}
				nowonTvGrid.model.assign(result)
			},
			function(e) { log("Failed to get content", e) }
		)
	}
}
