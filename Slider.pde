class Slider{

	float posX, posY;
	float thumbX, thumbRadius;
	float w, h;
	float centreX, centreY;
	float strokeS, strokeM, strokeL;
	float minVal, maxVal, currentVal;
	boolean depressed, active;
	boolean round;
	float fontSize;
	PFont f;

	public Slider(float posX, float posY, float w, float h, float minVal, float maxVal, float initVal, boolean round) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		thumbRadius = h;
		depressed = false;
		active = false;
		centreX = posX + (w/2);
		centreY = posY + (h/2);
		this.minVal = minVal;
		this.maxVal = maxVal;
		this.thumbX = map(initVal, minVal, maxVal, posX, posX + w);
		strokeS = h/10;
		strokeM = h/5;
		strokeL = h/3.33;
		currentVal = getValFloat();
		this.round = round;
		this.fontSize = 16*px;
		this.f = createFont("OpenSans-Regular.ttf", fontSize);
	}

	public Slider(float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		thumbRadius = h;
		depressed = false;
		active = false;
		centreX = posX + (w/2);
		centreY = posY + (h/2);
		this.thumbX = centreX;
		strokeS = h/10;
		strokeM = h/5;
		strokeL = h/3.33;
		currentVal = getValFloat();
	}

	void update() {
		this.posX = lerp(this.posX, menu.wTarget + 225*px, menuLerp);
		this.thumbX = map(currentVal, minVal, maxVal, posX, posX + w);
		if(depressed) {
			if(inRangeX()) {
				thumbX = mouseX;
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
		stroke(p.sliderTrackEnabled);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(p.sliderHighlightEnabled);
		line(posX, centreY, thumbX, centreY);
		noStroke();
		//Draw highlight for hover and depressed
		if(depressed) {
			fill(p.sliderHighlightEnabled, 130);
			circle(thumbX, centreY, thumbRadius * 2.5);
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
		if (round) {
			text(getVal(), this.posX -20*px, posY + (fontSize / 2) - 1*py);
		} else {
			text(getValFloat(), this.posX -20*px, posY + (fontSize / 2) - 1*py);
		}
		textAlign(LEFT, CENTER);
	}

	void render2() {
		//Draw track base
		strokeWeight(strokeM);
		stroke(p.accent);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(p.font);
		line(posX, centreY, thumbX, centreY);
		noStroke();
		//Draw highlight for hover and depressed
		if(depressed) {
			fill(p.font, 130);
			circle(thumbX, centreY, thumbRadius * 2.5);
		} else if(distance(mouseX, mouseY, thumbX, centreY) < (h/2)) {
			fill(p.font, 40);
			circle(thumbX, centreY, thumbRadius * 2.5);
		}
		//Draw Thumb
		fill(p.font);
		circle(thumbX, centreY, thumbRadius);
		// Draw current value
		textAlign(RIGHT, CENTER);
		if (round) {
			text(getVal(), this.posX -20*px, posY + (fontSize / 2) - 1*py);
		} else {
			text(getValFloat(), this.posX -20*px, posY + (fontSize / 2) - 1*py);
		}
		
		textAlign(LEFT, CENTER);
	}

	void mouseDown() {
		if(insideBoundsXY()) {
			depressed = true;
		}
	}

	void mouseUp() {
		if(depressed) {
			depressed = false;
			currentVal = getValFloat();
		}
	}

	boolean insideBoundsXY() {
		if(mouseX >= posX - (h/2) && mouseX <= posX + w + (h/2) 
			&& mouseY >= posY && mouseY <= posY + h) {
			return true;
		} else {
			return false;
		}
	}

	float distance(float x1, float y1, float x2, float y2) {
		return (float)Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
	}

	boolean inRangeX() {
		if(mouseX >= posX && mouseX <= posX + w) {
			return true;
		} else {
			return false;
		}
	}

	int getVal() {
		return(int)(map(thumbX, posX, posX + w, minVal, maxVal));
	}

	float getValFloat() {
		return(map(thumbX, posX, posX + w, minVal, maxVal));
	}

}