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
		this.random = new ShapeBtn(posX + 7*px, posY + 7*py, 100*px, 100*py, "random");
		this.random.active = true;
		this.sinWaveBtn = new ShapeBtn(posX + 114*px, posY + 7*py, 100*px, 100*py, "sinWave");
		this.quadrantBtn = new ShapeBtn(posX + 221*px, posY + 7*py, 100*px, 100*py, "quadrant");
		this.heartbeatBtn = new ShapeBtn(posX + 328*px, posY + 7*py, 100*px, 100*py, "heartbeat");
		this.squiggle = new ShapeBtn(posX + 7*px, posY + 114*py, 100*px, 100*py, "squiggle");
		this.parabola = new ShapeBtn(posX + 114*px, posY + 114*py, 100*px, 100*py, "parabola");
		this.parabolaInv = new ShapeBtn(posX + 221*px, posY + 114*py, 100*px, 100*py, "parabolaInv");
		this.descending = new ShapeBtn(posX + 328*px, posY + 114*py, 100*px, 100*py, "descending");
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

		this.posX = lerp(this.posX, menu.wTarget, menuLerp);

		random.posX = lerp(random.posX, menu.wTarget + 7*px, menuLerp);
		sinWaveBtn.posX = lerp(sinWaveBtn.posX, menu.wTarget + 114*px, menuLerp);
		quadrantBtn.posX = lerp(quadrantBtn.posX, menu.wTarget + 221*px, menuLerp);
		heartbeatBtn.posX = lerp(heartbeatBtn.posX, menu.wTarget + 328*px, menuLerp);

		squiggle.posX = lerp(squiggle.posX, menu.wTarget + 7*px, menuLerp);
		parabola.posX = lerp(parabola.posX, menu.wTarget + 114*px, menuLerp);
		parabolaInv.posX = lerp(parabolaInv.posX, menu.wTarget + 221*px, menuLerp);
		descending.posX = lerp(descending.posX, menu.wTarget + 328*px, menuLerp);

		random.b.posX = lerp(random.b.posX, menu.wTarget + 23*px, menuLerp);
		sinWaveBtn.b.posX = lerp(sinWaveBtn.b.posX, menu.wTarget + 130*px, menuLerp);
		quadrantBtn.b.posX = lerp(quadrantBtn.b.posX, menu.wTarget + 237*px, menuLerp);
		heartbeatBtn.b.posX = lerp(heartbeatBtn.b.posX, menu.wTarget + 344*px, menuLerp);

		squiggle.b.posX = lerp(squiggle.b.posX, menu.wTarget + 23*px, menuLerp);
		parabola.b.posX = lerp(parabola.b.posX, menu.wTarget + 130*px, menuLerp);
		parabolaInv.b.posX = lerp(parabolaInv.b.posX, menu.wTarget + 237*px, menuLerp);
		descending.b.posX = lerp(descending.b.posX, menu.wTarget + 344*px, menuLerp);

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
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			if (buttonClicked) {
				t.active = false;
				if (!play.active) {
					reset.reset();
				}
			}
			t.mouseUp();
		}

		// if (buttonClicked) {
		// 	for (int i = 0; i < btnThumbs.size(); i++) {
		// 		ShapeBtn t = btnThumbs.get(i);
		// 		t.active = false;
		// 		t.mouseUp();
		// 	}
			
		// } else {
		// 	for (int i = 0; i < btnThumbs.size(); i++) {
		// 		ShapeBtn t = btnThumbs.get(i);
		// 		t.mouseUp();
		// 	}
		// }
	}

	void mouseDown() {
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			t.mouseDown();
		}
	}

}