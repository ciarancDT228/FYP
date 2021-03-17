class ToggleSwitch extends Button {

	float strokeS, strokeM, strokeL, centreY, thumbX;
	
	public ToggleSwitch(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreY = posY + (h/2);
		strokeS = h/10;
		strokeM = h/5;
		strokeL = h/3.33;
		thumbX = posX;
	}

	void render() {
		//Draw track base
		strokeWeight(strokeM);
		stroke(p.accent);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(shade);
		line(posX, centreY, thumbX, centreY);
		noStroke();
		//Draw highlight for hover and depressed
		if(depressed) {
			fill(shade, 130);
			circle(thumbX, centreY, h * 2.5);
		} else if(distance(mouseX, mouseY, thumbX, centreY) < (h/2)) {
			fill(p.font, 40);
			circle(thumbX, centreY, h * 2.5);
		}
		//Draw Thumb
		fill(p.font);
		circle(thumbX, centreY, h);
	}

	void update() {
		if(correctLocation() && depressed) {
			shade = p.select;
		} else if (correctLocation()) {
			shade = p.hover;
		}
		else {
			shade = p.foreground;
		}
	}

	float distance(float x1, float y1, float x2, float y2) {
		return (float)Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			if(active) {
				active = false;
				thumbX = posX;
			} else {
				active = true;
				thumbX = posX + w;
			}
		}
		shade = p.foreground;
		depressed = false;
		offsetXY = 0*px;
	}



}