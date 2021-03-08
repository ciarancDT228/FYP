class TickSlider extends Slider {

	// float posX, posY;
	// float thumbX, thumbRadius;
	// float w, h;
	// float centreX, centreY;
	// int strokeS, strokeM, strokeL;
	// boolean depressed, active;
	// float thumbX;
	int tick;
	int numTicks;

	public TickSlider(float posX, float posY, float w, float h, int tick, int numTicks) {
		super(posX, posY, w, h);
		this.thumbX = map(stepsPerSecond, minSteps, maxSteps, 200, 350);
		this.tick = tick;
		this.numTicks = numTicks;
	}

	int getTickLocation() {
		tick = (int)map(mouseX, posX, posX + w, 0, 12);
		return (int)map(tick, 0, 12, posX, posX + w);
	}

	void update() {
		if(depressed) {
			if(inRangeX()) {
				thumbX = getTickLocation();
				println("Inside update: " + thumbX);
			}
			else if (mouseX < posX) {
				thumbX = posX;
			}
			else if (mouseX > posX + w) {
				thumbX = posX + w;
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
		return (int)Math.pow(2, tick);
	}

}
