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

	int getTickLocation() {
		tick = (int)round(map(mouseX, posX, posX + w, 0, numTicks));
		return (int)map(tick, 0, numTicks, posX, posX + w);
	}

	void update() {
		this.posX = lerp(this.posX, menu.wTarget + 225*px, menuLerp);
		this.thumbX = map(tick, 0, numTicks, posX, posX + w);
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
		setVal();
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
		stroke(p.accent);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(p.font);
		line(posX, centreY, thumbX, centreY);

		//Draw ticks
		strokeWeight(strokeS);
		for(int i = 1; i < numTicks; i++) {
			tickmark = map(i, 0, numTicks, posX, posX + w);
			if(tickmark <= thumbX) {
				stroke(p.accent);
			} else {
				stroke(p.font);
			}
			point(map(i, 0, numTicks, posX, posX + w), centreY);
		}

		noStroke();
		//Draw highlight depressed
		if(depressed) {
			fill(p.font, 130);
			circle(thumbX, centreY, thumbRadius * 2.5);
		//Draw highlight for hover
		} else if(distance(mouseX, mouseY, thumbX, centreY) < (h/2)) {
			fill(p.font, 40);
			circle(thumbX, centreY, thumbRadius * 2.5);
		}
		//Draw Thumb
		fill(p.font);
		circle(thumbX, centreY, thumbRadius);
		// Draw current value
		textAlign(RIGHT, CENTER);
		text(getVal(), this.posX -20*px, posY + (fontSize / 2) + 7*py);
		textAlign(LEFT, CENTER);
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

	void setVal() {
		int[] x = {1, 2, 4, 10, 15, 30, 60, 120, 240, 480, 960, 1920, 3840, 7680, 15360};
		if(tick < 4) {
			speed = x[tick];
		} else {
			speed = (int)Math.pow(2, tick - 3) * 15;
		}
	}

}
