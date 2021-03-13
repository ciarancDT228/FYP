class Thumbnail {

	float posX, posY, w, h;
	// float px;
	int[] arr;
	int[] crr;
	Barchart b;
	int arrSize;
	String label;
	float fontSize;
	float offsetXY;
	boolean depressed;
	boolean active;
	boolean offset;
	boolean highlight;

	public Thumbnail (float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		this.fontSize = 16*px;
		this.arrSize = 680;
		depressed = false;
		active = false;
		offset = false;
		highlight = false;
		offsetXY = 4*px;
		// px = d/100;
		arrSize = (int)(68*10);
		b = new Barchart(posX + 16*px, posY + 14*px, 68*px, 46*py);
	}

	void render() {
		if(depressed){println("Thumbnail line 33");}
		if ((int)1*px < 1) {
			strokeWeight(1);
		} else {
			strokeWeight((int)1*px);
		}
		stroke(0);
		if(active) {
			fill(255);
		} else {
			fill(235);
		}
		rect(posX, posY, 100*px, 100*py, 8*px);
		b.render(arr, crr);
		noFill();
		strokeWeight((int)4*px);
		stroke(255);
		rect(posX + 15*px, posY + 13*py, 70*px, 48*py, 8*px);
		noFill();
		strokeWeight((int)2*px);
		stroke(0);
		rect(posX + 16*px, posY + 14*py, 68*px, 46*py, 8*px);
		fill(0);
		textSize(round(fontSize));
		textAlign(CENTER);
		text(label, posX + 50*px, posY + 86*py);
	}

	void updatePos() {
		b.posX = this.posX + 16*px;
		b.posY = this.posY + 14*py;
		b.w = 68*px;
		b.h = 46*py;
		fontSize = 16*px;
	}

	void update() {
		updatePos();
		if (correctLocation() && depressed) {
			offset = true;
		} else {
			offset = false;
		}
		if (correctLocation() && !depressed) {
			highlight = true;
		}
	}

	void mouseDown() {
		if (correctLocation()) {
			depressed = true;
		}
	}

	void mouseUp(Thumbnail child) {
		if (correctLocation() && depressed) {
			//do some thing
			if(!active) {
				for (int i = 0; i < algorithmMenu.algThumbs.size(); i++) {
					Thumbnail t = algorithmMenu.algThumbs.get(i);
					if (!(t == child)) {
						t.active = false;
					}
				}
				active = true;
			}
		}
		depressed = false;
		offset = false;
	}

	void mouseUp() {
		for (int i = 0; i < algorithmMenu.algThumbs.size(); i++) {
			Thumbnail t = algorithmMenu.algThumbs.get(i);
			t.mouseUp();
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

	// void deactivate() {
	// 	this.active = false;
	// }
}