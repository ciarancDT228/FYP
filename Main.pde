
import java.util.*;
import processing.sound.*;

ArrayList<Component> components = new ArrayList<Component>();

Queue<int[]> queue = new LinkedList<int[]>();

float px;
float py;
float menuLerp;
Palette p;
PFont pf;
float fontSize;
Barchart b;

BubbleSort bubble;
SelectionSort selection;
MergeSort mergeSort;

// Buttons and Sliders
Play play;
Reset reset;
AudioBtn volume;
SettingsBtn settingsBtn;
// Slider speedSlider;

// Arrays and counters
int[] array;
int[] colours;
int count = 0;
int count2 = 0;
int time = 0;
int comparisons = 0;
int assignments = 0;

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
Sound s;
float maxFreq = 700;
TriOsc triOsc;
Env env;
MySound sound;
Slider soundAttSlider;
Slider soundSusTSlider;
Slider soundSusLSlider;
Slider soundRelSlider;
float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.3;
float releaseTime = 0.2;

Menu menu;

void settings() {
	// size(1000, 600, OPENGL);
	// size(1536, 846, P2D);
	// size(800, 500, P2D);
	// fullScreen(P2D, SPAN);
	fullScreen(P2D, 2);
	// size(800, 500, P2D);
	// fullScreen(1);
	noSmooth();
}

void setup()
{
	px = (width*5.2083333*pow(10, -4));
	py = (height*9.2592592*pow(10, -4));
	p = new Palette();
	fontSize = 16*py;
	pf = createFont("OpenSans-Regular.ttf", fontSize);
	menuLerp = 0.5;
	// surface.setResizable(true);

	b = new Barchart(0, 0, width, height - 70*py, 10*px); //Barchart
	// b = new Barchart(0, 0, width, height, 20*px); //Barchart
	arrayMax = width;
	arrayMin = 16; //Min array size
	// arraySize = (int)b.w/2; //Initial array size
	arraySize = width/30;
	array = GenerateArray.random(arraySize); //Generate
	colours = GenerateArray.blanks(arraySize);

	//Algorithms
	bubble = new BubbleSort(array, colours);
	selection = new SelectionSort(array, colours);
	mergeSort = new MergeSort(array, colours);
	

	//Buttons
	play = new Play(910*px, 990*py, 100*px, 100*py);
	reset = new Reset(840*px, 1015*py, 50*px, 50*py);
	volume = new AudioBtn(1030*px, 1015*py, 50*px, 50*py);

	// noStroke();
	// fill(p.foreground);
	// play = new Play(910*px, 970*py, 100*px, 100*py);
	// reset = new Reset(840*px, 995*py, 50*px, 50*py);
	// volume = new AudioBtn(1030*px, 995*py, 50*px, 50*py);

	// volume = new AudioBtn(500*px, 500*py, 500*px, 500*py);
	settingsBtn = new SettingsBtn(1850*px, 1005*py, 70*px, 70*py);
	//Sliders

	//Sounds
	s = new Sound(this);
	triOsc = new TriOsc(this); 
	env = new Env(this);
	// Menus
	menu = new Menu();
	sound = new MySound(attackTime, sustainTime, sustainLevel, releaseTime, 50, 1200);
	reset.reset();
}

void draw() {
	update();
	count++;
	count2+=500;

	
	background(0);

	// Statistics
	noStroke();
	fill(p.foreground);
	rect(0, height-70*py, width, 80*py);
	fill(p.font);
	textAlign(LEFT, TOP);
	text("Array comparisons:", 10*px, height - 70*py);
	text(comparisons, 165*px, height - 70*py);
	textAlign(LEFT, BOTTOM);
	text("Array assignments:", 10*px, height - fontSize);
	text(assignments, 165*px, height - fontSize);

	if (count % CalcSpeed.getModulus(speed) == 0 && play.active) {

		// Mergesort
		if(menu.algMenu.mergeBtn.active == true) {
			if (!mergeSort.sorted) {
				mergeSort.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			}
			array = mergeSort.getArray();
			colours = mergeSort.getColours();

		// Bubblesort
		} else if(menu.algMenu.bubbleBtn.active == true) {
			if (!bubble.sorted) {
				bubble.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			}
			array = bubble.getArray();
			colours = bubble.getColours();

		// Selectionsort
		} else if(menu.algMenu.selectionBtn.active == true) {
			if (!selection.sorted) {
				selection.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			}
			array = selection.getArray();
			colours = selection.getColours();

		// Bubblesort (placeholder)
		} else if(menu.algMenu.randomBtn.active == true) {
			if (!bubble.sorted) {
				bubble.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			}
			array = bubble.getArray();
			colours = bubble.getColours();
		}
	}
	b.render(array, colours);
	// noStroke();
	// fill(p.foreground);
	// rect(865*px, 995*py, 190*px, 50*py);
	menu.render();
	play.render();
	reset.render();
	volume.render();
	settingsBtn.render();
}

void update() {
	// px = (width*5.2083333*pow(10, -4));
	// py = (height*9.2592592*pow(10, -4));
	play.update();
	reset.update();
	volume.update();
	menu.update();
	settingsBtn.update();
}

void mousePressed() {
	play.mouseDown();
	reset.mouseDown();
	volume.mouseDown();
	menu.mouseDown();
	settingsBtn.mouseDown();
}

void mouseReleased() {
	play.mouseUp();
	reset.mouseUp();
	volume.mouseUp();
	menu.mouseUp();
	settingsBtn.mouseUp();
	// Closing Menu if clicked anywhere outside of menu or buttons
	if (mouseX < width - menu.w - b.border) {
		if (!(play.correctLocation() || reset.correctLocation() || volume.correctLocation()) && menu.wTarget == width - 436*px) {
			menu.toggleMenu = true;
			if (settingsBtn.rtarget == radians(-90)) {
				settingsBtn.rtarget = radians(0);
				menu.wTarget = width;
			} else {
				settingsBtn.rtarget = radians(-90);
				menu.wTarget = width - 436*px;
			}
		}
	}
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