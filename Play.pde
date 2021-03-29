
class Play extends Button{

	float centreY;
	float centreX;

	public Play(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreX = posX + (w/2);
		centreY = posY + (h/2);
	}

	void render() {
		noStroke();

		fill(p.barchartBg);
		circle(centreX - offsetXY - (w/35), centreY + offsetXY + (w/35), w + (w/6.36));
		fill(p.foreground);
		circle(centreX - offsetXY, centreY + offsetXY, w + (w/7));


		fill(p.sliderHighlightEnabled);
		circle(centreX - offsetXY, centreY + offsetXY, w);
		fill(p.foreground);
		if(active) {
			rect(posX - offsetXY + (w/3.33), posY + offsetXY + (h/3.85), (w/5.55), (h/2), 2.5);
			rect(posX - offsetXY + w - (w/3.33) - (w/5.55), posY + offsetXY + (h/3.85), (w/5.55), (h/2), 2.5);


			// rect(posX - offsetXY + (w/2.94), posY + offsetXY + (h/3.23), (h/7.69), (h/2.56), 2.5*px);
			// rect(posX - offsetXY + w - (w/2.94) - (w/7.69), posY + offsetXY + (h/3.23), (h/7.69), (h/2.56), 2.5*px);
		} else {
			stroke(p.foreground);
			strokeWeight(5*px);
			strokeJoin(ROUND);
			triangle(posX - offsetXY + (w/2.94), posY + offsetXY + (h/4.16), 
			posX - offsetXY + (w/2.94), posY + offsetXY + h - (h/4.16), 
			posX - offsetXY + w - (w/4.5), centreY + offsetXY);
		}	
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			if(active) {
				active = false;
			} else {
				if(sorted()) {
					reset.reset();
				}
				active = true;
			}
		}
		shade = p.foreground;
		depressed = false;
		offsetXY = 0;
	}

	boolean sorted() {
		if (desc) {
			for(int i = 1; i < array.length; i++) {
				if(array[i] > array[i - 1]) {
					return false;
				}
			}
		} else {
			for(int i = 1; i < array.length; i++) {
				if(array[i] < array[i - 1]) {
					return false;
				}
			}
		}
		return true;
	}
	
}