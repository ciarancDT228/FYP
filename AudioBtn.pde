class AudioBtn extends Button{

	float centreY;
	float centreX;
	float strokeW;

	public AudioBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreX = posX + (w/2);
		centreY = posY + (h/2);
		strokeW = w/20;
	}

	void render() {
		if (correctLocation()) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		circle(centreX - offsetXY, centreY + offsetXY, w);
		noStroke();
		fill(p.font);
		rect(posX - offsetXY + (w/6.25), posY + offsetXY + (h/2.7), (w/3), (w/3.33), 5*px);
		triangle(posX - offsetXY + (w/1.85), posY + offsetXY + (h/5), 
			posX - offsetXY + (w/1.85), posY + offsetXY + h - (h/5), 
			posX - offsetXY + (h/5.55), centreY + offsetXY);

		noFill();
		strokeWeight(strokeW);
		stroke(p.font);
		if (active) {
			line(posX - offsetXY + (w/1.54), posY + offsetXY + (h/2.44), posX - offsetXY + (w/1.2), posY + offsetXY + (h/1.69));
			line(posX - offsetXY + (w/1.54), posY + offsetXY + (h/1.69), posX - offsetXY + (w/1.2), posY + offsetXY + (h/2.44));
		} else {
			arc(centreX - offsetXY, centreY + offsetXY, (w/2.63) - strokeW, (h/2.63) - strokeW, radians(-45), radians(45));
			arc(centreX - offsetXY, centreY + offsetXY, (w/1.72) - strokeW, (h/1.72) - strokeW, radians(-45), radians(45));
		}
		

	}

}