
class Reset extends Button{

	float centreX;
	float centreY;
	float strokeW;

	public Reset(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreX = posX + w/2;
		centreY = posY + h/2;
		strokeW = w/7.7;
	}

	void render() {
		noStroke();

		fill(p.barchartBg);
		circle(centreX - offsetXY - (w/35), centreY + offsetXY + (w/35), w + (w/6.36));
		fill(p.foreground);
		circle(centreX - offsetXY, centreY + offsetXY, w + (w/7));

		fill(p.sliderHighlightEnabled);
		circle(centreX - offsetXY, centreY + offsetXY, w);
		strokeWeight(strokeW);
		stroke(p.foreground);
		noFill();
		strokeCap(SQUARE);
		arc(centreX - offsetXY, centreY + offsetXY, 
			w - strokeW - (w/2.94), h - strokeW - (h/2.94), 
			radians(0), radians(270));
		noStroke();
		fill(p.foreground);
		triangle(centreX - offsetXY, posY + (h/12.5) + offsetXY, 
			centreX - offsetXY, posY + (h/2.7) + offsetXY, 
			centreX + (w/4.76) - offsetXY, posY + (h/4.35) + offsetXY);
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			// Reset
			reset();
		}
		depressed = false;
		offsetXY = 0*px;
	}

	void reset() {
		arraySize = menu.sizeSlider.getVal();

		for (int i = 0; i < menu.shapeMenu.btnThumbs.size(); i++) {
			ShapeBtn s = menu.shapeMenu.btnThumbs.get(i);
			if (s.active) {
				if (s.name.matches("random")) {
					array = GenerateArray.random(arraySize);
				} else if (s.name.matches("sinWave")) {
					array = GenerateArray.sinWave(arraySize, 1.5);
				} else if (s.name.matches("quadrant")) {
					array = GenerateArray.quadrant(arraySize);
				} else if (s.name.matches("heartbeat")) {
					array = GenerateArray.sinWave(arraySize, 7.5);
				} else if (s.name.matches("squiggle")) {
					array = GenerateArray.squiggle(arraySize);
				} else if (s.name.matches("parabola")) {
					array = GenerateArray.parabola(arraySize);
				} else if (s.name.matches("parabolaInv")) {
					array = GenerateArray.parabolaInv(arraySize);
				} else if (s.name.matches("descending")) {
					array = GenerateArray.desc(arraySize);
				}
			}
		}

		desc = menu.descSwitch.active;
		colours = GenerateArray.blanks(arraySize);
		bubble.reset(array, colours);
		selection.reset(array, colours);
		mergeSort.reset(array, colours);
		play.active = false;
		comparisons = 0;
		assignments = 0;
	}

}