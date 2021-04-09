class AudioBtn extends Button{

	float centreY;
	float centreX;
	float strokeW;

	public AudioBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreX = posX + (w/2);
		centreY = posY + (h/2);
		strokeW = w/20;
		active = false;
	}

	void render() {
		noStroke();

		fill(p.barchartBg);
		circle(centreX - offsetXY - (w/35), centreY + offsetXY + (w/35), w + (w/6.36));
		fill(p.barchartFg);
		circle(centreX - offsetXY, centreY + offsetXY, w + (w/7));
		
		fill(p.sliderHighlightEnabled);
		circle(centreX - offsetXY, centreY + offsetXY, w);
		noStroke();
		fill(p.barchartFg);
		rect(posX - offsetXY + (w/6.25), posY + offsetXY + (h/2.77), (w/3), (h/3.57), 5*px);
		triangle(posX - offsetXY + (w/1.85), posY + offsetXY + (h/5), 
			posX - offsetXY + (w/1.85), posY + offsetXY + h - (h/5), 
			posX - offsetXY + (h/5.55), centreY + offsetXY);

		noFill();
		strokeWeight(strokeW);
		stroke(p.barchartFg);
		if (active) {
			arc(centreX - offsetXY, centreY + offsetXY, (w/2.63) - strokeW, (h/2.63) - strokeW, radians(-45), radians(45));
			arc(centreX - offsetXY, centreY + offsetXY, (w/1.72) - strokeW, (h/1.72) - strokeW, radians(-45), radians(45));
		} else {
			line(posX - offsetXY + (w/1.54), posY + offsetXY + (h/2.44), posX - offsetXY + (w/1.2), posY + offsetXY + (h/1.69));
			line(posX - offsetXY + (w/1.54), posY + offsetXY + (h/1.69), posX - offsetXY + (w/1.2), posY + offsetXY + (h/2.44));
		}
	}

	void update() {
		if(correctLocation() && depressed) {
			shade = p.select;
			offsetXY = offset;
		} else if (correctLocation()) {
			shade = p.hover;
			offsetXY = -(offset);
		}
		else {
			shade = p.foreground;
			offsetXY = 0;
		}
		if(active) {
			s.volume(0.4);
		} else {
			s.volume(0.0);
		}

	}

}