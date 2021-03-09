class TickSlider extends Slider {

	int tick;
	int numTicks;

	public TickSlider(float posX, float posY, float w, float h, int tick, int numTicks) {
		super(posX, posY, w, h);
		this.thumbX = map(stepsPerSecond, minSteps, maxSteps, posX, posX + w);
		this.tick = tick;
		this.numTicks = numTicks;
	}

	int getTickLocation() {
		tick = (int)map(mouseX, posX, posX + w, 0, numTicks);
		return (int)map(tick, 0, numTicks, posX, posX + w);
	}

	void update() {
		if(depressed) {
			if(inRangeX()) {
				thumbX = getTickLocation();
			}
			else if (mouseX < posX) {
				thumbX = posX;
				tick = 0;
			}
			else if (mouseX > posX + w) {
				thumbX = posX + w;
				tick = numTicks;
			}
		}
	}

	void render() {
		//Draw track base
		strokeWeight(strokeM);
		stroke(100);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(255);
		line(posX, centreY, thumbX, centreY);
		//Draw ticks
		strokeWeight(strokeS);
		stroke(180);
		for(int i = 1; i < numTicks; i++) {
			point(map(i, 0, numTicks, posX, posX + w), centreY);
		}
		stroke(0);
		strokeWeight(0);
		//Draw highlight depressed
		if(depressed) {
			fill(255, 130);
			circle(thumbX, centreY, thumbRadius * 2.5);
		//Draw highlight for hover
		} else if(distance(mouseX, mouseY, thumbX, centreY) < (h/2)) {
			fill(255, 40);
			circle(thumbX, centreY, thumbRadius * 2.5);
		}
		//Draw Thumb
		fill(255);
		circle(thumbX, centreY, thumbRadius);
	}

	int getVal() {
		int[] x = {1, 2, 4, 10, 15, 30, 60, 120, 240, 480, 960, 1920, 3840, 7680, 15360};
		if(tick < 4) {
			return x[tick];
		} else {
			return (int)Math.pow(2, tick - 3) * 15;
		}
		//return x[tick];
		// return (int)Math.pow(2, tick);
	}

}
