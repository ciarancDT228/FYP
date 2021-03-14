import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {





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
Slider speedSlider;
Slider sizeSlider;

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
float attackTime = 0.001f;
float sustainTime = 0.004f;
float sustainLevel = 0.3f;
float releaseTime = 0.2f;

// Menus
// AlgMenu algorithmMenu;
Menu menu;

public void settings() {
	// size(1000, 600, OPENGL);
	// size(1536, 846, P2D);
	// size(800, 600, P2D);
	// fullScreen(P2D, SPAN);
	fullScreen(P2D, 2);
	// fullScreen(1);
	noSmooth();
}

public void setup()
{
	px = (width*5.2083333f*pow(10, -4));
	py = (height*9.2592592f*pow(10, -4));
	p = new Palette();
	surface.setResizable(true);
	// noStroke();
	background(0);
	stroke(0);
	fill(255);
	b = new Barchart(20*px, 20*py, width-40*px, height-40*px, 5*px); //Barchart
	// arrayMax = (int)((b.w/2)); //Max array size
	arrayMax = width;
	arrayMin = 10; //Min array size
	arraySize = (int)b.w/2; //Initial array size
	// arraySize = 680;
	array = GenerateArray.random(arraySize); //Generate
	colours = GenerateArray.blanks(arraySize);

	//Algorithms
	bubble = new BubbleSort(array, colours);
	selection = new SelectionSort(array, colours);
	mergeSort = new MergeSort(array, colours);
	// mergeSort.printQueue();
	// mergeSort.fillQueue(0, 30);
	

	//Buttons
	play = new Play(10, 10, 100, 100);
	reset = new Reset(270, 10, 90, 50);
	//Sliders
	speedSlider = new TickSlider(80*px, 920*py, 1760*px, 80*py, 1, 14); //Speed
	sizeSlider = new Slider(370, 30, 150, 20, arrayMin, arrayMax, arraySize); //Size
	soundAttSlider = new Slider(530, 30, 150, 20, 0.001f, 1.0f, 0.001f); // Sound
	soundSusTSlider = new Slider(530, 50, 150, 20, 0.001f, 1.0f, 0.004f); // Sound
	soundSusLSlider = new Slider(530, 70, 150, 20, 0.001f, 1.0f, 0.3f); // Sound
	soundRelSlider = new Slider(530, 90, 150, 20, 0.001f, 1.0f, 0.2f); // Sound

	//Sounds
	triOsc = new TriOsc(this); 
	env = new Env(this);
	sound = new MySound(attackTime, sustainTime, sustainLevel, releaseTime, 100, 700);

	// Menus
	// algorithmMenu = new AlgMenu(150*px, 150*py);
	menu = new Menu();
}

public void draw() {
	update();
	count++;

	
	background(0);

	// //Bubble sort
	// if (count % CalcSpeed.getModulus(speed) == 0) {
	// 	if (!bubble.sorted && play.active) {
	// 		count2++;
	// 		println(count2);
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
			count2++;
			println(count2);
			mergeSort.steps(CalcSpeed.getNumSteps(speed));
			sound.play();
	        //  for(int i = 0; i<colours.length-1; i++){
	        //     print(colours[i] + ", ");
        	// }
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
	// algorithmMenu.render();
	menu.render();
}

public void update() {
	px = (width*5.2083333f*pow(10, -4));
	py = (height*9.2592592f*pow(10, -4));
	play.update();
	speedSlider.update();
	reset.update();
	sizeSlider.update();
	sound.update();
	// algorithmMenu.update();
	menu.update();
}

public void mousePressed() {
	play.mouseDown();
	speedSlider.mouseDown();
	reset.mouseDown();
	sizeSlider.mouseDown();
	soundAttSlider.mouseDown();
	soundSusTSlider.mouseDown();
	soundSusLSlider.mouseDown();
	soundRelSlider.mouseDown();
	//Update algorithm thumbnails
	// algorithmMenu.mouseDown();
	menu.mouseDown();
}

public void mouseReleased() {
	play.mouseUp();
	speedSlider.mouseUp();
	reset.mouseUp();
	sizeSlider.mouseUp();
	soundAttSlider.mouseUp();
	soundSusTSlider.mouseUp();
	soundSusLSlider.mouseUp();
	soundRelSlider.mouseUp();

	// algorithmMenu.mouseUp();
	menu.mouseUp();
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
class SubMenu {

	ArrayList<Thumbnail> algThumbs;
	float posX, posY, w, h;
	boolean buttonClicked;
	Thumbnail mergeBtn;
	Thumbnail bubbleBtn;
	Thumbnail selectionBtn;
	Thumbnail randomBtn;

	public SubMenu (float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = 435*px;
		this.h = 114*py;
		println(100*px);
		println(px);
		this.mergeBtn = new MergeBtn(posX + 7*px, posY + 7*py, 100*px, 100*py);
		this.bubbleBtn = new BubbleBtn(posX + 114*px, posY + 7*py, 100*px, 100*py);
		// this.bubbleBtn.active = true;
		this.selectionBtn = new SelectionBtn(posX + 221*px, posY + 7*py, 100*px, 100*py);
		this.selectionBtn.active = true;
		this.randomBtn = new BubbleBtn(posX + 328*px, posY + 7*py, 100*px, 100*py);
		algThumbs = new ArrayList<Thumbnail>();
		algThumbs.add(mergeBtn);
		algThumbs.add(bubbleBtn);
		algThumbs.add(selectionBtn);
		algThumbs.add(randomBtn);
		buttonClicked  = false;
	}

	public void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h, 8*px);
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.render();
		}
	}

	public void updatePos() {
		this.posX = mouseX;
		this.posY = mouseY;
		this.w = 435*px;
		this.h = 114*py;
		mergeBtn.posX = mouseX + 7*px;
		bubbleBtn.posX = mouseX + 114*px;
		selectionBtn.posX = mouseX + 221*px;
		randomBtn.posX = mouseX + 328*px;
		mergeBtn.posY = mouseY + 7*py;
		bubbleBtn.posY = mouseY + 7*py;
		selectionBtn.posY = mouseY + 7*py;
		randomBtn.posY = mouseY + 7*py;
		mergeBtn.updatePos();
		bubbleBtn.updatePos();
		selectionBtn.updatePos();
		randomBtn.updatePos();
	}

	public void update() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.update();
		}
	}

	public void mouseUp() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			if (t.correctLocation() && t.depressed) {
				buttonClicked = true;
				break;
			} else {
				buttonClicked = false;
			}
		}
		if (buttonClicked) {
			for (int i = 0; i < algThumbs.size(); i++) {
				Thumbnail t = algThumbs.get(i);
				if (buttonClicked) {
					t.active = false;
					t.mouseUp();
				}
			}
		}

	}

	public void mouseDown() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.mouseDown();
		}
	}

}
class Algorithm {

	// void steps(int x) {
	// 	numsteps = x;

	// 	for (int i = 0; i < colours.length; i++) {
	// 		colours[i] = 0;
	// 	}
	// 	for (int i = 0; i < x; i++) {
	// 		if (!sorted) {
	// 			stepThrough();
	// 		} else {
	// 			break;
	// 		}
	// 	}
	// }

	// void checkSorted() {
	// 	boolean sorted = true;

	// 	for(int i = 1; i < array.length; i++) {
	// 		if(array[i] < array[i - 1]) {
	// 			sorted = false;
	// 			break;
	// 		}
	// 	}
	// 	this.sorted = sorted;
	// }

}

class Barchart{

	// int[] array = {45, 37, 55, 27, 38, 50, 79, 48, 104, 31, 100, 58};
	// int[] array = {1, 2, 3, 4, 5};
	int[] array;
	int[] colours;
	float posX, posY, w, h;
	float border;
	float strokeWeight;
	float barWidth;
	float max;
	float thickness;

	public Barchart(float posX, float posY, float w, float h, float border) {
		this.border = border;
		this.posX = posX;
		this.posY = posY;
		this.w = w - (border*2);
		this.h = h - (border*2);
	}

	// void update(float wid, float hei) {
	// 	border = mouseX;
	// 	w = wid - (border*2);
	// 	h = hei - (border*2);
	// 	barWidth = w/array.length;
	// }

	public void update() {

	}

	public void render(int[] a, int[] c) {
		float spacer = 0;

		noStroke();
		fill(p.foreground);
		rect(posX, posY,border*2 + w, border*2 + h);
		if (a.length > w / 2) {
			strokeWeight = w / a.length;
		} else {
			strokeWeight = (w-(a.length-1))/a.length;
			spacer = strokeWeight/2;
		}
		fill(p.background);
		noStroke();
		rect(posX + border, posY + border, w, h);
		// fill(255);
		strokeWeight(strokeWeight);
		strokeCap(SQUARE);
		// stroke(#ade8f4);
		array = a;
		colours = c;
		max = a.length;
		for (int i = 0; i < a.length; i++) {
			if(c[i] == 0) {
				stroke(p.font);
			}
			else if (c[i] == 1) {
				stroke(255, 0, 0);
			}
			else {
				stroke(0, 255, 0);
			}
			float x1 = map(i, 0, a.length, posX, posX + w) + border + spacer;
			float y1 = map(a[i], 0, max, posY + h + border, posY + border);
			float barHeight = map(a[i], 0, max, 0, h);
			line(x1, y1, x1, y1 + barHeight);
		}
		noFill();
		strokeWeight(1*px);
		stroke(p.accent);
		rect(posX + border, posY + border, w, h);
		strokeCap(ROUND);
	}

	// Used for rendering small thumbnail barcharts
	public void renderSimple(int[] a, Thumbnail t) {
		strokeWeight = w / a.length;
		fill(p.background);
		noStroke();
		rect(posX - t.offsetXY, posY + t.offsetXY, w, h);
		strokeWeight(strokeWeight);
		strokeCap(SQUARE);
		max = a.length - 1;
		stroke(p.font);
		for (int i = 0; i < a.length; i++) {
			float x1 = map(i, 0, a.length, posX - t.offsetXY, posX - t.offsetXY + w);
			float y1 = map(a[i], 0, max, posY + t.offsetXY + h, posY + t.offsetXY);
			float barHeight = map(a[i], 0, max, 0, h);
			line(x1, y1, x1, y1 + barHeight);
		}
		strokeCap(ROUND);
	}
}
class BubbleBtn extends Thumbnail {

	BubbleSort b;

	public BubbleBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		b = new BubbleSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		b.steps(200000);
		arr = b.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Bubble";
	}

	// void mouseUp() {
	// 	if (correctLocation() && depressed) {
	// 		super.mouseUp(this);
	// 	}
	// }

}

class BubbleSort extends Algorithm {

	boolean sorted;
	boolean swapping;
	int counter;
	int pos1, pos0;
	int stop;
	int[] array;
	int[] colours;
	int numsteps;

	public BubbleSort(int[] array, int[] colours) {
		sorted = false;
		swapping = false;
		pos1 = 1;
		pos0 = 0;
		this.array = array;
		this.colours = colours;
		counter = array.length;
		stop = array.length;
		numsteps = 0;
	}

	public void reset(int[] array, int[] colours) {
		sorted = false;
		swapping = false;
		pos1 = 1;
		pos0 = 0;
		this.array = array;
		this.colours = colours;
		counter = array.length;
		stop = array.length;
		numsteps = 0;
	}

	public void steps(int x) {
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

	public void stepThrough() {
		checkSorted();
		if (!sorted) {
			if (pos1 < stop) {
				compare();
			} else {
				stop--;
				pos1 = 1;
				pos0 = 0;
				compare();
			}
		}
	}

	public void compare() {
		colours[pos1] = 1;
		colours[pos0] = 1;
		if (array[pos1] < array[pos0]) {
			if (swapping) {
				swap();
				swapping = false;
			} else {
				swapping = true;
			}
		}
		if (!swapping) {
			pos1++;
			pos0++;
		}
	}

	public void swap() {
		int temp = array[pos0];
		array[pos0] = array[pos1];
		array[pos1] = temp;
	}

	public void checkSorted() {
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
class Button extends Component {
	
	float posX, posY;
	float w, h;
	float offsetXY;
	boolean depressed;
	boolean active;
	boolean offset;
	int shade;

	public Button(float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		shade = p.foreground;
		depressed = false;
		active = false;
		offset = false;
		offsetXY = 2*px;
	}

		public void render() {
		if (correctLocation()) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		if(offset) {
			rect(posX - offsetXY, posY + offsetXY, w, h);
		} else {
			rect(posX, posY, w, h);
		}
	}

	public void update() {
		if(correctLocation() && depressed) {
			shade = p.select;
			offset = true;
		} else if (correctLocation()) {
			shade = p.hover;
		}
		else {
			shade = p.foreground;
			offset = false;
		}
	}

	public void mouseDown() {
		if(correctLocation()) {
			depressed = true;
		}
	}

	public void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			if(active) {
				active = false;
			} else {
				active = true;
			}
		}
		shade = p.foreground;
		depressed = false;
		offset = false;
	}

	public boolean correctLocation() {
		if(mouseX > posX && mouseX < posX + w
			&& mouseY > posY && mouseY < posY + h) {
			return true;
		} else {
			return false;
		}
	}

}
static class CalcSpeed {

	static int modulus;
	static int numSteps;

	public static int getNumSteps(int x) {
		if(x <= 60) {
			numSteps = 1;
		} else {
			numSteps = x / 60;
		}
		return numSteps;
	}

	public static int getModulus(int x) {
		if(x <= 60) {
			modulus = 60 / x;
		} else {
			modulus = 1;
		}
		return modulus;
	}
//
}
class Component{

	// float posX, posY;
	// float w, h;
	// boolean depressed;
	// boolean active;

	// public Component(float posX, float posY, float w, float h) {
	// 	this.posX = posX;
	// 	this.posY = posY;
	// 	this.w = w;
	// 	this.h = h;
	// 	depressed = false;
	// 	active = false;
	// }

	// void render() {
	// 	fill(255);
	// 	if(offset) {
	// 		rect(posX - offsetXY, posY + offsetXY, w, h);
	// 	} else {
	// 		rect(posX, posY, w, h);
	// 	}
	// }


	// void update() {
	// 	if(correctLocation() && depressed) {
	// 		offset = true;
	// 	} else {
	// 		offset = false;
	// 	}
	// }

}
static class GenerateArray {

	public static int[] sinWave(int length, float p){
        int[] arr = new int[length];
        for(int i = 0; i < length; i++){
            arr[i] = (int)(Math.round((length/2)*sin((2*PI*p*i)/length)+((length/2)*sin(PI/2)))) + 1;
        }
        return arr;
    }

	public static int[] random(int length) {
		int[] arr = asc(length);
		for(int i = 0; i < arr.length; i++) {
			int rand = (int)(Math.random() * length);
			int temp = arr[i];
			arr[i] = arr[rand];
			arr[rand] = temp;
		}
		return arr;
	}

	public static int[] asc(int length) {
		int[] arr = new int[length];
		for(int i = 0; i < arr.length; i++) {
			arr[i] = i + 1;
		}
		return arr;
	}

	public static int[] blanks(int length) {
		int[] arr = new int[length];
		for(int i = 0; i < arr.length; i++) {
			arr[i] = 0;
		}
		return arr;
	}

}
class Menu {

	float posX, posY, w, h;
	SubMenu algMenu;

	public Menu() {
		this.w = 435*px;
		this.posX = width - w; //View X + View w - this w
		this.posY = 0; // View Y 
		this.h = height; //View h - Taskbar h
		algMenu = new SubMenu(this.posX, 100*py, 435*px, 114*py);
	}

	public void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h);
		algMenu.render();
	}

	public void update() {
		algMenu.update();
	}

	public void mouseUp() {
		algMenu.mouseUp();
	}

	public void mouseDown() {
		algMenu.mouseDown();
	}

}
class MergeBtn extends Thumbnail {

	MergeSort m;

	public MergeBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		m = new MergeSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		m.steps(10300);
		arr = m.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Merge";
	}

	// void mouseUp() {
	// 	if (correctLocation() && depressed) {
	// 		// super.mouseUp(this);
	// 	}
	// }



}
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

	public void reset(int[] array, int[] colours) {
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

	public void steps(int x) {
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

	public void stepThrough() {
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
			if (!startMerge && !endMerge) {
				// println("compare");
				compare();
			}
		}
	}

	public void compare() {
		// println("\nBefore\tcounterL = " + counterL + "\tsizeL = " + sizeL + "\tl = " + l + "\tm = " + m + 
		// 		"\n\t    counterR = " + counterR + "\tsizeR = " + sizeR + "\tr = " + r);
		
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
		// println("After\tcounterL = " + counterL + "\tsizeL = " + sizeL + "\tl = " + l + "\tm = " + m + 
		// 		"\n\t    counterR = " + counterR + "\tsizeR = " + sizeR + "\tr = " + r);
	}

	public void merge() {
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

	public void fillQueue(int l, int r) {
		int mid;

		if (l < r) {
			mid = l + (r - l) / 2;
			fillQueue(l, mid);
			fillQueue(mid + 1, r);
			int[] positions = {l, mid, r};
			lrQueue.add(positions);
		}
	}

	public void printQueue() {
		for (int i = 0; i < lrQueue.size(); i++) {
			int[] positions = lrQueue.remove();
			println("Step " + (i+1) + ":\tl: " + positions[0] +
				"\tm: " + positions[1] + 
				"\th: " + positions[2]);
		}
	}

	public void checkSorted() {
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
public class MyClass {


}
class MySound {

	float attackTime;
	float sustainTime;
	float sustainLevel;
	float releaseTime;
	float minFreq;
	float maxFreq;

	public MySound(float att, float susT, float susL, float rel, float minFreq, float maxFreq) {
		this.attackTime = att;
		this.sustainTime = susT;
		this.sustainLevel = susL;
		this.releaseTime = rel;
		this.minFreq = minFreq;
		this.maxFreq = maxFreq;
	}

	public void update() {
		soundAttSlider.update();
		soundSusTSlider.update();
		soundSusLSlider.update();
		soundRelSlider.update();
	}

	public void play() {
		int min = array.length+1;
		int max = 0;
		int med = 0;

		setAtt(soundAttSlider.getValFloat());
		setSusL(soundSusTSlider.getValFloat());
		setSusT(soundSusLSlider.getValFloat());
		setRel(soundRelSlider.getValFloat());

		for(int i = 0; i < colours.length; i++) {
			if (colours[i] > 0) {
				if(array[i] > max) {
					max = array[i];
				}
				if (array[i] < min) {
					min = array[i];
				}
			}
		}
		med = (max - min) / 2;
		triOsc.freq(map(med, 0, array.length, minFreq, maxFreq));
		env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
	}

	public void setAtt(float att) {
		this.attackTime = att;
	}

	public void setSusT(float susT) {
		this.sustainTime = susT;
	}

	public void setSusL(float susL) {
		this.sustainLevel = susL;
	}

	public void setRel(float rel) {
		this.releaseTime = rel;
	}

}
class Palette {

	int background;
	int foreground;
	int hover;
	int select;
	int accent;
	int font;

	int[] darkMode;


	public Palette() {
		// int[] b = {#03045e,#023e8a,#0077b6,#0096c7,#00b4d8,#48cae4,#90e0ef,#ade8f4,#caf0f8};
		// int[] g = {#ffffff,#f5f7fa,#e6e9ed,#ccd1d9,#aab2bd,#88909b,#656d78,#434a54,#000000};
		int[] darkMode = {0xff282828, 0xff535353, 0xff454545, 0xff383838, 0xff646464, 0xffdddddd};
		this.darkMode = darkMode;
		this.background = darkMode[0];
		this.foreground = darkMode[1];
		this.hover = darkMode[2];
		this.select = darkMode[3];
		this.accent = darkMode[4];
		this.font = darkMode[5];
	}
}

class Play extends Button{

	public Play(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
	}

}

class Reset extends Button{

	public Reset(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
	}

	public void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			arraySize = sizeSlider.getVal();
			array = GenerateArray.random(arraySize);
			colours = GenerateArray.blanks(arraySize);
			bubble.reset(array, colours);
			selection.reset(array, colours);
			mergeSort.reset(array, colours);
			play.active = false;
			println(arraySize);
		}
		depressed = false;
		offset = false;
	}

}
class SelectionBtn extends Thumbnail {

	SelectionSort s;

	public SelectionBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		s = new SelectionSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		s.steps(180000);
		arr = s.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Selection";
	}

	// void mouseUp() {
	// 	if (correctLocation() && depressed) {
	// 		super.mouseUp(this);
	// 	}
	// }

}
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

	public void reset(int[] array, int[] colours) {
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

	public void steps(int x) {
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

	public void stepThrough() {
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

	// void compare2() {
	// 	if (!swapping) {
	// 		colours[posMin] = 1;
	// 		colours[pos1] = 1;
	// 		colours[pos0] = 2;
	// 		if (array[pos1] < array[posMin]) {
	// 			posMin = pos1;
	// 		}
	// 		if (pos1 == array.length - 1) {
	// 			swapping = true;
	// 		}
	// 		pos1++;
	// 	} else {
	// 		swap();
	// 	}
	// }

	public void compare() {
		colours[posMin] = 1;
		colours[pos1] = 1;
		if (pos0 > 0) {
			colours[pos0 - 1] = 2;
		}
		if (array[pos1] < array[posMin]) {
			posMin = pos1;
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

	public void swap() {
		int temp = array[pos0];
		array[pos0] = array[posMin];
		array[posMin] = temp;
	}

	public void checkSorted() {
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
class Slider extends Component{

	float posX, posY;
	float thumbX, thumbRadius;
	float w, h;
	float centreX, centreY;
	int strokeS, strokeM, strokeL;
	float minVal, maxVal;
	boolean depressed, active;

	public Slider(float posX, float posY, float w, float h, float minVal, float maxVal, float initVal) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		thumbRadius = h;
		depressed = false;
		active = false;
		centreX = posX + (w/2);
		centreY = posY + (h/2);
		this.minVal = minVal;
		this.maxVal = maxVal;
		this.thumbX = map(initVal, minVal, maxVal, posX, posX + w);
		strokeS = (int)(h/10);
		strokeM = (int)(h/5);
		strokeL = (int)(h/3.33f);
	}

	public Slider(float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		thumbRadius = h;
		depressed = false;
		active = false;
		centreX = posX + (w/2);
		centreY = posY + (h/2);
		this.thumbX = centreX;
		strokeS = (int)(h/10);
		strokeM = (int)(h/5);
		strokeL = (int)(h/3.33f);
	}

	public void update() {
		if(depressed) {
			if(inRangeX()) {
				thumbX = mouseX;
			}
			else if (mouseX < posX) {
				thumbX = posX;
			}
			else if (mouseX > posX + w) {
				thumbX = posX + w;
			}
		}
	}

	public void render() {
		//Draw track base
		strokeWeight(strokeM);
		stroke(100);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(255);
		line(posX, centreY, thumbX, centreY);
		stroke(0);
		strokeWeight(0);
		//Draw highlight for hover and depressed
		if(depressed) {
			fill(255, 130);
			circle(thumbX, centreY, thumbRadius * 2.5f);
		} else if(distance(mouseX, mouseY, thumbX, centreY) < (h/2)) {
			fill(255, 40);
			circle(thumbX, centreY, thumbRadius * 2.5f);
		}
		//Draw Thumb
		fill(255);
		circle(thumbX, centreY, thumbRadius);
	}

	public void mouseDown() {
		if(insideBoundsXY()) {
			depressed = true;
		}
	}

	public void mouseUp() {
		if(depressed) {
			depressed = false;
		}
	}

	public boolean insideBoundsXY() {
		if(mouseX >= posX - (h/2) && mouseX <= posX + w + (h/2) 
			&& mouseY >= posY && mouseY <= posY + h) {
			return true;
		} else {
			return false;
		}
	}

	public float distance(float x1, float y1, float x2, float y2) {
		return (float)Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
	}

	public boolean inRangeX() {
		if(mouseX >= posX && mouseX <= posX + w) {
			return true;
		} else {
			return false;
		}
	}

	public int getVal() {
		return(int)(map(thumbX, posX, posX + w, minVal, maxVal));
	}

	public float getValFloat() {
		return(map(thumbX, posX, posX + w, minVal, maxVal));
	}

}
class Thumbnail {

	float posX, posY, w, h;
	// float px;
	int[] arr;
	int[] crr;
	Barchart b;
	int arrSize;
	String label;
	float fontSize;
	boolean depressed;
	boolean active;
	boolean offset;
	float offsetXY;
	boolean highlight;
	int shade;

	public Thumbnail (float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		this.fontSize = 16*px;
		this.arrSize = 680;
		shade = p.foreground;
		depressed = false;
		active = false;
		offset = false;
		offsetXY = 0*px;
		highlight = false;
		offsetXY = 2*px;
		// px = d/100;
		arrSize = (int)(68*10);
		b = new Barchart(posX + 16*px, posY + 14*px, 68*px, 46*py, 0);
	}

	public void render() {
		// strokeWeight(1*px);
		// stroke(0);
		if (highlight) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		rect(posX - offsetXY, posY + offsetXY, 100*px, 100*py, 8*px);
		b.renderSimple(arr, this);
		// Overlay
		noFill();
		strokeWeight(4*px);
		stroke(shade);
		rect(posX - offsetXY + 15*px, posY + offsetXY + 13*py, 70*px, 48*py, 8*px);
		// Border
		noFill();
		strokeWeight(2*px);
		stroke(p.accent);
		rect(posX - offsetXY + 16*px, posY + offsetXY + 14*py, 68*px, 46*py, 8*px); 
		fill(p.font);
		textSize(round(fontSize));
		textAlign(CENTER);
		text(label, posX - offsetXY + 50*px, posY + offsetXY + 86*py);
	}

	public void updatePos() {
		b.posX = this.posX + 16*px;
		b.posY = this.posY + 14*py;
		b.w = 68*px;
		b.h = 46*py;
		fontSize = 16*px;
	}

	public void update() {
		updatePos();
		if (!active) {
			if (correctLocation()) {
				if (depressed) {
					shade = p.select;
					highlight = true;
					offset = true;
					offsetXY = 1*px;
				} else {
					shade = p.hover;
					highlight = false;
					offset = false;
					offsetXY = -1*px;
				}
			} else {
				shade = p.foreground;
				highlight = false;
				offset = false;
				offsetXY = 0*px;
			}
		} else {
			shade = p.select;
			highlight = true;
			offset = true;
			offsetXY = 0*px;
		}
	}

	public void mouseDown() {
		if (correctLocation()) {
			depressed = true;
		}
	}

	public void mouseUp() {
		if (correctLocation() && depressed) {
			//do some thing
			active = true;
		} else {
			depressed = false;
			offset = false;
			offsetXY = 0*px;
		}
	}

	public boolean correctLocation() {
		if (mouseX > this.posX && mouseX < this.posX + this.w
			&& mouseY > this.posY && mouseY < this.posY + this.h) {
			return true;
		} else {
			return false;
		}
	}

}
class TickSlider extends Slider {

	int tick;
	int numTicks;

	public TickSlider(float posX, float posY, float w, float h, int tick, int numTicks) {
		super(posX, posY, w, h);
		this.thumbX = map(stepsPerSecond, minSteps, maxSteps, posX, posX + w);
		this.tick = tick;
		this.numTicks = numTicks;
	}

	public int getTickLocation() {
		tick = (int)round(map(mouseX, posX, posX + w, 0, numTicks));
		return (int)map(tick, 0, numTicks, posX, posX + w);
	}

	public void update() {
		if(depressed) {
			if(inRangeX()) {
				thumbX = getTickLocation();
			}
			else if (mouseX < posX) {
				thumbX = posX;
				tick = 0;
			}
			else if (mouseX > posX + w) {
				thumbX = posX + w;
				tick = numTicks;
			}
		}
		setVal();
	}

	public void render() {
		//Draw track base
		strokeWeight(strokeM);
		stroke(100);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(255);
		line(posX, centreY, thumbX, centreY);
		//Draw ticks
		strokeWeight(strokeS);
		stroke(180);
		for(int i = 1; i < numTicks; i++) {
			point(map(i, 0, numTicks, posX, posX + w), centreY);
		}
		stroke(0);
		strokeWeight(0);
		//Draw highlight depressed
		if(depressed) {
			fill(255, 130);
			circle(thumbX, centreY, thumbRadius * 2.5f);
		//Draw highlight for hover
		} else if(distance(mouseX, mouseY, thumbX, centreY) < (h/2)) {
			fill(255, 40);
			circle(thumbX, centreY, thumbRadius * 2.5f);
		}
		//Draw Thumb
		fill(255);
		circle(thumbX, centreY, thumbRadius);
	}

	public int getVal() {
		int[] x = {1, 2, 4, 10, 15, 30, 60, 120, 240, 480, 960, 1920, 3840, 7680, 15360};
		if(tick < 4) {
			return x[tick];
		} else {
			return (int)Math.pow(2, tick - 3) * 15;
		}
		//return x[tick];
		// return (int)Math.pow(2, tick);
	}

	public void setVal() {
		int[] x = {1, 2, 4, 10, 15, 30, 60, 120, 240, 480, 960, 1920, 3840, 7680, 15360};
		if(tick < 4) {
			speed = x[tick];
		} else {
			speed = (int)Math.pow(2, tick - 3) * 15;
		}
	}

}
class View {

	int arraySize;
	Slider sizeSlider;
	int[] array;
	int[] colours;
	float posX, posY, w, h;
	Barchart b;
	// AlgMenu algMenu;
	// GphMenu gphMenu;

	public View(float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = width;
		this.h = height;
		b = new Barchart(this.posX, this.posY, this.w, this.h, 10*px);
	}

	public void render() {

	}

	public void update() {
		
	}
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
