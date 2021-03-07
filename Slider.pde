class Slider extends Component{

	float posX, posY;
	float thumbX, thumbRadius, thumbTempX;
	float w, h;
	float centreX, centreY;
	boolean depressed, active;

	public Slider(float posX, float posY, float w, float h, float thumbX) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		this.thumbX = thumbX;
		thumbTempX = thumbX;
		thumbRadius = h;
		depressed = false;
		active = false;
		centreX = posX + (w/2);
		centreY = posY + (h/2);
	}

	void update() {
		if(depressed) {
			if(inRange()) {
				thumbTempX = mouseX;
			}
			else {
				thumbTempX = thumbX;
			}
		}
	}

	void render() {
		//Draw track base
		strokeWeight(4);
		stroke(150);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		stroke(200);
		line(posX, centreY, thumbTempX, centreY);
		//Draw Thumb
		stroke(0);
		strokeWeight(0);
		fill(200);
		circle(thumbTempX, centreY, thumbRadius);
	}

	void mouseDown() {
		if(correctLocation()) {
			depressed = true;
		}
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			if(active) {
				active = false;
			} else {
				active = true;
			}
		}
		depressed = false;
	}

	boolean correctLocation() {
		if(distance(thumbX, centreY, mouseX, mouseY) <= thumbRadius) {
			return true;
		} else {
			return false;
		}
	}

	float distance(float x1, float y1, float x2, float y2) {
		return (float)Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
	}

	boolean inRange() {
		if(mouseX > posX && mouseX < posX + w 
			&& mouseY > posY && mouseY < posY + h) {
			return true;
		} else {
			return false;
		}
	}

}