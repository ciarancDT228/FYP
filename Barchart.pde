
class Barchart{

	// int[] array = {45, 37, 55, 27, 38, 50, 79, 48, 104, 31, 100, 58};
	// int[] array = {1, 2, 3, 4, 5};
	int[] array;
	int[] colours;
	float border;
	float viewWidth, viewHeight;
	float w;
	float max;

	public Barchart() {
		border = 20;
		viewWidth = width - (border*2);
		viewHeight = height - (border*2);
	}

	// void update(float wid, float hei) {
	// 	border = mouseX;
	// 	viewWidth = wid - (border*2);
	// 	viewHeight = hei - (border*2);
	// 	w = viewWidth/array.length;
	// }

	void render(int[] a, int[] c) {
		strokeWeight(1);
		stroke(0);
		array = a;
		colours = c;
		max = getMax();
		w = viewWidth/array.length;
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
			float x1 = map(i, 0, array.length, 0, viewWidth) + border;
			float y1 = map(array[i], 0, max, viewHeight+border, border);
			float h = map(array[i], 0, max, 0, viewHeight);
			rect(x1, y1, w, h);
		}
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
}


