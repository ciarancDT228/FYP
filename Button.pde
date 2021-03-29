class Button extends Component {
	
	float posX, posY;
	float w, h;
	float offsetXY;
	float offset;
	boolean depressed;
	boolean active;
	// boolean offset;
	int shade;

	public Button(float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		shade = p.foreground;
		depressed = false;
		active = false;
		offset = w/100;
		offsetXY = offset;
	}

	void render() {
		if (correctLocation()) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		rect(posX - offsetXY, posY + offsetXY, w, h);
	}

	void update() {
		if(correctLocation() && depressed) {
			shade = p.btnSelect;
			offsetXY = offset;
		} else if (correctLocation()) {
			shade = p.btnHover;
			offsetXY = -(offset);
		}
		else {
			shade = p.foreground;
			offsetXY = 0;
		}
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
		shade = p.foreground;
		depressed = false;
		offsetXY = 0;
	}

	boolean correctLocation() {
		if(mouseX > posX && mouseX < posX + w
			&& mouseY > posY && mouseY < posY + h) {
			return true;
		} else {
			return false;
		}
	}

}