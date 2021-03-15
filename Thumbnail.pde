class Thumbnail {

	float posX, posY, w, h;
	// float px;
	int[] arr;
	int[] crr;
	Barchart b;
	int arrSize;
	String label;
	float fontSize;
	boolean depressed;
	boolean active;
	boolean offset;
	float offsetXY;
	boolean highlight;
	int shade;

	public Thumbnail (float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		this.fontSize = 16*px;
		this.arrSize = 680;
		shade = p.foreground;
		depressed = false;
		active = false;
		offset = false;
		offsetXY = 0*px;
		highlight = false;
		offsetXY = 2*px;
		// px = d/100;
		arrSize = (int)(68*10);
		b = new Barchart(posX + 16*px, posY + 14*px, 68*px, 46*py, 0);
	}

	void render() {
		// strokeWeight(1*px);
		// stroke(0);
		if (highlight) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		rect(posX - offsetXY, posY + offsetXY, 100*px, 100*py, 8*px);
		b.renderSimple(arr, this);
		// Overlay
		noFill();
		strokeWeight(4*px);
		stroke(shade);
		rect(posX - offsetXY + 15*px, posY + offsetXY + 13*py, 70*px, 48*py, 8*px);
		// Border
		noFill();
		strokeWeight(2*px);
		stroke(p.accent);
		rect(posX - offsetXY + 16*px, posY + offsetXY + 14*py, 68*px, 46*py, 8*px); 
		fill(p.font);
		textSize(round(fontSize));
		textAlign(CENTER);
		text(label, posX - offsetXY + 50*px, posY + offsetXY + 86*py);
	}

	void updatePos() {
		b.posX = this.posX + 16*px;
		b.posY = this.posY + 14*py;
		b.w = 68*px;
		b.h = 46*py;
		fontSize = 16*px;
	}

	void update() {
		// updatePos();
		if (!active) {
			if (correctLocation()) {
				if (depressed) {
					shade = p.select;
					highlight = true;
					offset = true;
					offsetXY = 1*px;
				} else {
					shade = p.hover;
					highlight = false;
					offset = false;
					offsetXY = -1*px;
				}
			} else {
				shade = p.foreground;
				highlight = false;
				offset = false;
				offsetXY = 0*px;
			}
		} else {
			shade = p.select;
			highlight = true;
			offset = true;
			offsetXY = 0*px;
		}
	}

	void mouseDown() {
		if (correctLocation()) {
			depressed = true;
		}
	}

	void mouseUp() {
		if (correctLocation() && depressed) {
			//do some thing
			active = true;
		} else {
			depressed = false;
			offset = false;
			offsetXY = 0*px;
		}
	}

	boolean correctLocation() {
		if (mouseX > this.posX && mouseX < this.posX + this.w
			&& mouseY > this.posY && mouseY < this.posY + this.h) {
			return true;
		} else {
			return false;
		}
	}

}