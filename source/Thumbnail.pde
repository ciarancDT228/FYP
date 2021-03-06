class Thumbnail {

	float posX, posY, w, h;
	int[] arr;
	int[] crr;
	int arrSize;
	Barchart b;
	boolean depressed;
	boolean active;
	boolean highlight;
	float offsetXY;
	float offset;
	int shade;
	PFont f;
	float fontSize;
	String label;

	public Thumbnail (float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		this.fontSize = 16*px;
		this.f = createFont("OpenSans-Regular.ttf", fontSize);
		this.arrSize = 68;
		shade = p.foreground;
		depressed = false;
		active = false;
		offset = 3*px;
		offsetXY = 0*px;
		highlight = false;
		// arrSize = (int)(68*10);
		arr = GenerateArray.random(arrSize);
		crr = GenerateArray.blanks(arrSize);
		b = new Barchart(posX + 16*px, posY + 14*px, 68*px, 46*py, 0);
	}

	void render() {
		// if (highlight) {
		// 	strokeWeight(1*px);
		// 	stroke(p.accent);
		// } else {
		// 	noStroke();
		// }
		noStroke();
		fill(shade);
		rect(posX, posY + offsetXY, 100*px, 100*py, 8*px);
		b.renderSimple(arr, this);
		// Overlay
		noFill();
		strokeWeight(6*px);
		stroke(shade);
		rect(posX + 13*px, posY + offsetXY + 11*py, 74*px, 52*py, 10*px);
		// Border
		noFill();
		strokeWeight(1*px);
		stroke(p.accent);
		rect(posX + 16*px, posY + offsetXY + 14*py, 68*px, 46*py, 8*px); 
		// Label
		fill(p.font);
		textFont(f);
		textSize(fontSize);
		textAlign(CENTER);
		text(label, posX + 50*px, posY + offsetXY + 86*py);
	}

	void update() {
		// b.posX = this.posX + 16*px;
		if (!active) {
			if (correctLocation()) {
				if (depressed) {
					shade = p.btnSelect;
					highlight = true;
					offsetXY = offset;
				} else {
					shade = p.btnHover;
					highlight = false;
					offsetXY = 0*px;
				}
			} else {
				shade = p.foreground;
				highlight = false;
				offsetXY = 0*px;
			}
		} else {
			shade = p.btnSelect;
			highlight = true;
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
			if(!active) {
				active = true;
			}
		} else {
			offsetXY = 0*px;
		}
		depressed = false;
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