
import java.util.*;
import processing.sound.*;

ArrayList<Component> components = new ArrayList<Component>();

Queue<int[]> queue = new LinkedList<int[]>();

Barchart b;
ArrayGenerator gen;

BubbleSort bubble;
SelectionSort selection;
MergeSort mergeSort;

Algorithm algo;
Play play;
Reset reset;
Slider speedSlider;
Slider sizeSlider;
int[] array;
int[] colours;
int count = 0;
int time = 0;

//Array Size
int arraySize;
int arrayMax;
int arrayMin;

//Speed
int speed = 1;
int stepsPerSecond = 1;
int maxSteps = 3840;
int minSteps = 1;

//Sound stuff
float maxFreq = 700;
TriOsc triOsc;
Env env;
Sound sound;
Slider soundAttSlider;
Slider soundSusTSlider;
Slider soundSusLSlider;
Slider soundRelSlider;
float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.3;
float releaseTime = 0.2;

void settings() {
	// size(1000, 600, OPENGL);
	size(800, 600, P2D);
	// fullScreen(P2D, SPAN);
	// fullScreen(P2D, 2);
	// fullScreen(1);
	noSmooth();
}

void setup()
{
	// surface.setResizable(true);
	// noStroke();
	println(1/2);
	background(0);
	stroke(0);
	fill(255);
	gen = new ArrayGenerator(); //Array Generator
	b = new Barchart(0, 0, width, height); //Barchart
	// b = new Barchart(530, 120, 150, 20);
	// b = new Barchart(width/4, height/4, width/2, height/2);
	arrayMax = (int)((b.w/2)); //Max array size
	arrayMax = width;
	println("\n" + arrayMax);
	// arrayMax = 400; //Max array size
	arrayMin = 10; //Min array size
	arraySize = (arrayMax - arrayMin)/2; //Initial array size
	arraySize = 16;
	// println(arrayMax);
	println(arraySize);
	array = GenerateArray.random(arraySize); //Generate
	colours = GenerateArray.blanks(arraySize);

	//Algorithms
	bubble = new BubbleSort(array, colours);
	selection = new SelectionSort(array, colours);
	mergeSort = new MergeSort(array, colours);
	// mergeSort.printQueue();
	// mergeSort.fillQueue(0, 30);
	

	//Buttons
	play = new Play(10, 10, 90, 50);
	reset = new Reset(270, 10, 90, 50);
	//Sliders
	speedSlider = new TickSlider(110, 30, 150, 20, 0, 14); //Speed
	sizeSlider = new Slider(370, 30, 150, 20, arrayMin, arrayMax, arraySize); //Size
	soundAttSlider = new Slider(530, 30, 150, 20, 0.001, 1.0, 0.001); // Sound
	soundSusTSlider = new Slider(530, 50, 150, 20, 0.001, 1.0, 0.004); // Sound
	soundSusLSlider = new Slider(530, 70, 150, 20, 0.001, 1.0, 0.3); // Sound
	soundRelSlider = new Slider(530, 90, 150, 20, 0.001, 1.0, 0.2); // Sound

	//Sounds
	triOsc = new TriOsc(this); 
	env = new Env(this);
	sound = new Sound(attackTime, sustainTime, sustainLevel, releaseTime, 100, 700);
}

void draw() {
	update();
	count++;

	
	background(0);

	// //Bubble sort
	// if (count % CalcSpeed.getModulus(speed) == 0) {
	// 	if (!bubble.sorted && play.active) {
	// 		bubble.steps(CalcSpeed.getNumSteps(speed));
	// 		sound.play();
	// 	}
	// }
	// b.render(bubble.getArray(), bubble.getColours());

	// //Selection sort
	// if (count % CalcSpeed.getModulus(speed) == 0) {
	// 	if (!selection.sorted && play.active) {
	// 		selection.steps(CalcSpeed.getNumSteps(speed));
	// 		sound.play();
	// 	}
	// }
	// b.render(selection.getArray(), selection.getColours());

	//Merge sort
	if (count % CalcSpeed.getModulus(speed) == 0) {
		if (!mergeSort.sorted && play.active) {
			mergeSort.steps(CalcSpeed.getNumSteps(speed));
			sound.play();
		}
	}
	b.render(mergeSort.getArray(), mergeSort.getColours());

	play.render();
	speedSlider.render();
	reset.render();
	sizeSlider.render();
	soundAttSlider.render();
	soundSusTSlider.render();
	soundSusLSlider.render();
	soundRelSlider.render();
}

void update() {
	play.update();
	speedSlider.update();
	reset.update();
	sizeSlider.update();
	sound.update();
	// soundAttSlider.update();
	// soundSusTSlider.update();
	// soundSusLSlider.update();
	// soundRelSlider.update();
}

void mousePressed() {
	play.mouseDown();
	speedSlider.mouseDown();
	reset.mouseDown();
	sizeSlider.mouseDown();
	soundAttSlider.mouseDown();
	soundSusTSlider.mouseDown();
	soundSusLSlider.mouseDown();
	soundRelSlider.mouseDown();
}

void mouseReleased() {
	play.mouseUp();
	speedSlider.mouseUp();
	reset.mouseUp();
	sizeSlider.mouseUp();
	soundAttSlider.mouseUp();
	soundSusTSlider.mouseUp();
	soundSusLSlider.mouseUp();
	soundRelSlider.mouseUp();
}

//---------------------------------------------------------------------------------------------------
/*
int[] array1;
int[] array2;
int[] array3;
void randomTester() {
	if(mouseX > 0) {
		fill(255, 10);
		float marker = 1;
		if(count % marker == 0) {
			array1 = gen.random2(30);
			array2 = gen.asc(30);
			array3 = gen.blanks(30);
			for(int i = 0; i < array1.length; i++) {
				if(array1[i] == array2[i]) {
					array3[i] = array1[i];
					println(array1[i]);
				}
			}
			array3[0] = 30;
			// b.render(array3);
		}
	}
}

void bubble(int[] array) {
	boolean sorted = false;
	while(!sorted) {
		sorted = true;
		for(int i = 1; i < array.length; i++) {
			if(array[i] < array[i - 1]) {
				int temp = array[i - 1];
				array[i - 1] = array[i];
				array[i] = temp;
				sorted = false;
			}
		}
	}
	Barchart b2 = new Barchart(0, 0, width, height);
	// b2.render(array);
}

	// sound();
	// if (count % 60 == 0) {
	// 	sound();
	// 	println("Time: " + time + "att: " + soundAttSlider.getValFloat());
	// 	println("Time: " + time + "susT: " + soundSusTSlider.getValFloat());
	// 	println("Time: " + time + "susL: " + soundSusLSlider.getValFloat());
	// 	println("Time: " + time + "rel: " + soundRelSlider.getValFloat());
	// 	time++;
	// }

*/