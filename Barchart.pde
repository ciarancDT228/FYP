
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

	public Barchart(float posX, float posY, float w, float h, float border) {
		this.border = border;
		this.posX = posX;
		this.posY = posY;
		this.w = w - (border*2);
		this.h = h - (border*2);
	}

	// void update(float wid, float hei) {
	// 	border = mouseX;
	// 	w = wid - (border*2);
	// 	h = hei - (border*2);
	// 	barWidth = w/array.length;
	// }

	void update() {
	}

	void render(int[] a, int[] c) {
		float spacer = 0;

		noStroke();
		fill(p.foreground);
		rect(posX, posY,border*2 + w, border*2 + h);
		if (a.length > w / 6) {
			strokeWeight = w / a.length;
			spacer = strokeWeight / 2;
		} else {
			strokeWeight = (w-(a.length-1))/a.length;
			spacer = strokeWeight / 2;
		}
		fill(p.barB);
		noStroke();
		rect(posX + border, posY + border, w, h);
		strokeWeight(strokeWeight);
		strokeCap(SQUARE);
		array = a;
		colours = c;
		max = a.length;
		for (int i = 0; i < a.length; i++) {
			if(c[i] == 0) {
				stroke(p.barF);
			}
			else if (c[i] == 1) {
				stroke(255, 0, 0);
			}
			else {
				stroke(0, 255, 0);
			}
			float x1 = map(i, 0, a.length, posX, posX + w) + border + spacer;
			float y1 = map(a[i], 0, max, posY + h + border, posY + border);
			float barHeight = map(a[i], 0, max, 0, h);
			line(x1, y1, x1, y1 + barHeight);
		}
		noFill();
		strokeWeight(1*px);
		stroke(p.accent);
		rect(posX + border, posY + border, w, h);
		strokeCap(ROUND);
	}

	// Used for rendering small thumbnail barcharts
	void renderSimple(int[] a, Thumbnail t) {
		strokeWeight = w / a.length;
		fill(p.barB);
		noStroke();
		rect(posX - t.offsetXY, posY + t.offsetXY, w, h);
		strokeWeight(strokeWeight);
		strokeCap(SQUARE);
		max = a.length - 1;
		stroke(p.barF);
		for (int i = 0; i < a.length; i++) {
			float x1 = map(i, 0, a.length, posX - t.offsetXY, posX - t.offsetXY + w);
			float y1 = map(a[i], 0, max, posY + t.offsetXY + h, posY + t.offsetXY);
			float barHeight = map(a[i], 0, max, 0, h);
			line(x1, y1, x1, y1 + barHeight);
		}
		strokeCap(ROUND);
	}
}