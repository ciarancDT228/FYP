class MergeSort {

	Queue<int[]> lrQueue = new LinkedList<int[]>();
	Queue<Integer> mergeQueue = new LinkedList<Integer>();
	boolean sorted;
	// boolean swapping;
	boolean startMerge;
	boolean endMerge;
	boolean first;
	int counterA;
	int counterL, counterR;
	int sizeL, sizeR;
	int l, m, r;
	int[] array;
	int[] copy;
	int[] colours;
	int[] positions;
	int numsteps;
	// int stop;

	public MergeSort(int[] array, int[] colours) {
		lrQueue.clear();
		mergeQueue.clear();
		fillQueue(0, (array.length-1) * 2);
		sorted = false;
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
		this.array = array;
		this.copy = array;
		this.colours = colours;
		numsteps = 0;
		// stop = -1;
	}

	void reset(int[] array, int[] colours) {
		lrQueue.clear();
		mergeQueue.clear();
		fillQueue(0, (array.length-1) * 2);
		sorted = false;
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
		this.array = array;
		this.copy = array;
		this.colours = colours;
		numsteps = 0;
	}

	void steps(int x) {
		numsteps = x;

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
		println("\n --New Step");
		checkSorted();
		if (!sorted) {
			println("if not sorted");
			//Colours
			if (counterL == sizeL && counterR == sizeR) {
				startMerge = true;
			}
			//Merge
			if (startMerge) {
				if (mergeQueue.size() > 0) {
					println("Merge");
					merge();
				} else {
					startMerge = false;
					endMerge = true;
					// stop = counterA - 1;
				}
			}
			//Reset
			if (endMerge) {
				println("if endMerge");
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
					println("\nLine 96\ncounterL = " + counterL + "\tsizeL = " + sizeL + "\tl = " + l + 
					"\ncounterR = " + counterR + "\tsizeR = " + sizeR + "\tr = " + r);
				} else {
					sorted = true;
				}
			}
			//Compare
			if (!startMerge && !endMerge) {
				println("compare");
				compare();
			}
		}
	}

	void compare() {
		println("\nBefore\tcounterL = " + counterL + "\tsizeL = " + sizeL + "\tl = " + l + "\tm = " + m + 
				"\n\t    counterR = " + counterR + "\tsizeR = " + sizeR + "\tr = " + r);
		
		if (l + counterL < colours.length && l + counterL < m + 1) {
			colours[l + counterL] = 1;
		} else {
			colours[l + counterL - 1] = 1;
		}
		if (m + 1 + counterR < colours.length && m + counterR < r) {
			colours[m + 1 + counterR] = 1;
		} else {
			colours[m + 1 + counterR - 1] = 1;
		}
		
		if (counterL < sizeL && counterR < sizeR) {
			if (array[l + counterL] <= array[m + 1 + counterR]) {
				//add value to queue
				mergeQueue.add(array[l + counterL]);
				counterL++;
			} else {
				//add value to queue
				mergeQueue.add(array[m + 1 + counterR]);
				counterR++;
			}
		//get the stragglers
		} else if (counterL < sizeL) {
			mergeQueue.add(array[l + counterL]);
			counterL++;
		} else if (counterR < sizeR) {
			mergeQueue.add(array[m + 1 + counterR]);
			counterR++;
		} else {
			//merge flag
			startMerge = true;
		}
		println("After\tcounterL = " + counterL + "\tsizeL = " + sizeL + "\tl = " + l + "\tm = " + m + 
				"\n\t    counterR = " + counterR + "\tsizeR = " + sizeR + "\tr = " + r);
	}

	void merge() {
		colours[counterA] = 2;
		array[counterA] = mergeQueue.remove();
		// println("\nLine 130\ncounterA = " + counterA + "\tmergeQueue removed = " + array[counterA]);
		counterA++;
		// if (mergeQueue.size() == 0) {
		// 	startMerge = false;
		// 	endMerge = true;
		// }
	}


		// Merges two subarrays of arr[].
	    // First subarray is arr[l..m]
	    // Second subarray is arr[m+1..r]

	    // Find sizes of two subarrays to be merged

	    /* Create temp arrays of this ^ size */

	    /*Copy data to temp arrays*/

	    /* Merge the temp arrays */

	    // Initial indexes of first and second subarrays

	    // Initial index of merged subarry array

	    /* Copy remaining elements of L[] if any */

	    /* Copy remaining elements of R[] if any */

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