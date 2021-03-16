class Button extends Component {
	
	float posX, posY;
	float w, h;
	float offsetXY;
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
		offsetXY = 2*px;
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
			shade = p.select;
			offsetXY = 2*px;
		} else if (correctLocation()) {
			shade = p.hover;
			offsetXY = -2*px;
		}
		else {
			shade = p.foreground;
			offsetXY = 0*px;
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
		offsetXY = 0*px;
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
