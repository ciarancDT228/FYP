class ToggleSwitch extends Button {

	float strokeS, strokeM, strokeL, centreY, thumbX;
	
	public ToggleSwitch(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreY = posY + (h/2);
		strokeS = h/10;
		strokeM = h/5;
		strokeL = h/1.4286;
		thumbX = posX;
	}

	void render() {
		//Draw track base
		strokeWeight(strokeL);
		stroke(p.sliderTrackDisabled);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(p.sliderTrackEnabled);
		line(posX, centreY, thumbX, centreY);
		noStroke();
		//Draw highlight for hover and depressed
		if(depressed) {
			fill(p.sliderHighlightEnabled, 130);
			circle(thumbX, centreY, h * 2.5);
		} else if(correctLocation()) {
			fill(p.sliderHighlightEnabled, 40);
			circle(thumbX, centreY, h * 2.5);
		}
		if (active) {
			//Draw Thumb
			fill(p.sliderHighlightEnabled);
			circle(thumbX, centreY, h);
		} else {
			//Draw Thumb
			fill(p.sliderTrackDisabled);
			circle(thumbX - (h/20), centreY + (h/20), h);
			fill(p.sliderHighlightDisabled);
			circle(thumbX, centreY, h);
		}


		// if (active) {
		// 	//Draw track base
		// 	strokeWeight(strokeL);
		// 	stroke(p.sliderTrackEnabled);
		// 	line(posX, centreY, posX + w, centreY);
		// 	//Draw track highlight
		// 	strokeWeight(strokeL);
		// 	stroke(p.sliderTrackEnabled);
		// 	line(posX, centreY, thumbX, centreY);
		// 	noStroke();
		// 	//Draw highlight for hover and depressed
		// 	if(depressed) {
		// 		fill(p.sliderHighlightEnabled, 130);
		// 		circle(thumbX, centreY, h * 2.5);
		// 	} else if(correctLocation()) {
		// 		fill(p.sliderHighlightEnabled, 40);
		// 		circle(thumbX, centreY, h * 2.5);
		// 	}
		// 	//Draw Thumb
		// 	fill(p.sliderHighlightEnabled);
		// 	circle(thumbX, centreY, h);
		// } else {
		// 	//Draw track base
		// 	strokeWeight(strokeL);
		// 	stroke(p.sliderTrackDisabled);
		// 	line(posX, centreY, posX + w, centreY);
		// 	//Draw track highlight
		// 	strokeWeight(strokeL);
		// 	stroke(p.sliderHighlightDisabled);
		// 	line(posX, centreY, thumbX, centreY);
		// 	noStroke();
		// 	//Draw highlight for hover and depressed
		// 	if(depressed) {
		// 		fill(p.sliderHighlightDisabled, 130);
		// 		circle(thumbX, centreY, h * 2.5);
		// 	} else if(correctLocation()) {
		// 		fill(p.sliderHighlightDisabled, 40);
		// 		circle(thumbX, centreY, h * 2.5);
		// 	}
		// 	//Draw Thumb
		// 	fill(p.sliderHighlightDisabled);
		// 	circle(thumbX, centreY, h);
		// }





		// //Draw track base
		// strokeWeight(strokeL);
		// stroke(p.accent);
		// line(posX, centreY, posX + w, centreY);
		// //Draw track highlight
		// strokeWeight(strokeL);
		// stroke(p.font);
		// line(posX, centreY, thumbX, centreY);
		// noStroke();
		// //Draw highlight for hover and depressed
		// if(depressed) {
		// 	fill(shade, 130);
		// 	circle(thumbX, centreY, h * 2.5);
		// } else if(correctLocation()) {
		// 	fill(p.font, 40);
		// 	circle(thumbX, centreY, h * 2.5);
		// }
		// //Draw Thumb
		// if(active) {
		// 	fill(p.font);	
		// } else {
		// 	fill(p.hover);
		// }
		// circle(thumbX, centreY, h);
	}

	void update() {
		this.posX = lerp(this.posX, menu.wTarget + menu.w - (menu.spacer*2) - w, menuLerp);
		if(active) {
			thumbX = posX + w;
		} else {
			thumbX = posX;
		}
		// if(correctLocation() && depressed) {
		// 	shade = p.select;
		// } else if (correctLocation()) {
		// 	shade = p.hover;
		// }
		// else {
		// 	shade = p.foreground;
		// }
	}

	float distance(float x1, float y1, float x2, float y2) {
		return (float)Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			if(active) {
				active = false;
				thumbX = posX;
			} else {
				active = true;
				thumbX = posX + w;
			}
		}
		shade = p.foreground;
		depressed = false;
		offsetXY = 0*px;
	}

	boolean correctLocation() {
		if(mouseX > posX - (h/2) && mouseX < posX + w + (h/2)
			&& mouseY > posY && mouseY < posY + h) {
			return true;
		} else {
			return false;
		}
	}

}