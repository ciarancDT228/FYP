
import java.util.*;
// import java.io.BufferedWriter;
// import java.io.File;
// import java.io.FileOutputStream;
// import java.io.FileWriter;
// import java.io.IOException;
// import java.io.OutputStream;
// import java.nio.file.Files;
// import java.nio.file.Paths;
import processing.sound.*;

ArrayList<Component> components = new ArrayList<Component>();
Queue<int[]> queue = new LinkedList<int[]>();
PrintWriter output;

float px;
float py;
float menuLerp;
Palette p;
PFont pf;
float fontSize;
Barchart b;
boolean desc;
boolean descThumb;


BubbleSort bubble;
SelectionSort selection;
MergeSort mergeSort;

// Buttons and Sliders
Play play;
Reset reset;
AudioBtn volume;
SettingsBtn settingsBtn;
Menu menu;
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


void settings() {
	// size(1000, 600, OPENGL);
	// size(1536, 846, P2D);
	// size(800, 500, P2D);
	// fullScreen(P2D, SPAN);
	fullScreen(FX2D, 2);
	// size(800, 500, P2D);
	// fullScreen(1);
	noSmooth();
}

void setup()
{
	output = createWriter("UserData.txt");
	px = (width*5.2083333*pow(10, -4));
	py = (height*9.2592592*pow(10, -4));
	p = new Palette();
	fontSize = 16*py;
	pf = createFont("OpenSans-Regular.ttf", fontSize);
	menuLerp = 0.5;
	// surface.setResizable(true);

	desc = false;
	descThumb = false;
	b = new Barchart(0, 0, width, height - 75*py, 20*px); //Barchart
	// b = new Barchart(0, 0, width, height, 20*px); //Barchart
	arrayMax = width;
	arrayMin = 16; //Min array size
	// arraySize = (int)b.w/2; //Initial array size
	arraySize = width/30;
	array = GenerateArray.random(arraySize); //Generate
	colours = GenerateArray.blanks(arraySize);

	menu = new Menu();

	//Algorithms
	bubble = new BubbleSort(array, colours);
	selection = new SelectionSort(array, colours);
	mergeSort = new MergeSort(array, colours, false);
	

	//Buttons
	play = new Play(925*px, 995*py, 70*px, 70*py);
	// volume = new AudioBtn(50*px, 50*py, 500*px, 500*py);
	reset = new Reset(840*px, 1005*py, 50*px, 50*py);
	volume = new AudioBtn(1030*px, 1005*py, 50*px, 50*py);
	settingsBtn = new SettingsBtn(1850*px, 1005*py, 70*px, 70*py);

	//Sounds
	s = new Sound(this);
	triOsc = new TriOsc(this); 
	env = new Env(this);
	sound = new MySound(attackTime, sustainTime, sustainLevel, releaseTime, 50, 1200);
	reset.reset();
}

void draw() {
	update();
	count++;
	count2+=500;
	
	background(p.foreground);

	if (count % CalcSpeed.getModulus(speed) == 0 && play.active) {
		// Mergesort
		if(menu.algMenu.mergeBtn.active == true) {
			// if (!mergeSort.sorted) {
				mergeSort.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			// }
			array = mergeSort.getArray();
			colours = mergeSort.getColours();

		// Bubblesort
		} else if(menu.algMenu.bubbleBtn.active == true) {
			// if (!bubble.sorted) {
				bubble.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			// }
			array = bubble.getArray();
			colours = bubble.getColours();

		// Selectionsort
		} else if(menu.algMenu.selectionBtn.active == true) {
			// if (!selection.sorted) {
				selection.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			// }
			array = selection.getArray();
			colours = selection.getColours();

		// Bubblesort (placeholder)
		} else if(menu.algMenu.randomBtn.active == true) {
			// if (!bubble.sorted) {
				bubble.steps(CalcSpeed.getNumSteps(speed), array, colours);
				sound.play();
			// }
			array = bubble.getArray();
			colours = bubble.getColours();
		} else {
			play.active = false;
		}
	}
	b.render(array, colours);
	p.display(100*px, 25*py, 100*px, 800*py);
	// noStroke();
	// fill(p.foreground);
	// rect(865*px, 995*py, 190*px, 50*py);
	menu.render();

	// Statistics
	noStroke();
	fill(p.font);
	textAlign(LEFT, TOP);
	text("Array comparisons:", 10*px, height - 70*py);
	text(comparisons, 165*px, height - 70*py);
	textAlign(LEFT, BOTTOM);
	text("Array assignments:", 10*px, height - fontSize);
	text(assignments, 165*px, height - fontSize);
	
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

@ Override void exit() {
	output.flush();
	output.close();
    super.exit();
}