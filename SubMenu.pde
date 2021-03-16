class SubMenu {

	ArrayList<Thumbnail> algThumbs;
	float posX, posY, w, h;
	boolean buttonClicked;
	Thumbnail mergeBtn;
	Thumbnail bubbleBtn;
	Thumbnail selectionBtn;
	Thumbnail randomBtn;

	public SubMenu (float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = 435*px;
		this.h = 114*py;
		this.randomBtn = new BubbleBtn(posX + 7*px, posY + 7*py, 100*px, 100*py);
		this.randomBtn.active = true;
		this.bubbleBtn = new BubbleBtn(posX + 114*px, posY + 7*py, 100*px, 100*py);
		this.selectionBtn = new SelectionBtn(posX + 221*px, posY + 7*py, 100*px, 100*py);
		this.mergeBtn = new MergeBtn(posX + 328*px, posY + 7*py, 100*px, 100*py);
		algThumbs = new ArrayList<Thumbnail>();
		algThumbs.add(mergeBtn);
		algThumbs.add(bubbleBtn);
		algThumbs.add(selectionBtn);
		algThumbs.add(randomBtn);
		buttonClicked  = false;


		// this.randomBtn = new BubbleBtn(posX + 7*px, posY + 7*py, 100*px, 100*py);
		// this.mergeBtn = new MergeBtn(posX + 328*px, posY + 7*py, 100*px, 100*py);

	}

	void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h);
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.render();
		}
	}

	void updatePos(boolean closed, float sw) {
		if(closed) {
			// Subtract w
			this.posX -= sw;
		} else {
			// Add w
			this.posX += w;
		}
		mergeBtn.updatePos(closed, sw);
		bubbleBtn.updatePos(closed, sw);
		selectionBtn.updatePos(closed, sw);
		randomBtn.updatePos(closed, sw);
	}

	// void updatePos() {
	// 	this.posX = mouseX;
	// 	this.posY = mouseY;
	// 	this.w = 435*px;
	// 	this.h = 114*py;
	// 	mergeBtn.posX = mouseX + 7*px;
	// 	bubbleBtn.posX = mouseX + 114*px;
	// 	selectionBtn.posX = mouseX + 221*px;
	// 	randomBtn.posX = mouseX + 328*px;
	// 	mergeBtn.posY = mouseY + 7*py;
	// 	bubbleBtn.posY = mouseY + 7*py;
	// 	selectionBtn.posY = mouseY + 7*py;
	// 	randomBtn.posY = mouseY + 7*py;
	// 	mergeBtn.updatePos();
	// 	bubbleBtn.updatePos();
	// 	selectionBtn.updatePos();
	// 	randomBtn.updatePos();
	// }


	void update() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.update();
		}
	}

	void mouseUp() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			if (t.correctLocation() && t.depressed) {
				buttonClicked = true;
				break;
			} else {
				buttonClicked = false;
			}
		}
		if (buttonClicked) {
			for (int i = 0; i < algThumbs.size(); i++) {
				Thumbnail t = algThumbs.get(i);
				if (buttonClicked) {
					t.active = false;
					t.mouseUp();
				}
			}
		}

	}

	void mouseDown() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.mouseDown();
		}
	}

}