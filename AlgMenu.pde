class AlgMenu {

	ArrayList<Thumbnail> algThumbs;
	float posX, posY, w, h;
	Thumbnail mergeBtn;
	Thumbnail bubbleBtn;
	Thumbnail selectionBtn;
	Thumbnail randomBtn;

	public AlgMenu (float posX, float posY) {
		this.posX = posX;
		this.posY = posY;
		this.w = 435*px;
		this.h = 114*py;
		println(100*px);
		println(px);
		this.mergeBtn = new MergeBtn(posX + 7*px, posY + 7*py, 100*px, 100*py);
		this.bubbleBtn = new BubbleBtn(posX + 114*px, posY + 7*py, 100*px, 100*py);
		// this.bubbleBtn.active = true;
		this.selectionBtn = new SelectionBtn(posX + 221*px, posY + 7*py, 100*px, 100*py);
		this.selectionBtn.active = true;
		this.randomBtn = new BubbleBtn(posX + 328*px, posY + 7*py, 100*px, 100*py);
		algThumbs = new ArrayList<Thumbnail>();
		algThumbs.add(mergeBtn);
		algThumbs.add(bubbleBtn);
		algThumbs.add(selectionBtn);
		algThumbs.add(randomBtn);
	}

	void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h, 8*px);
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.render();
		}
	}

	void updatePos() {
		this.posX = mouseX;
		this.posY = mouseY;
		this.w = 435*px;
		this.h = 114*py;
		mergeBtn.posX = mouseX + 7*px;
		bubbleBtn.posX = mouseX + 114*px;
		selectionBtn.posX = mouseX + 221*px;
		randomBtn.posX = mouseX + 328*px;
		mergeBtn.posY = mouseY + 7*py;
		bubbleBtn.posY = mouseY + 7*py;
		selectionBtn.posY = mouseY + 7*py;
		randomBtn.posY = mouseY + 7*py;
		mergeBtn.updatePos();
		bubbleBtn.updatePos();
		selectionBtn.updatePos();
		randomBtn.updatePos();
	}

	void update() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.update();
		}
	}

	void mouseUp() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.mouseUp();
		}
	}

}