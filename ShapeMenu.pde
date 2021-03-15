class ShapeMenu{

	ArrayList<ShapeBtn> btnThumbs;
	float posX, posY, w, h;
	boolean buttonClicked;
	ShapeBtn random;
	ShapeBtn sinWaveBtn;
	ShapeBtn quadrantBtn;
	ShapeBtn heartbeatBtn;
	ShapeBtn squiggle;
	ShapeBtn parabola;
	ShapeBtn parabolaInv;
	ShapeBtn descending;

	public ShapeMenu (float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = 435*px;
		this.h = 114*py;
		this.random = new ShapeBtn(posX + 7*px, posY + 7*py, 100*px, 82*py, "random");
		this.random.active = true;
		this.sinWaveBtn = new ShapeBtn(posX + 114*px, posY + 7*py, 100*px, 82*py, "sinWave");
		this.quadrantBtn = new ShapeBtn(posX + 221*px, posY + 7*py, 100*px, 82*py, "quadrant");
		this.heartbeatBtn = new ShapeBtn(posX + 328*px, posY + 7*py, 100*px, 82*py, "heartbeat");
		this.squiggle = new ShapeBtn(posX + 7*px, posY + 89*py, 100*px, 82*py, "squiggle");
		this.parabola = new ShapeBtn(posX + 114*px, posY + 89*py, 100*px, 82*py, "parabola");
		this.parabolaInv = new ShapeBtn(posX + 221*px, posY + 89*py, 100*px, 82*py, "parabolaInv");
		this.descending = new ShapeBtn(posX + 328*px, posY + 89*py, 100*px, 82*py, "descending");
		btnThumbs = new ArrayList<ShapeBtn>();
		btnThumbs.add(random);
		btnThumbs.add(sinWaveBtn);
		btnThumbs.add(quadrantBtn);
		btnThumbs.add(heartbeatBtn);
		btnThumbs.add(squiggle);
		btnThumbs.add(parabola);
		btnThumbs.add(parabolaInv);
		btnThumbs.add(descending);
		buttonClicked  = false;
	}

	void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h, 8*px);
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			t.render();
		}
	}

	void updatePos() {
		this.posX = mouseX;
		this.posY = mouseY;
		this.w = 435*px;
		this.h = 114*py;
		random.posX = mouseX + 7*px;
		random.posY = mouseY + 7*py;
		sinWaveBtn.posX = mouseX + 114*px;
		sinWaveBtn.posY = mouseY + 7*py;
		quadrantBtn.posX = mouseX + 221*px;
		quadrantBtn.posY = mouseY + 7*py;
		heartbeatBtn.posX = mouseX + 328*px;
		heartbeatBtn.posY = mouseY + 7*py;
		squiggle.posX = mouseX + 7*px;
		squiggle.posY = mouseY + 89*py;
		parabola.posX = mouseX + 114*px;
		parabola.posY = mouseY + 89*py;
		parabolaInv.posX = mouseX + 221*px;
		parabolaInv.posY = mouseY + 89*py;
		descending.posX = mouseX + 328*px;
		descending.posY = mouseY + 89*py;
		// mergeBtn.updatePos();
		// bubbleBtn.updatePos();
		// selectionBtn.updatePos();
		// randomBtn.updatePos();
	}

	void update() {
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			t.update();
		}
	}

	void mouseUp() {
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			if (t.correctLocation() && t.depressed) {
				buttonClicked = true;
				break;
			} else {
				buttonClicked = false;
			}
		}
		if (buttonClicked) {
			for (int i = 0; i < btnThumbs.size(); i++) {
				ShapeBtn t = btnThumbs.get(i);
				if (buttonClicked) {
					t.active = false;
					t.mouseUp();
				}
			}
		}

	}

	void mouseDown() {
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			t.mouseDown();
		}
	}

}