class SettingsBtn extends Button{

	float r;
	float rtarget;
	float centreX;
	float centreY;
	float strokeW;
	float marginY;
	float marginX;

	public SettingsBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreX = w/2;
		centreY = h/2;
		strokeW = w/10;
		marginY = h/5.26;
		marginX = w/5.88;
		r = radians(0);
		rtarget = radians(0);
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			menu.toggleMenu = true;
			if (rtarget == radians(-90)) {
				rtarget = radians(0);
				menu.wTarget = width;
			} else {
				rtarget = radians(-90);
				menu.wTarget = width - 436*px;
			}
		}
		depressed = false;
		offsetXY = 0*px;
	}

	void update() {
		if(correctLocation() && depressed) {
			shade = p.select;
			offsetXY = 2*px;
		} else if (correctLocation()) {
			shade = p.hover;
			offsetXY = -2*px;
		}
		else {
			shade = p.foreground;
			offsetXY = 0*px;
		}
		r = lerp(r, rtarget, 0.3);
	}

	void render() {
		translate(posX + centreX, posY + centreY);
		rotate(r);

		noStroke();
		fill(p.foreground);
		// rect(-centreX, -centreY, w, h);
		circle(0, 0, w);
		strokeWeight(strokeW);
		stroke(p.font);
		strokeCap(ROUND);
		line(-centreX + marginX + (strokeW/2), -centreY + centreY, w - marginX - centreX - (strokeW/2), -centreY + centreY);
		line(-centreX + marginX + (strokeW/2), -centreY + centreY + marginY, w - marginX - centreX - (strokeW/2), -centreY + centreY + marginY);
		line(-centreX + marginX + (strokeW/2), -centreY + centreY - marginY, w - marginX - centreX - (strokeW/2), -centreY + centreY - marginY);
	}

}