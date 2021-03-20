
class BubbleSort extends Algorithm {

	boolean sorted;
	boolean swapping;
	int counter;
	int pos1, pos0;
	int stop;
	int[] array;
	int[] colours;

	public BubbleSort(int[] array, int[] colours) {
		sorted = false;
		swapping = false;
		pos1 = 1;
		pos0 = 0;
		this.array = array;
		this.colours = colours;
		counter = array.length;
		stop = array.length;
	}

	void reset(int[] array, int[] colours) {
		sorted = false;
		swapping = false;
		pos1 = 1;
		pos0 = 0;
		this.array = array;
		this.colours = colours;
		counter = array.length;
		stop = array.length;
	}

	void steps(int x, int[] arr, int[] colours) {
		this.array = arr;
		this.colours = colours;

		for (int i = 0; i < colours.length; i++) {
			colours[i] = 0;
		}
		for (int i = 0; i < x; i++) {
			if (!sorted) {
				stepThrough();
			} else {
				play.active = false;
				break;
			}
		}
	}

	void stepThrough() {
		checkSorted();
		if (!sorted) {
			if (pos1 < stop) {
				compare();
			} else {
				stop--;
				pos1 = 1;
				pos0 = 0;
				compare();
			}
		}
	}

	void compare() {
		comparisons++;
		colours[pos1] = 1;
		colours[pos0] = 1;
		if (array[pos1] < array[pos0]) {
			if (swapping) {
				swap();
				swapping = false;
			} else {
				swapping = true;
			}
		}
		if (!swapping) {
			pos1++;
			pos0++;
		}
	}

	void swap() {
		assignments++;
		int temp = array[pos0];
		array[pos0] = array[pos1];
		array[pos1] = temp;
		colours[pos1] = 2;
	}

	void checkSorted() {
		boolean sorted = true;
		for(int i = 1; i < array.length; i++) {
			if(array[i] < array[i - 1]) {
				sorted = false;
				break;
			}
		}
		this.sorted = sorted;
	}

	public int[] getArray() {
		return array;
	}

	public int[] getColours() {
		return colours;
	}

}