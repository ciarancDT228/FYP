class Button extends Component {
	
	float posX, posY;
	float w, h;
	float offsetXY;
	boolean depressed;
	boolean active;
	boolean offset;

	public Button(float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		depressed = false;
		active = false;
		offset = false;
		offsetXY = 4;
	}

		void render() {
		fill(255);
		if(offset) {
			rect(posX - offsetXY, posY + offsetXY, w, h);
		} else {
			rect(posX, posY, w, h);
		}
	}

	void update() {
		if(correctLocation() && depressed) {
			offset = true;
		} else {
			offset = false;
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
		depressed = false;
		offset = false;
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