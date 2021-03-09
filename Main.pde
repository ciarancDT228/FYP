
import processing.sound.*;
ArrayList<Component> components = new ArrayList<Component>();


Barchart b;
ArrayGenerator gen;
BubbleSort bubble;
Algorithm algo;
Play play;
Reset reset;
Slider speedSlider;
Slider sizeSlider;
// Slider slider2;
int[] array;
int[] colours;
int count = 0;
int count2 = 0;
int arraySize;
int arrayMax;
int arrayMin;
int stepsPerSecond = 1;
int maxSteps = 3840;
int minSteps = 1;

//Sound stuff
TriOsc triOsc;
Env env;
// Oscillator wave;
float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.3;
float releaseTime = 0.2;

void settings() {
	// size(1000, 600, OPENGL);
	// size(800, 600, P2D);
	// fullScreen(P2D, SPAN);
	fullScreen(P2D, 1);
	// fullScreen(1);
	noSmooth();
}

void setup()
{
	// surface.setResizable(true);
	background(0);
	stroke(0);
	// noStroke();
	fill(255);
	gen = new ArrayGenerator();
	b = new Barchart(0, 0, width, height);
	arrayMax = (int)((b.w/2));
	arrayMin = 10;
	arraySize = arrayMin;
	println(arrayMax);
	array = gen.random(arraySize);
	colours = gen.blanks(arraySize);
	bubble = new BubbleSort(array, colours);

	//Buttons
	play = new Play(10, 10, 90, 50);
	reset = new Reset(270, 10, 90, 50);
	//Sliders
	speedSlider = new TickSlider(110, 30, 150, 20, 0, 14);
	sizeSlider = new SizeSlider(570, 30, 150, 20);
	// slider2 = new Slider(110, 30, 150, 20);

	//Sounds
	triOsc = new TriOsc(this); 
	env = new Env(this);
	// wave = new Oscillator(this);
	triOsc.freq(200);
	env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);


	components.add(play);
	play.render();
}

void draw() {
	update();
	count++;

	background(0);
	if(count % CalcSpeed.getModulus(speedSlider.getVal()) == 0) {
		if(!bubble.sorted && play.active) {
			bubble.steps(CalcSpeed.getNumSteps(speedSlider.getVal()));
			// int[] a = bubble.getArray();
			// float fq = map(a[bubble.oldPos1], 1, arrayMax, 200, 600);
			// triOsc.freq(fq);
			// env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
		}
	}
	b.render(bubble.getArray(), bubble.getColours());
	play.render();
	speedSlider.render();
	reset.render();
	sizeSlider.render();
	// if(count % 60 == 0) {
	// 	count2++;
	// 	println(count2);
	// }
}

void update() {
	play.update();
	speedSlider.update();
	reset.update();
	sizeSlider.update();
}

void mousePressed() {
	play.mouseDown();
	speedSlider.mouseDown();
	reset.mouseDown();
	sizeSlider.mouseDown();
}

void mouseReleased() {
	play.mouseUp();
	speedSlider.mouseUp();
	reset.mouseUp();
	sizeSlider.mouseUp();
	// for (int i = 0; i < components.size(); i++) {
	// 	Component b = components.get(i);
	// 	if(c instanceof Play) {
	// 		((Play)b).mouseUp();
	// 	}
	// }
}




//---------------------------------------------------------------------------------------------------
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

