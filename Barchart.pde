
class Barchart{

	// int[] array = {45, 37, 55, 27, 38, 50, 79, 48, 104, 31, 100, 58};
	// int[] array = {1, 2, 3, 4, 5};
	int[] array;
	int[] colours;
	float posX, posY, w, h;
	float border;
	float strokeWeight;
	float barWidth;
	float max;
	float thickness;
	float fontSize;
	PFont f;

	public Barchart(float posX, float posY, float w, float h, float border) {
		this.border = border;
		this.posX = posX;
		this.posY = posY;
		this.w = w - (border*2);
		this.h = h - (border*2);
		this.fontSize = 90*px/7.5;
		this.f = createFont("OpenSans-Regular.ttf", fontSize);
	}

	void render(int[] a, int[] c) {
		float spacer = 0;
		float x1 = 0;
		float y1 = 0;
		float barHeight = 0;
		array = a;
		colours = c;
		max = a.length;

		// Border
		noStroke();
		fill(p.foreground);
		rect(posX, posY, border*2 + w, border*2 + h);

		// Set strokeWeight
		if (a.length > w / 3) {
			strokeWeight = w / a.length;
			spacer = strokeWeight / 2;
		} else {
			strokeWeight = (w-(a.length))/a.length;
			spacer = strokeWeight / 2;
		}

		// Draw background
		fill(p.barchartBg);
		noStroke();
		rect(posX + border, posY + border, w, h);
		// Draw bars
		strokeWeight(strokeWeight);
		strokeCap(ROUND);
		for (int i = 0; i < a.length; i++) {
			if(c[i] == 0) { // Colours
				stroke(p.barchartFg);
			}
			else if (c[i] == 1) {
				stroke(#aecbfa);
			}
			else {
				stroke(#ccff90);
			}
			x1 = map(i, 0, a.length, posX, posX + w) + border + spacer;
			if (menu.mirrorSwitch.active) { // Mirror option
				y1 = map(a[i], -a.length, max, posY + h + border, posY + border + (strokeWeight / 2));
				barHeight = map(a[i], 0, max, 0, h - strokeWeight);
			} else {
				y1 = map(a[i], 0, max, posY + h + border, posY + border + (strokeWeight / 2) + (3*py));
				barHeight = map(a[i], 0, max, 0, h - (strokeWeight / 2));
			}
			line(x1, y1, x1, y1 + barHeight);
		}

		//Draw numbers
		if (a.length <= 100) {
			fill(p.barchartFont);
			fontSize = (w/a.length/2);
			f = createFont("OpenSans-Regular.ttf", fontSize);
			textFont(f);
			for (int i = 0; i < a.length; i++) {
				x1 = map(i, 0, a.length, posX, posX + w) + border + spacer;
				if (menu.mirrorSwitch.active) {
					textAlign(CENTER, CENTER);
					y1 = posY + (h/2) + border - 2*py;
				} else {
					textAlign(CENTER, CENTER);
					y1 = map(a[i], 0, max, posY + h + border, posY + border + (strokeWeight/2));
				}
				
				text(a[i], x1, y1);
			}
		}
			
		// Draw bottom to cover round caps
		noStroke();
		fill(p.foreground);
		rect(posX, posY + h + border, posX + w + (border * 2), posY + h + (border * 2));
		noFill();
		strokeWeight(3*px);
		stroke(p.accent);
		rect(posX + border, posY + border, w, h);
		strokeCap(ROUND);
	}

	// Used for rendering small thumbnail barcharts
	void renderSimple(int[] a, Thumbnail t) {
		float x1 = 0;
		float y1 = 0;
		float barHeight = 0;


		strokeWeight = w / a.length;
		fill(p.barchartFg);
		noStroke();
		rect(posX, posY + t.offsetXY, w, h);
		strokeWeight(strokeWeight);
		strokeCap(SQUARE);
		max = a.length - 1;
		stroke(p.barchartBg);
		for (int i = 0; i < a.length; i++) {
			if (descThumb && (t.label.matches("Bubble") || t.label.matches("Merge") || t.label.matches("Selection"))) {
				x1 = map(i, a.length, 0, posX, posX + w);
			} else {
				x1 = map(i, 0, a.length, posX, posX + w);
			}
			if (menu.mirrorSwitch.active) {
				y1 = map(a[i], -a.length, max, posY + t.offsetXY + h + border, posY + t.offsetXY + border);
			} else {
				y1 = map(a[i], 0, max, posY + t.offsetXY + h, posY + t.offsetXY);
			}
			barHeight = map(a[i], 0, max, 0, h);
			line(x1, y1, x1, y1 + barHeight);
		}
		strokeCap(ROUND);
	}
}