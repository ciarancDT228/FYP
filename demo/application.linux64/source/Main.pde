
import java.util.*;
import processing.sound.*;

ArrayList<Component> components = new ArrayList<Component>();

Queue<int[]> queue = new LinkedList<int[]>();

float px;
float py;
Palette p;
Barchart b;

BubbleSort bubble;
SelectionSort selection;
MergeSort mergeSort;

// Buttons and Sliders
Play play;
Reset reset;
Settings settings;
// Slider speedSlider;

// Arrays and counters
int[] array;
int[] colours;
int count = 0;
int count2 = 0;
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
MySound sound;
Sound s;
Slider soundAttSlider;
Slider soundSusTSlider;
Slider soundSusLSlider;
Slider soundRelSlider;
float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.3;
float releaseTime = 0.2;

// Menus
// AlgMenu algorithmMenu;
Menu menu;

void settings() {
	// size(1000, 600, OPENGL);
	// size(1536, 846, P2D);
	// size(1024, 768, P2D);
	// fullScreen(P2D, SPAN);
	fullScreen(P2D, 2);
	// size(800, 500, P2D);
	// fullScreen(1);
	noSmooth();
}

void setup()
{
	// println(sketchPath());
	px = (width*5.2083333*pow(10, -4));
	py = (height*9.2592592*pow(10, -4));
	p = new Palette();
	// surface.setResizable(true);

	b = new Barchart(0, 0, width, height, 5*px); //Barchart
	arrayMax = width/3;
	arrayMin = 10; //Min array size
	// arraySize = (int)b.w/2; //Initial array size
	arraySize = 10;
	array = GenerateArray.random(arraySize); //Generate
	colours = GenerateArray.blanks(arraySize);

	//Algorithms
	bubble = new BubbleSort(array, colours);
	selection = new SelectionSort(array, colours);
	mergeSort = new MergeSort(array, colours);
	// mergeSort.printQueue();
	// mergeSort.fillQueue(0, 30);
	

	//Buttons
	play = new Play(910*px, 960*py, 100*px, 100*py);
	reset = new Reset(830*px, 975*py, 70*px, 70*py);
	settings = new Settings(1860*px, 1020*py, 50*px, 50*py);
	//Sliders
	// speedSlider = new TickSlider(80*px, 1000*py, 740*px, 20*py, 1, 14); //Speed

	//Sounds
	triOsc = new TriOsc(this); 
	env = new Env(this);
	// Menus
	menu = new Menu();
	sound = new MySound(attackTime, sustainTime, sustainLevel, releaseTime, 50, 1200);
}

void draw() {
	update();
	count++;

	
	background(0);

	if (count % CalcSpeed.getModulus(speed) == 0) {

		// Mergesort
		if(menu.algMenu.mergeBtn.active == true) {
			if (!mergeSort.sorted && play.active) {
				mergeSort.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			}
			array = mergeSort.getArray();
			colours = mergeSort.getColours();

		// Bubblesort
		} else if(menu.algMenu.bubbleBtn.active == true) {
			if (!bubble.sorted && play.active) {
				bubble.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			}
			array = bubble.getArray();
			colours = bubble.getColours();

		// Selectionsort
		} else if(menu.algMenu.selectionBtn.active == true) {
			if (!selection.sorted && play.active) {
				selection.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			}
			array = selection.getArray();
			colours = selection.getColours();

		// Bubblesort (placeholder)
		} else if(menu.algMenu.randomBtn.active == true) {
			if (!bubble.sorted && play.active) {
				bubble.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			}
			array = bubble.getArray();
			colours = bubble.getColours();
		}
	}
	b.render(array, colours);

	// background(0);
	menu.render();
	play.render();
	reset.render();
	settings.render();
}

void update() {
	// px = (width*5.2083333*pow(10, -4));
	// py = (height*9.2592592*pow(10, -4));
	play.update();
	// speedSlider.update();
	reset.update();
	menu.update();
	settings.update();
}

void mousePressed() {
	play.mouseDown();
	// speedSlider.mouseDown();
	reset.mouseDown();
	menu.mouseDown();
	settings.mouseDown();
}

void mouseReleased() {
	play.mouseUp();
	// speedSlider.mouseUp();
	reset.mouseUp();
	menu.mouseUp();
	settings.mouseUp();
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
