class SelectionSort extends Algorithm{

	boolean sorted;
	boolean swapping;
	int counter;
	int pos1, pos0, posMin;
	// int stop;
	int[] array;
	int[] colours;

	public SelectionSort(int[] array, int[] colours) {
		sorted = false;
		swapping = false;
		pos1 = 1;
		pos0 = 0;
		posMin = 0;
		this.array = array;
		this.colours = colours;
		counter = array.length;
		// stop = 0;
	}

	void reset(int[] array, int[] colours) {
		sorted = false;
		swapping = false;
		pos1 = 1;
		pos0 = 0;
		posMin = 0;
		this.array = array;
		this.colours = colours;
		counter = array.length;
		// stop = 0;
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
				output.println("\nAlgorithm: Selection Sort\nSpeed: "	+ menu.speedSlider.getVal()
					 + "\nArray size: " + arr.length + "\nSound: " + volume.active + 
					 "\n Mirrored: " + menu.mirrorSwitch.active);
				break;
			}
		}
	}

	void stepThrough() {
		checkSorted();
		if (!sorted) {
			if (pos1 == array.length) {
				pos0++;
				posMin = pos0;
				pos1 = pos0 + 1;
				//loop, not compare
				compare();
			} else {
				compare();
			}
		}
	}

	void compare() {
		comparisons++;
		colours[posMin] = 1;
		colours[pos1] = 1;
		if (pos0 > 0) {
			colours[pos0 - 1] = 2;
		}
		if (desc) {
			if (array[pos1] > array[posMin]) {
				posMin = pos1;
			}
		} else {
			if (array[pos1] < array[posMin]) {
				posMin = pos1;
			}
		}
		if (pos1 == array.length - 1) {
			if (swapping) {
				swap();
				swapping = false;
				colours[pos1] = 0;
				colours[pos0] = 1;
			} else {
				swapping = true;
			}
		}
		if (!swapping) {
			pos1++;
		}
	}

	void swap() {
		assignments++;
		int temp = array[pos0];
		array[pos0] = array[posMin];
		array[posMin] = temp;
	}

	void checkSorted() {
		boolean sorted = true;
		if (desc) {
			for(int i = 1; i < array.length; i++) {
				if(array[i] > array[i - 1]) {
					sorted = false;
					break;
				}
			}
		} else {
			for(int i = 1; i < array.length; i++) {
				if(array[i] < array[i - 1]) {
					sorted = false;
					break;
				}
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