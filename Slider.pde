class Slider extends Component{

	float posX, posY;
	float thumbX, thumbRadius;
	float w, h;
	float centreX, centreY;
	float strokeS, strokeM, strokeL;
	float minVal, maxVal;
	boolean depressed, active;

	public Slider(float posX, float posY, float w, float h, float minVal, float maxVal, float initVal) {
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
	}

	void update() {
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
	}

	void mouseDown() {
		if(insideBoundsXY()) {
			depressed = true;
		}
	}

	void mouseUp() {
		if(depressed) {
			depressed = false;
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