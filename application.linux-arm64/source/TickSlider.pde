class TickSlider extends Slider {

	int tick;
	int numTicks;
	int current;

	public TickSlider(float posX, float posY, float w, float h, int tick, int numTicks) {
		super(posX, posY, w, h);
		this.thumbX = map(stepsPerSecond, minSteps, maxSteps, posX, posX + w);
		this.tick = tick;
		this.numTicks = numTicks;
		current = getVal();
	}

	void update() {
		this.posX = lerp(this.posX, menu.wTarget + 225*px, menuLerp);
		this.thumbX = map(tick, 0, numTicks, posX, posX + w);

		if (depressed) {
			if(inRangeX()) {
				thumbX = getTickLocation();
			} else if (mouseX < posX) {
				thumbX = posX;
				tick = 0;
			} else if (mouseX > posX + w) {
				thumbX = posX + w;
				tick = numTicks;
			}
		}
		setVal();
	}

	int getTickLocation() {
		tick = (int)round(map(mouseX, posX, posX + w, 0, numTicks));
		return (int)map(tick, 0, numTicks, posX, posX + w);
	}


	// void updatePos(boolean closed, float sw) {
	// 	if(closed) {
	// 		// Subtract w
	// 		this.posX = this.posX - sw;
	// 		centreX = this.posX + (this.w/2) - sw;
	// 		this.thumbX -= sw;
	// 	} else {
	// 		// Add w
	// 		this.posX = this.posX + sw;
	// 		centreX = this.posX + (this.w/2) + sw;
	// 		this.thumbX += sw;
	// 	}
	// }

	void render() {
		float tickmark;

		//Draw track base
		strokeWeight(strokeM);
		stroke(p.sliderTrackEnabled);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(p.sliderHighlightEnabled);
		line(posX, centreY, thumbX, centreY);

		//Draw ticks
		strokeWeight(strokeS);
		for(int i = 1; i < numTicks; i++) {
			tickmark = map(i, 0, numTicks, posX, posX + w);
			if(tickmark <= thumbX) {
				stroke(p.sliderTrackEnabled);
			} else {
				stroke(p.sliderHighlightEnabled);
			}
			point(map(i, 0, numTicks, posX, posX + w), centreY);
		}

		noStroke();
		//Draw highlight depressed
		if(depressed) {
			fill(p.sliderHighlightEnabled, 130);
			circle(thumbX, centreY, thumbRadius * 2.5);
		//Draw highlight for hover
		} else if(distance(mouseX, mouseY, thumbX, centreY) < (h/2)) {
			fill(p.sliderHighlightEnabled, 40);
			circle(thumbX, centreY, thumbRadius * 2.5);
		}
		//Draw Thumb
		fill(p.sliderHighlightEnabled);
		circle(thumbX, centreY, thumbRadius);
		// Draw text current value
		fill(p.font);
		textAlign(RIGHT, CENTER);
		text(getVal(), this.posX -20*px, posY + (fontSize / 2) + 7*py);
		textAlign(LEFT, CENTER);
	}

	int getVal() {
		// int[] x = {1, 2, 4, 10, 15, 30, 
		// 	60, 120, 240, 480, 1000, 2000, 
		// 	4000, 8000, 16000, 30000, 60000};
		int[] x = {1, 2, 4, 10, 30, 100, 300, 700, 1500, 4000, 10000, 20000, 40000, 100000, 200000, 400000, 600000};
		return x[tick];
	}

	void setVal() {
		// int[] x = {1, 2, 4, 10, 15, 30, 60, 120, 240, 480, 1000, 2000, 4000, 8000, 16000, 30000, 60000};
		int[] x = {1, 2, 4, 10, 30, 100, 300, 700, 1500, 4000, 10000, 20000, 40000, 100000, 200000, 400000, 600000};
		speed = x[tick];
	}

}
