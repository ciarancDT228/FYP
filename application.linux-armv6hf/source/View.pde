// class View {

// 	float posX, posY, w, h;

// 	// Array
// 	int arraySize;
// 	int arrayMax;
// 	int arrayMin;
// 	int[] array;
// 	int[] colours;
// 	Barchart b;

// 	//Speed
// 	int speed = 1;
// 	int stepsPerSecond = 1;
// 	int maxSteps = 3840;
// 	int minSteps = 1;

// 	//Algorithms
// 	BubbleSort bubble;
// 	SelectionSort selection;
// 	MergeSort mergeSort;

// 	Menu menu;

// 	public View(float posX, float posY, float w, float h) {
// 		this.posX = posX;
// 		this.posY = posY;
// 		this.w = width;
// 		this.h = height;

// 		//Array
// 		arrayMax = width;
// 		arrayMin = 10; //Min array size
// 		arraySize = 20;
// 		array = GenerateArray.random(arraySize); //Generate
// 		colours = GenerateArray.blanks(arraySize);

// 		//Algorithms
// 		bubble = new BubbleSort(array, colours);
// 		selection = new SelectionSort(array, colours);
// 		mergeSort = new MergeSort(array, colours);

// 		menu = new Menu();
// 		b = new Barchart(this.posX, this.posY, this.w, this.h, 10*px);
// 	}

// 	void render() {

		
// 		b.render(array, colours);

// 		menu.render();
// 	}

// 	void update() {
// 		iterateAlgorithm();
// 		menu.update();
// 	}

// 	void mousePressed() {
// 		menu.mouseDown();
// 	}

// 	void mouseReleased() {
// 		menu.mouseUp();
// 	}

// 	void iterateAlgorithm() {
// 		// Algorithm iterator
// 		if (count % CalcSpeed.getModulus(speed) == 0) {

// 			// Mergesort
// 			if(menu.algMenu.mergeBtn.active == true) {
// 				if (!mergeSort.sorted && play.active) {
// 					mergeSort.steps(CalcSpeed.getNumSteps(speed), array, colours);
// 					sound.play();
// 				}
// 				array = mergeSort.getArray();
// 				colours = mergeSort.getColours();

// 			// Bubblesort
// 			} else if(menu.algMenu.bubbleBtn.active == true) {
// 				if (!bubble.sorted && play.active) {
// 					bubble.steps(CalcSpeed.getNumSteps(speed), array, colours);
// 					sound.play();
// 				}
// 				array = bubble.getArray();
// 				colours = bubble.getColours();

// 			// Selectionsort
// 			} else if(menu.algMenu.selectionBtn.active == true) {
// 				if (!selection.sorted && play.active) {
// 					selection.steps(CalcSpeed.getNumSteps(speed), array, colours);
// 					sound.play();
// 				}
// 				array = selection.getArray();
// 				colours = selection.getColours();

// 			// Bubblesort (placeholder)
// 			} else if(menu.algMenu.randomBtn.active == true) {
// 				if (!bubble.sorted && play.active) {
// 					bubble.steps(CalcSpeed.getNumSteps(speed), array, colours);
// 					sound.play();
// 				}
// 				array = bubble.getArray();
// 				colours = bubble.getColours();
// 			}
// 		}
// 	}
// }
