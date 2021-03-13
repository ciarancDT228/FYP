
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

	public Barchart(float posX, float posY, float w, float h) {
		border = 0;
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

		if (a.length > w / 2) {
			strokeWeight = w / a.length;
		} else {
			strokeWeight = (w-(a.length-1))/a.length;
			spacer = strokeWeight/2;
		}
		fill(100);
		noStroke();
		rect(posX, posY, w + border*2, h + border*2);
		fill(255);
		strokeWeight(strokeWeight);
		strokeCap(SQUARE);
		stroke(255);
		array = a;
		colours = c;
		max = getMax();
		for (int i = 0; i < a.length; i++) {
			if(c[i] == 0) {
				stroke(255);
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
		strokeCap(ROUND);
	}

	float getMax() {
		float max = 0;
		for (int i = 0; i < array.length; i++) {
			if(array[i] > max) {
				max = array[i];
			}
		}
		return max;
	}

	//------------------------------------------------------------------------------------------------
	void render2(int[] a, int[] c) {
		strokeWeight(1);
		stroke(0);
		array = a;
		colours = c;
		max = getMax();
		barWidth = w/array.length;
		for (int i = 0; i < array.length; i++) {
			if(c[i] == 0) {
				fill(255);
			}
			else if (c[i] == 1) {
				fill(255, 0, 0);
			}
			else {
				fill(0, 255, 0);
			}
			float x1 = map(i, 0, array.length, 0, w) + border;
			float y1 = map(array[i], 0, max, h+border, border);
			float barHeight = map(array[i], 0, max, 0, h);
			rect(x1, y1, barWidth, barHeight);
		}
	}
}


