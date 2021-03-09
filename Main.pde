
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
	// fullScreen(P2D, 1);
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
	sizeSlider = new Slider(370, 30, 150, 20, arrayMin, arrayMax, arraySize);
	soundAttSlider = new Slider(530, 30, 150, 20, 0.001, 1.0, 0.001);
	soundSusTSlider = new Slider(530, 50, 150, 20, 0.001, 1.0, 0.004);
	soundSusLSlider = new Slider(530, 70, 150, 20, 0.001, 1.0, 0.3);
	soundRelSlider = new Slider(530, 90, 150, 20, 0.001, 1.0, 0.2);
	// slider2 = new Slider(110, 30, 150, 20);

	//Sounds
	triOsc = new TriOsc(this); 
	env = new Env(this);
	sound = new Sound(attackTime, sustainTime, sustainLevel, releaseTime, 100, 700);
	// triOsc.freq(200);
	// env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
	sound();


	components.add(play);
	play.render();
}

void draw() {
	update();
	count++;

	// sound();
	// if (count % 60 == 0) {
	// 	sound();
	// 	println("Time: " + time + "att: " + soundAttSlider.getValFloat());
	// 	println("Time: " + time + "susT: " + soundSusTSlider.getValFloat());
	// 	println("Time: " + time + "susL: " + soundSusLSlider.getValFloat());
	// 	println("Time: " + time + "rel: " + soundRelSlider.getValFloat());
	// 	time++;
	// }

	background(0);
	if (count % CalcSpeed.getModulus(speed) == 0) {
		if (!bubble.sorted && play.active) {
			bubble.steps(CalcSpeed.getNumSteps(speed));
			sound.play();
		}
	}
	b.render(bubble.getArray(), bubble.getColours());
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
	// for (int i = 0; i < components.size(); i++) {
	// 	Component b = components.get(i);
	// 	if(c instanceof Play) {
	// 		((Play)b).mouseUp();
	// 	}
	// }
}

void sound() {
	// for (int i = 0; i < 50; i++) {
	// 	float fq = map(i, 0, 50, 100, 700);
	// 	triOsc.freq(fq);
	// 	env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
	// }

	sound.setAtt(soundAttSlider.getValFloat());
	sound.setSusL(soundSusTSlider.getValFloat());
	sound.setSusT(soundSusLSlider.getValFloat());
	sound.setRel(soundRelSlider.getValFloat());
	float fq = (float)((Math.random() * 500) + 100);
	triOsc.freq(fq);
	sound.play();

	// int[] a = bubble.getArray();
	// float fq = map(a[bubble.oldPos1], 1, arrayMax, 200, 600);
	// triOsc.freq(fq);
	// env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
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

