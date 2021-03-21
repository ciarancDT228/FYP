class MergeSort {

	Queue<int[]> lrQueue = new LinkedList<int[]>();
	Queue<Integer> mergeQueue = new LinkedList<Integer>();
	boolean sorted;
	// boolean swapping;
	boolean startMerge;
	boolean endMerge;
	boolean first;
	// boolean desc;
	int counterA;
	int counterL, counterR;
	int sizeL, sizeR;
	int l, m, r;
	int[] array;
	int[] copy;
	int[] colours;
	int[] positions;
	// int stop;

	public MergeSort(int[] array, int[] colours) {
		this.array = array;
		this.copy = array;
		this.colours = colours;
		lrQueue.clear();
		mergeQueue.clear();
		fillQueue(0, (array.length-1) * 2);
		sorted = false;
		checkSorted();
		// swapping = false;
		startMerge = false;
		endMerge = true;
		first = false;
		// desc = false;
		counterA = 0;
		counterL = 0;
		counterR = 0;
		sizeL = 0;
		sizeR = 0;
		l = 0;
		m = 0;
		r = 0;
		// stop = -1;
	}

	void reset(int[] array, int[] colours) {
		this.array = array;
		this.copy = array;
		this.colours = colours;
		lrQueue.clear();
		mergeQueue.clear();
		fillQueue(0, (array.length-1) * 2);
		sorted = false;
		checkSorted();
		// swapping = false;
		startMerge = false;
		endMerge = true;
		first = false;
		counterA = 0;
		counterL = 0;
		counterR = 0;
		sizeL = 0;
		sizeR = 0;
		l = 0;
		m = 0;
		r = 0;
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
				output.println("\nAlgorithm: Merge Sort\nSpeed: "	+ menu.speedSlider.getVal()
					 + "\nArray size: " + arr.length + "\nSound: " + volume.active);
				break;
			}
		}
	}

	void stepThrough() {
		// println("\n --New Step");
		checkSorted();
		if (!sorted) {
			// println("if not sorted");
			//Colours
			if (counterL == sizeL && counterR == sizeR) {
				startMerge = true;
			}
			//Merge
			if (startMerge) {
				if (mergeQueue.size() > 0) {
					// println("Merge");
					merge();
				} else {
					startMerge = false;
					endMerge = true;
					// stop = counterA - 1;
				}
			}
			//Reset
			if (endMerge) {
				// println("if endMerge");
				if (lrQueue.size() > 0) {
					positions = lrQueue.remove();
					l = positions[0];
					m = positions[1];
					r = positions[2];
					counterL = 0;
					counterR = 0;
					counterA = l;
					sizeL = m - l + 1;
					sizeR = r - m;
					endMerge = false;
					first = true;
					// println("\nLine 96\ncounterL = " + counterL + "\tsizeL = " + sizeL + "\tl = " + l + 
					// "\ncounterR = " + counterR + "\tsizeR = " + sizeR + "\tr = " + r);
				} else {
					sorted = true;
				}
			}
			//Compare
			checkSorted();
			if (!startMerge && !endMerge && !sorted) {
				// println("compare");
				compare();
			}
		}
	}

	void compare() {
		// println("\nBefore\tcounterL = " + counterL + "\tsizeL = " + sizeL + "\tl = " + l + "\tm = " + m + 
		// 		"\n\t    counterR = " + counterR + "\tsizeR = " + sizeR + "\tr = " + r);

		// Colours
		if (l + counterL < colours.length && l + counterL < m + 1) {
			colours[l + counterL] = 1;
		} else {
			colours[l + counterL - 1] = 1;
		}
		if (m + 1 + counterR < colours.length && m + counterR < r) {
			colours[m + 1 + counterR] = 1;
		} else if (!desc){
			colours[m + 1 + counterR - 1] = 1;
		}

		// Comparison
		if (counterL < sizeL && counterR < sizeR) {
			if (desc) {
				if (array[l + counterL] >= array[m + 1 + counterR]) {
					//add value to queue
					mergeQueue.add(array[l + counterL]);
					counterL++;
				} else {
					//add value to queue
					mergeQueue.add(array[m + 1 + counterR]);
					counterR++;
				}
			} else {
				if (array[l + counterL] <= array[m + 1 + counterR]) {
					//add value to queue
					mergeQueue.add(array[l + counterL]);
					counterL++;
				} else {
					//add value to queue
					mergeQueue.add(array[m + 1 + counterR]);
					counterR++;
				}
			}
			comparisons++;
		//get the stragglers
		} else if (counterL < sizeL) {
			mergeQueue.add(array[l + counterL]);
			counterL++;
			comparisons++;
		} else if (counterR < sizeR) {
			mergeQueue.add(array[m + 1 + counterR]);
			counterR++;
			comparisons++;
		} else {
			//merge flag
			startMerge = true;
		}
		// println("After\tcounterL = " + counterL + "\tsizeL = " + sizeL + "\tl = " + l + "\tm = " + m + 
		// 		"\n\t    counterR = " + counterR + "\tsizeR = " + sizeR + "\tr = " + r);
	}

	void merge() {
		assignments++;
		colours[counterA] = 2;
		array[counterA] = mergeQueue.remove();
		counterA++;
	}

	void fillQueue(int l, int r) {
		int mid;

		if (l < r) {
			mid = l + (r - l) / 2;
			fillQueue(l, mid);
			fillQueue(mid + 1, r);
			int[] positions = {l, mid, r};
			lrQueue.add(positions);
		}
	}

	void printQueue() {
		for (int i = 0; i < lrQueue.size(); i++) {
			int[] positions = lrQueue.remove();
			println("Step " + (i+1) + ":\tl: " + positions[0] +
				"\tm: " + positions[1] + 
				"\th: " + positions[2]);
		}
	}

	void checkSorted() {
		boolean sorted = true;
		if (desc) {
			for(int i = 1; i < array.length; i++) {
				if(array[i] >= array[i - 1]) {
					sorted = false;
					break;
				}
			}
		} else {
			for(int i = 1; i < array.length; i++) {
				if(array[i] <= array[i - 1]) {
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