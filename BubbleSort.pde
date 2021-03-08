
class BubbleSort extends Algorithm {

	boolean sorted;
	boolean swapping;
	int counter;
	int pos1;
	int pos0;
	int oldPos1;
	int oldPos0;
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
	}

	void reset(int[] array, int[] colours) {
		sorted = false;
		swapping = false;
		pos1 = 1;
		pos0 = 0;
		this.array = array;
		this.colours = colours;
		counter = array.length;
	}

	void steps(int x) {
		for(int i = 0; i < x; i++) {
			if(!sorted) {
				stepThrough();
			} else {
				break;
			}
		}
	}

	void stepThrough() {
		colours[oldPos1] = 0;
		colours[oldPos0] = 0;
		//If not at the end of the loop
		if(pos1 < array.length) {
			compare();
		}
		else if (!checkSorted()) {
			// colours[pos0] = 0;
			pos1 = 1;
			pos0 = 0;
			compare();
		}
		else {
			this.sorted = true;
		}
	}

	void compare() {
		if(array[pos1] < array[pos0]) {
			//Second time: swap and colour green
			if(swapping) {
				swap();
				swapping = false;
			}
			else {
				//First time: don't increment, colour red
				if(pos1 < array.length) {
					colours[pos1] = 1;
				}
				// colours[pos1] = 1;
				colours[pos0] = 1;
				oldPos1 = pos1;
				oldPos0 = pos0;
				swapping = true;
			}
		}
		else {
			//don't swap, increment, colour red
			if(pos1 < array.length) {
				colours[pos1] = 1;
			}
			colours[pos0] = 1;
			oldPos1 = pos1;
			oldPos0 = pos0;
			pos1++;
			pos0++;
		}
	}

	void swap() {
		int temp = array[pos0];
		array[pos0] = array[pos1];
		array[pos1] = temp;
		colours[pos1] = 2;
		colours[pos0] = 2;
		pos1++;
		pos0++;
	}

	boolean checkSorted() {
		boolean sorted = true;
		for(int i = 1; i < array.length; i++) {
			if(array[i] < array[i - 1]) {
				sorted = false;
				break;
			}
		}
		return sorted;
	}

	public int[] getArray() {
		return array;
	}

	public int[] getColours() {
		return colours;
	}

}