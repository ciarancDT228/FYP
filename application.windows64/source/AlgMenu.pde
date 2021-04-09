class AlgMenu {

	ArrayList<Thumbnail> algThumbs;
	float posX, posY, w, h;
	boolean buttonClicked;
	Thumbnail mergeBtn;
	Thumbnail bubbleBtn;
	Thumbnail selectionBtn;
	Thumbnail randomBtn;

	public AlgMenu (float posX, float posY, float w, float h) {
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

	void update() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.update();
		}
		this.posX = lerp(this.posX, menu.wTarget, menuLerp);
		
		randomBtn.posX = lerp(randomBtn.posX, menu.wTarget + 7*px, menuLerp);
		bubbleBtn.posX = lerp(bubbleBtn.posX, menu.wTarget + 114*px, menuLerp);
		selectionBtn.posX = lerp(selectionBtn.posX, menu.wTarget + 221*px, menuLerp);
		mergeBtn.posX = lerp(mergeBtn.posX, menu.wTarget + 328*px, menuLerp);

		randomBtn.b.posX = lerp(randomBtn.b.posX, menu.wTarget + 23*px, menuLerp);
		bubbleBtn.b.posX = lerp(bubbleBtn.b.posX, menu.wTarget + 130*px, menuLerp);
		selectionBtn.b.posX = lerp(selectionBtn.b.posX, menu.wTarget + 237*px, menuLerp);
		mergeBtn.b.posX = lerp(mergeBtn.b.posX, menu.wTarget + 344*px, menuLerp);
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
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			if (buttonClicked) {
				t.active = false;
			}
			t.mouseUp();
		}
	}

	void mouseDown() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.mouseDown();
		}
	}

}
