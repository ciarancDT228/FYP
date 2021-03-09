
class BubbleSort extends Algorithm {

	boolean sorted;
	boolean swapping;
	int counter;
	int pos1, pos0;
	int oldPos1, oldPos0;
	int stop;
	int[] array;
	int[] colours;
	int numsteps;

	public BubbleSort(int[] array, int[] colours) {
		sorted = false;
		swapping = false;
		pos1 = 1;
		pos0 = 0;
		this.array = array;
		this.colours = colours;
		counter = array.length;
		stop = array.length;
		numsteps = 0;
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
		oldPos1 = 0;
		oldPos0 = 0;
		numsteps = 0;
	}

	void steps(int x) {
		numsteps = x;

		println("speedSlider.getVal: " + speedSlider.getVal());
		println("numsteps: " + numsteps);
		for (int i = 0; i < colours.length; i++) {
			colours[i] = 0;
		}
		for (int i = 0; i < x; i++) {
			if (!sorted) {
				stepThrough();
			} else {
				break;
			}
		}
	}

	void stepThrough() {
		checkSorted();
		if (!sorted) {
			if (pos1 < stop) {
				compare2();
			} else {
				stop--;
				pos1 = 1;
				pos0 = 0;
				compare2();
			}
		}
	}

	void compare() {
		colours[pos1] = 1;
		colours[pos0] = 1;
		if (array[pos1] < array[pos0]) {
			if (swapping) {
				swap();
				swapping = false;
			} else {
				swapping = true;
			}
		} if (!swapping) {
			pos1++;
			pos0++;
		}
	}

	void swap() {
		int temp = array[pos0];
		array[pos0] = array[pos1];
		array[pos1] = temp;
	}

	void compare2() {

		//If a swap is needed
		if (array[pos1] < array[pos0]) {

			//If second time: swap and colour green
			if (swapping) {
				swap();
				swapping = false;
			} else {

				//First time: don't increment, colour red
				if (pos1 < array.length) {
					colours[pos1] = 1;
				}

				// colours[pos1] = 1;
				colours[pos0] = 1;
				oldPos1 = pos1;
				oldPos0 = pos0;
				swapping = true;
			}
		} else {
			//don't swap, increment, colour red
			if (pos1 < array.length) {
				colours[pos1] = 1;
			}
			colours[pos0] = 1;
			oldPos1 = pos1;
			oldPos0 = pos0;
			pos1++;
			pos0++;
		}
	}

	void swap2() {
		int temp = array[pos0];
		array[pos0] = array[pos1];
		array[pos1] = temp;
		if(numsteps > -1) {
			colours[pos1] = 1;
			colours[pos0] = 1;
		} else {
			colours[pos1] = 2;
			colours[pos0] = 2;
		}
		pos1++;
		pos0++;
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