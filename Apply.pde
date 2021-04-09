class Apply extends Reset {

	float fontSize;
	PFont f;

	public Apply(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		this.fontSize = 26*py;
		this.f = createFont("OpenSans-Regular.ttf", fontSize);
	}

	void render() {
		noStroke();

		fill(shade);
		rect(posX, posY + offsetXY, w, h, 5*px);

		textFont(f);
		fill(p.barchartFg);
		textAlign(CENTER, CENTER);
		text("Apply", posX + (w/2), posY + (h/2) - (fontSize/4) + offsetXY);
	}

	void update() {
		this.posX = lerp(this.posX, menu.wTarget + 8*px, menuLerp);
		if(correctLocation() && depressed) {
			shade = p.btnSelect;
			offsetXY = offset;
		} else if (correctLocation()) {
			shade = p.sliderTrackEnabled;
			offsetXY = -(offset);
		}
		else {
			shade = p.sliderTrackEnabled;
			offsetXY = 0;
		}
	}
	
}