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
		this.w = w;
		this.h = h;
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

	void updatePos(boolean closed, float sw) {
		if(closed) {
			// Subtract w
			this.posX -= sw;
		} else {
			// Add w
			this.posX += sw;
		}
		random.updatePos(closed, sw);
		sinWaveBtn.updatePos(closed, sw);
		quadrantBtn.updatePos(closed, sw);
		heartbeatBtn.updatePos(closed, sw);
		squiggle.updatePos(closed, sw);
		parabola.updatePos(closed, sw);
		parabolaInv.updatePos(closed, sw);
		descending.updatePos(closed, sw);
	}

	void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h);
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			t.render();
		}
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
