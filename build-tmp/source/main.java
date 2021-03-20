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
float attackTime = 0.001f;
float sustainTime = 0.004f;
float sustainLevel = 0.3f;
float releaseTime = 0.2f;

Menu menu;

public void settings() {
	// size(1000, 600, OPENGL);
	// size(1536, 846, P2D);
	// size(800, 500, P2D);
	// fullScreen(P2D, SPAN);
	fullScreen(P2D, 2);
	// size(800, 500, P2D);
	// fullScreen(1);
	noSmooth();
}

public void setup()
{
	px = (width*5.2083333f*pow(10, -4));
	py = (height*9.2592592f*pow(10, -4));
	p = new Palette();
	fontSize = 16*py;
	pf = createFont("OpenSans-Regular.ttf", fontSize);
	menuLerp = 0.5f;
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

public void draw() {
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

public void update() {
	// px = (width*5.2083333*pow(10, -4));
	// py = (height*9.2592592*pow(10, -4));
	play.update();
	reset.update();
	volume.update();
	menu.update();
	settingsBtn.update();
}

public void mousePressed() {
	play.mouseDown();
	reset.mouseDown();
	volume.mouseDown();
	menu.mouseDown();
	settingsBtn.mouseDown();
}

public void mouseReleased() {
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
class AudioBtn extends Button{

	float centreY;
	float centreX;
	float strokeW;

	public AudioBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreX = posX + (w/2);
		centreY = posY + (h/2);
		strokeW = w/20;
		active = true;
	}

	public void render() {
		if (correctLocation()) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		circle(centreX - offsetXY, centreY + offsetXY, w);
		noStroke();
		fill(p.font);
		rect(posX - offsetXY + (w/6.25f), posY + offsetXY + (h/2.77f), (w/3), (h/3.57f), 5*px);
		triangle(posX - offsetXY + (w/1.85f), posY + offsetXY + (h/5), 
			posX - offsetXY + (w/1.85f), posY + offsetXY + h - (h/5), 
			posX - offsetXY + (h/5.55f), centreY + offsetXY);

		noFill();
		strokeWeight(strokeW);
		stroke(p.font);
		if (active) {
			arc(centreX - offsetXY, centreY + offsetXY, (w/2.63f) - strokeW, (h/2.63f) - strokeW, radians(-45), radians(45));
			arc(centreX - offsetXY, centreY + offsetXY, (w/1.72f) - strokeW, (h/1.72f) - strokeW, radians(-45), radians(45));
		} else {
			line(posX - offsetXY + (w/1.54f), posY + offsetXY + (h/2.44f), posX - offsetXY + (w/1.2f), posY + offsetXY + (h/1.69f));
			line(posX - offsetXY + (w/1.54f), posY + offsetXY + (h/1.69f), posX - offsetXY + (w/1.2f), posY + offsetXY + (h/2.44f));
		}
	}

	public void update() {
		if(correctLocation() && depressed) {
			shade = p.select;
			offsetXY = offset;
		} else if (correctLocation()) {
			shade = p.hover;
			offsetXY = -(offset);
		}
		else {
			shade = p.foreground;
			offsetXY = 0;
		}
		if(active) {
			s.volume(0.4f);
		} else {
			s.volume(0.0f);
		}

	}

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
	float fontSize;
	PFont f;

	public Barchart(float posX, float posY, float w, float h, float border) {
		this.border = border;
		this.posX = posX;
		this.posY = posY;
		this.w = w - (border*2);
		this.h = h - (border*2);
		this.fontSize = 90*px/7.5f;
		this.f = createFont("OpenSans-Regular.ttf", fontSize);
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
		float x1 = 0;
		float y1 = 0;
		float barHeight = 0;

		noStroke();
		fill(p.foreground);
		rect(posX, posY,border*2 + w, border*2 + h);
		if (a.length > w / 3) {
			strokeWeight = w / a.length;
			spacer = strokeWeight / 2;
		} else {
			strokeWeight = (w-(a.length))/a.length;
			spacer = strokeWeight / 2;
		}
		fill(p.barB);
		noStroke();
		rect(posX + border, posY + border, w, h);
		strokeWeight(strokeWeight);
		strokeCap(SQUARE);
		// strokeCap(ROUND);
		array = a;
		colours = c;
		max = a.length;
		for (int i = 0; i < a.length; i++) {
			if(c[i] == 0) {
				stroke(p.barF);
			}
			else if (c[i] == 1) {
				stroke(0xffaecbfa);
			}
			else {
				stroke(0xffccff90);
			}
			x1 = map(i, 0, a.length, posX, posX + w) + border + spacer;
			if (menu.mirrorSwitch.active) {
				y1 = map(a[i], -a.length, max, posY + h + border, posY + border);
			} else {
				y1 = map(a[i], 0, max, posY + h + border, posY + border);
			}
			barHeight = map(a[i], 0, max, 0, h);
			line(x1, y1, x1, y1 + barHeight);
		}

		//Draw numbers
		if (a.length <= 100) {
			fill(p.background);
			fontSize = (w/a.length/2);
			f = createFont("OpenSans-Regular.ttf", fontSize);
			textFont(f);
			// textSize(fontSize);
			for (int i = 0; i < a.length; i++) {
				x1 = map(i, 0, a.length, posX, posX + w) + border + spacer;
				if (menu.mirrorSwitch.active) {
					textAlign(CENTER, CENTER);
					y1 = posY + (h/2) + border - 2*py;
				} else {
					textAlign(CENTER, TOP);
					y1 = map(a[i], 0, max, posY + h + border, posY + border) - 2*py;
				}
				
				text(a[i], x1, y1);
			}
		}
			
		// Draw border
		noFill();
		strokeWeight(1*px);
		stroke(p.accent);
		rect(posX + border, posY + border, w, h);
		strokeCap(ROUND);
	}

	// Used for rendering small thumbnail barcharts
	public void renderSimple(int[] a, Thumbnail t) {
		float x1 = 0;
		float y1 = 0;
		float barHeight = 0;


		strokeWeight = w / a.length;
		fill(p.barB);
		noStroke();
		rect(posX - t.offsetXY, posY + t.offsetXY, w, h);
		strokeWeight(strokeWeight);
		strokeCap(SQUARE);
		max = a.length - 1;
		stroke(p.barF);
		for (int i = 0; i < a.length; i++) {
			x1 = map(i, 0, a.length, posX - t.offsetXY, posX - t.offsetXY + w);
			if (menu.mirrorSwitch.active) {
				y1 = map(a[i], -a.length, max, posY + h + border, posY + border);
			} else {
				y1 = map(a[i], 0, max, posY + t.offsetXY + h, posY + t.offsetXY);
			}
			barHeight = map(a[i], 0, max, 0, h);
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
		b.steps(1750, arr, crr);
		arr = b.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Bubble";
	}

	public void mouseUp() {
		if (correctLocation() && depressed) {
			//do some thing
			if(!active) {
				mergeSort.reset(array, colours);
				active = true;
			}
		} else {
			depressed = false;
			offsetXY = 0*px;
		}
	}

}

class BubbleSort extends Algorithm {

	boolean sorted;
	boolean swapping;
	int counter;
	int pos1, pos0;
	int stop;
	int[] array;
	int[] colours;

	public BubbleSort(int[] array, int[] colours) {
		sorted = false;
		swapping = false;
		pos1 = 1;
		pos0 = 0;
		this.array = array;
		this.colours = colours;
		counter = array.length;
		stop = array.length;
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
	}

	public void steps(int x, int[] arr, int[] colours) {
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
		comparisons++;
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
		assignments++;
		int temp = array[pos0];
		array[pos0] = array[pos1];
		array[pos1] = temp;
		colours[pos1] = 2;
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
	float offset;
	boolean depressed;
	boolean active;
	// boolean offset;
	int shade;

	public Button(float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		shade = p.foreground;
		depressed = false;
		active = false;
		offset = w/100;
		offsetXY = offset;
	}

	public void render() {
		if (correctLocation()) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		rect(posX - offsetXY, posY + offsetXY, w, h);
	}

	public void update() {
		if(correctLocation() && depressed) {
			shade = p.select;
			offsetXY = offset;
		} else if (correctLocation()) {
			shade = p.hover;
			offsetXY = -(offset);
		}
		else {
			shade = p.foreground;
			offsetXY = 0;
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
		offsetXY = 0;
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

        length-=1;
        for(int i = 0; i <= length; i++){
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

	public static int[] desc(int length) {
		int[] arr = new int[length];

		for(int i = 0; i < arr.length; i++) {
			arr[i] = arr.length - i;
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

	public static int[] quadrant(int length){
        int[] arr = new int[length];

        length-=1;
        for(int i = 0; i < arr.length; i++){
            arr[i] = (int)(Math.round(length*Math.sqrt(1-Math.pow(((double)i/(double)length),2))))+1;
        }
        return arr;
    }

    public static int[] parabola(int length){
        int[] arr = new int[length];

        length-=1;
        for(int i = 0; i < arr.length; i++){
            arr[i] = (int)Math.round((4/(double)length)*(Math.pow((i-((double)length/2)),2)))+1;
        }
        return arr;
    }

    public static int[] parabolaInv(int length){
        int[] arr = new int[length];

        length-=1;
        for(int i = 0; i < arr.length; i++){
            arr[i] = (int)Math.round((-4/(double)length)*(Math.pow((i-((double)length/2)),2)))+length+1;
        }
        return arr;
    }

    public static int[] squiggle(int length){
    	int period = 0;
        int[] arr = new int[length];

        length-=1;
        for(int i = 0; i < arr.length; i++){
            arr[i] = (int)Math.round(length*(Math.pow((Math.sin(Math.PI+(Math.pow(2,((4*period)/length))))),2)))+1;
            period += Math.PI;
        }
        return arr;
    }

}
class Menu {

	float posX, posY, w, h;
	int arrSizeDisplay;
	float wTarget;
	float spacer;
	float margin;
	float fontSize;
	float titleSize;
	PFont f;
	PFont t;

	SubMenu algMenu;
	ShapeMenu shapeMenu;

	Slider sizeSlider;
	Slider speedSlider;
	Slider soundAttSlider;
	Slider soundSusTSlider;
	Slider soundSusLSlider;
	Slider soundRelSlider;

	Button mirrorSwitch;

	boolean toggleMenu;
	boolean closed;

	public Menu() {
		this.w = 435*px;
		this.posX = width; //View X + View w - this w
		this.posY = 0; // View Y 
		this.h = height; //View h - Taskbar h
		this.fontSize = 16*py;
		this.titleSize = 20*py;
		this.f = createFont("OpenSans-Regular.ttf", fontSize);
		this.t = createFont("OpenSans-Regular.ttf", titleSize);
		this.spacer = 18*px;
		this.margin = 14*py;
		this.toggleMenu = true;
		this.closed = false;
		wTarget = width;
		
		algMenu = new SubMenu(
			this.posX, 
			this.posY + (spacer * 3) + (titleSize / 2) + margin, 
			w, 
			114*py); // Algorithms
		
		shapeMenu = new ShapeMenu(
			this.posX, 
			algMenu.posY + algMenu.h + (spacer * 3) + (titleSize / 2) + margin, 
			w, 
			221*py); // Shapes

		sizeSlider = new Slider(
			this.posX + 225*px, 
			shapeMenu.posY + shapeMenu.h + (spacer * 2), 
			180*px, 20*py, 
			arrayMin, arrayMax, arraySize); // Size
		this.arrSizeDisplay = sizeSlider.getVal();
		
		speedSlider = new TickSlider(
			this.posX + 225*px, 
			sizeSlider.posY + sizeSlider.h + (spacer * 2), 
			180*px, 20*py, 3, 14); // Speed
		
		soundAttSlider = new Slider(
			this.posX + 225*px, 
			speedSlider.posY + speedSlider.h + (spacer * 3) + (titleSize / 2) + margin, 
			180*px, 
			20*py, 
			0.001f, 1.0f, 0.001f); // Sound

		soundSusTSlider = new Slider(
			this.posX + 225*px, 
			soundAttSlider.posY + soundAttSlider.h + spacer, 
			180*px, 
			20*py, 
			0.001f, 1.0f, 0.004f); // Sound

		soundSusLSlider = new Slider(
			this.posX + 225*px, 
			soundSusTSlider.posY + soundSusTSlider.h + spacer, 
			180*px, 
			20*py, 
			0.001f, 1.0f, 0.3f); // Sound

		soundRelSlider = new Slider(
			this.posX + 225*px, 
			soundSusLSlider.posY + soundSusLSlider.h + spacer, 
			180*px, 
			20*py, 
			0.001f, 1.0f, 0.2f); // Sound

		mirrorSwitch = new ToggleSwitch(
			this.posX + this.w - spacer - 17*px, 
			algMenu.posY + algMenu.h + (spacer * 2.5f), 
			17*px, 
			20*py);

		// mirrorSwitch = new ToggleSwitch(
		// 	100, 100, 
		// 	40*px, 
		// 	20*py);
	}

	public void update() {
		this.posX = lerp(this.posX, wTarget, menuLerp);
		b.w = lerp(b.w - (b.border * 2), wTarget, menuLerp);
		algMenu.update(); // Done
		shapeMenu.update(); // Done
		sizeSlider.update(); // Done
		soundAttSlider.update(); // Done
		soundSusTSlider.update(); // Done
		soundSusLSlider.update(); // Done
		soundRelSlider.update(); // Done
		speedSlider.update(); // Done
		mirrorSwitch.update();
		arrSizeDisplay = sizeSlider.getVal();
	}

	public void render() {
		strokeWeight(1*px);
		stroke(p.foreground);
		fill(p.foreground);
		rect(posX, posY, w, h);

		strokeWeight(1*py);
		stroke(p.accent);
		// line(this.posX + margin, // Above Sorting Algorithms
		// 	this.posY + spacer, 
		// 	this.posX + this.w - margin, 
		// 	this.posY + spacer);
		line(this.posX + margin, // Below Sorting Algorithms
			algMenu.posY + algMenu.h + spacer, 
			this.posX + this.w - margin, 
			algMenu.posY + algMenu.h + spacer);
		line(this.posX + margin, // Below Shapes
			shapeMenu.posY + shapeMenu.h + spacer, 
			this.posX + this.w - margin, 
			shapeMenu.posY + shapeMenu.h + spacer);
		line(this.posX + margin, // Below Size & Speed
			sizeSlider.posY + sizeSlider.h + spacer, 
			this.posX + this.w - margin, 
			sizeSlider.posY + sizeSlider.h + spacer);
		line(this.posX + margin, // Below Sound
			speedSlider.posY + speedSlider.h + spacer, 
			this.posX + this.w - margin, 
			speedSlider.posY + speedSlider.h + spacer);

		algMenu.render();
		shapeMenu.render();
		sizeSlider.render();
		speedSlider.render();
		soundAttSlider.render();
		soundSusTSlider.render();
		soundSusLSlider.render();
		soundRelSlider.render();
		mirrorSwitch.render();

		//Text
		fill(p.font); // Array Size
		textAlign(LEFT, CENTER);
		textFont(t);
		textSize(titleSize);
		text("Sorting Algorithms", this.posX + spacer, posY + (spacer * 2) + (titleSize / 2));
		text("Array Shapes", this.posX + spacer, algMenu.posY + algMenu.h + (spacer * 2) + (titleSize / 2));
		text("Sound Settings", this.posX + spacer, speedSlider.posY + speedSlider.h + (spacer * 2) + (titleSize / 2));


		textFont(f);
		textSize(fontSize);
		textAlign(LEFT, TOP);
		text("Mirror", this.posX + spacer + (w/1.5f), algMenu.posY + algMenu.h + (spacer * 2) + (fontSize / 3));
		textAlign(LEFT, CENTER);
		text("Array Size", this.posX + 30*px, shapeMenu.posY + shapeMenu.h + (spacer * 2) + (fontSize / 2));
		textAlign(RIGHT, CENTER);
		text(arrSizeDisplay, this.posX + 180*px, shapeMenu.posY + shapeMenu.h + (spacer * 2) + (fontSize / 2));
		textAlign(LEFT, CENTER);
		text("Speed", this.posX + 30*px, sizeSlider.posY + sizeSlider.h + (spacer * 2) + (fontSize / 2));

		// Sound Controls
		text("Attack", this.posX + 30*px, speedSlider.posY + speedSlider.h + (spacer * 3) + (titleSize / 2) + (fontSize / 2) + margin);
		text("Sustain Time", this.posX + 30*px, soundAttSlider.posY + soundAttSlider.h + spacer + (fontSize / 2));
		text("Sustain Level", this.posX + 30*px, soundSusTSlider.posY + soundSusTSlider.h + spacer + (fontSize / 2));
		text("Release", this.posX + 30*px, soundSusLSlider.posY + soundSusLSlider.h + spacer + (fontSize / 2));

	}

	public void mouseUp() {
		algMenu.mouseUp();
		shapeMenu.mouseUp();
		sizeSlider.mouseUp();
		soundAttSlider.mouseUp();
		soundSusTSlider.mouseUp();
		soundSusLSlider.mouseUp();
		soundRelSlider.mouseUp();
		speedSlider.mouseUp();
		mirrorSwitch.mouseUp();
	}

	public void mouseDown() {
		algMenu.mouseDown();
		shapeMenu.mouseDown();
		sizeSlider.mouseDown();
		soundAttSlider.mouseDown();
		soundSusTSlider.mouseDown();
		soundSusLSlider.mouseDown();
		soundRelSlider.mouseDown();
		speedSlider.mouseDown();
		mirrorSwitch.mouseDown();
	}

	public void keyPressed() {
	  // If the return key is pressed, save the String and clear it
	  if (key == '\n' ) {
	    println("success");
	  }
	}

}
class MergeBtn extends Thumbnail {

	MergeSort m;

	public MergeBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		m = new MergeSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		m.steps(590, arr, crr);
		arr = m.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Merge";
	}

	public void mouseUp() {
		if (correctLocation() && depressed) {
			//do some thing
			if(!active) {
				mergeSort.reset(array, colours);
				active = true;
			}
		} else {
			depressed = false;
			offsetXY = 0*px;
		}
	}

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
	}

	public void steps(int x, int[] arr, int[] colours) {
		this.array = arr;
		this.colours = colours;

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

		// Colours
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

		// Comparison
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

	public void merge() {
		assignments++;
		colours[counterA] = 2;
		array[counterA] = mergeQueue.remove();
		counterA++;
		// println("\nLine 130\ncounterA = " + counterA + "\tmergeQueue removed = " + array[counterA]);
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
class MyClass {
	// Example 18-1: User input

	PFont f;

	// Variable to store text currently being typed
	String typing = "";

	// Variable to store saved text when return is hit
	String saved = "";

	public void setup() {
	  size(480, 270);
	  f = createFont("Arial",16);
	}

	public void draw() {
	  background(255);
	  int indent = 0;
	  
	  // Set the font and fill for text
	  textFont(f);
	  fill(0);
	  
	  // Display everything
	  text("Click in this window and type. \nHit enter to save. ", indent, 40);
	  text("Input: " + typing,indent,190);
	  text("Saved text: " + saved,indent,230);
	}

	public void keyPressed() {
	  // If the return key is pressed, save the String and clear it
	  if (key == '\n' ) {
	    saved = typing;
	    // A String can be cleared by setting it equal to ""
	    typing = ""; 
	  } else {
	    // Otherwise, concatenate the String
	    // Each character typed by the user is added to the end of the String variable.
	    typing = typing + key; 
	  }
	}
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
		// menu.soundAttSlider.update();
		// menu.soundSusTSlider.update();
		// menu.soundSusLSlider.update();
		// menu.soundRelSlider.update();
	}

	public void play() {
		int min = array.length+1;
		int max = 0;
		int med = 0;

		setAtt(menu.soundAttSlider.getValFloat());
		setSusL(menu.soundSusTSlider.getValFloat());
		setSusT(menu.soundSusLSlider.getValFloat());
		setRel(menu.soundRelSlider.getValFloat());

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
		med = ((max - min) / 2) + min;
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

	int[] darkMode;
	int[] lightMode;

	int background;
	int foreground;
	int hover;
	int select;
	int accent;
	int font;
	int barF;
	int barB;

	public Palette() {
		// int[] lightMode = {#eeeeee,#dddddd,#cccccc,#bbbbbb,#aaaaaa,#2d3142}; // white
		// int[] lightMode = {#6D769C,#dddddd,#cccccc,#bbbbbb,#A3A3A3,#525252}; // white2
		int[] lightMode = {0xffffffff,0xffffffff,0xfff1f3f4,0xfffeefc3,0xfff8f9fa,0xffaecbfa, 0xff091540}; // white 3
		
		// int[] lightMode = {#2d3142,#aaaaaa,#bbbbbb,#cccccc,#dddddd,#eeeeee};
		this.lightMode = lightMode;
		int[] darkMode = {0xff282828, 0xff535353, 0xff454545, 0xff383838, 0xff646464, 0xffdddddd}; // dark
		this.darkMode = darkMode;
		// int[] darkMode = {#cc444b,#da5552,#df7373,#e39695,#e4b1ab,#3b1f2b}; // red
		this.barF = 0xffdddddd;
		this.barB = 0xff858585;
		this.darkMode = darkMode;

		dark();
		// light();
	}

	public void dark() {
		this.background = darkMode[0];
		this.foreground = darkMode[1];
		this.hover = darkMode[2];
		this.select = darkMode[3];
		this.accent = darkMode[4];
		this.font = darkMode[5];
		this.barF = darkMode[5];
		this.barB = darkMode[0];
	}

	public void light() {
		this.background = lightMode[0];
		this.foreground = lightMode[1];
		this.hover = lightMode[2];
		this.select = lightMode[3];
		this.accent = lightMode[4];
		this.font = lightMode[6];
		this.barF = lightMode[0];
		this.barB = lightMode[5];
	}


}

class Play extends Button{

	float centreY;
	float centreX;

	public Play(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreX = posX + (w/2);
		centreY = posY + (h/2);
	}

	public void render() {
		if (correctLocation()) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		circle(centreX - offsetXY, centreY + offsetXY, w);
		fill(p.font);
		if(active) {
			rect(posX - offsetXY + (w/3.33f), posY + offsetXY + (h/3.85f), (w/5.55f), (h/2), 2.5f);
			rect(posX - offsetXY + w - (w/3.33f) - (w/5.55f), posY + offsetXY + (h/3.85f), (w/5.55f), (h/2), 2.5f);


			// rect(posX - offsetXY + (w/2.94), posY + offsetXY + (h/3.23), (h/7.69), (h/2.56), 2.5*px);
			// rect(posX - offsetXY + w - (w/2.94) - (w/7.69), posY + offsetXY + (h/3.23), (h/7.69), (h/2.56), 2.5*px);
		} else {
			stroke(p.font);
			strokeWeight(5);
			strokeJoin(ROUND);
			triangle(posX - offsetXY + (w/2.94f), posY + offsetXY + (h/4.16f), 
			posX - offsetXY + (w/2.94f), posY + offsetXY + h - (h/4.16f), 
			posX - offsetXY + w - (w/4.5f), centreY + offsetXY);
		}
		
	}
	
}

class Reset extends Button{

	float centreX;
	float centreY;
	float strokeW;

	public Reset(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreX = posX + w/2;
		centreY = posY + h/2;
		strokeW = w/7.7f;
	}

	public void render() {
		if (correctLocation()) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		circle(centreX - offsetXY, centreY + offsetXY, w);
		strokeWeight(strokeW);
		stroke(p.font);
		noFill();
		strokeCap(SQUARE);
		arc(centreX - offsetXY, centreY + offsetXY, 
			w - strokeW - (w/2.94f), h - strokeW - (h/2.94f), 
			radians(0), radians(270));
		noStroke();
		fill(p.font);
		triangle(centreX - offsetXY, posY + (h/12.5f) + offsetXY, 
			centreX - offsetXY, posY + (h/2.7f) + offsetXY, 
			centreX + (w/4.76f) - offsetXY, posY + (h/4.35f) + offsetXY);
	}

	public void mouseUp() {
		if(correctLocation() && depressed) {
			// Reset
			reset();
		}
		depressed = false;
		offsetXY = 0*px;
	}

	public void reset() {
		arraySize = menu.sizeSlider.getVal();

		for (int i = 0; i < menu.shapeMenu.btnThumbs.size(); i++) {
			ShapeBtn s = menu.shapeMenu.btnThumbs.get(i);
			if (s.active) {
				if (s.name.matches("random")) {
					array = GenerateArray.random(arraySize);
				} else if (s.name.matches("sinWave")) {
					array = GenerateArray.sinWave(arraySize, 1.5f);
				} else if (s.name.matches("quadrant")) {
					array = GenerateArray.quadrant(arraySize);
				} else if (s.name.matches("heartbeat")) {
					array = GenerateArray.sinWave(arraySize, 7.5f);
				} else if (s.name.matches("squiggle")) {
					array = GenerateArray.squiggle(arraySize);
				} else if (s.name.matches("parabola")) {
					array = GenerateArray.parabola(arraySize);
				} else if (s.name.matches("parabolaInv")) {
					array = GenerateArray.parabolaInv(arraySize);
				} else if (s.name.matches("descending")) {
					array = GenerateArray.desc(arraySize);
				}
			}
		}

		colours = GenerateArray.blanks(arraySize);
		bubble.reset(array, colours);
		selection.reset(array, colours);
		mergeSort.reset(array, colours);
		play.active = false;
		comparisons = 0;
		assignments = 0;
	}

}
class SelectionBtn extends Thumbnail {

	SelectionSort s;

	public SelectionBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		s = new SelectionSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		s.steps(2000, arr, crr);
		arr = s.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Selection";
	}

	public void mouseUp() {
		if (correctLocation() && depressed) {
			//do some thing
			if(!active) {
				mergeSort.reset(array, colours);
				active = true;
			}
		} else {
			depressed = false;
			offsetXY = 0*px;
		}
	}

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

	public void steps(int x, int[] arr, int[] colours) {
		this.array = arr;
		this.colours = colours;
		
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
		comparisons++;
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
		assignments++;
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
class SettingsBtn extends Button{

	float r;
	float rtarget;
	float centreX;
	float centreY;
	float strokeW;
	float marginY;
	float marginX;

	public SettingsBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreX = w/2;
		centreY = h/2;
		strokeW = w/10;
		marginY = h/5.26f;
		marginX = w/5.88f;
		r = radians(0);
		rtarget = radians(0);
	}

	public void mouseUp() {
		if(correctLocation() && depressed) {
			menu.toggleMenu = true;
			if (rtarget == radians(-90)) {
				rtarget = radians(0);
				menu.wTarget = width;
			} else {
				rtarget = radians(-90);
				menu.wTarget = width - 436*px;
			}
		}
		depressed = false;
		offsetXY = 0*px;
	}

	public void update() {
		if(correctLocation() && depressed) {
			shade = p.select;
			offsetXY = 2*px;
		} else if (correctLocation()) {
			shade = p.hover;
			offsetXY = -2*px;
		}
		else {
			shade = p.foreground;
			offsetXY = 0*px;
		}
		r = lerp(r, rtarget, 0.3f);
	}

	public void render() {
		translate(posX + centreX, posY + centreY);
		rotate(r);

		noStroke();
		fill(p.foreground);
		// rect(-centreX, -centreY, w, h);
		circle(0, 0, w);
		strokeWeight(strokeW);
		stroke(p.font);
		strokeCap(ROUND);
		line(-centreX + marginX + (strokeW/2), -centreY + centreY, w - marginX - centreX - (strokeW/2), -centreY + centreY);
		line(-centreX + marginX + (strokeW/2), -centreY + centreY + marginY, w - marginX - centreX - (strokeW/2), -centreY + centreY + marginY);
		line(-centreX + marginX + (strokeW/2), -centreY + centreY - marginY, w - marginX - centreX - (strokeW/2), -centreY + centreY - marginY);
	}

}
class ShapeBtn extends Thumbnail {

	String name;

	public ShapeBtn(float posX, float posY, float w, float h, String name) {
		super(posX, posY, w, h);
		crr = GenerateArray.blanks(arrSize);
		if (name.matches("random")) {
			arr = GenerateArray.random(arrSize);
			this.label = "Random";
			this.name = "random";
		} else if (name.matches("sinWave")) {
			arr = GenerateArray.sinWave(arrSize, 1.5f);
			this.label = "Sin Wave";
			this.name = "sinWave";
		} else if (name.matches("quadrant")) {
			arr = GenerateArray.quadrant(arrSize);
			this.label = "Exponent";
			this.name = "quadrant";
		} else if (name.matches("heartbeat")) {
			arr = GenerateArray.sinWave(arrSize, 7.5f);
			this.label = "Heartbeat";
			this.name = "heartbeat";
		} else if (name.matches("squiggle")) {
			arr = GenerateArray.squiggle(arrSize);
			this.label = "Spectrum";
			this.name = "squiggle";
		} else if (name.matches("parabola")) {
			arr = GenerateArray.parabola(arrSize);
			this.label = "Parabola";
			this.name = "parabola";
		} else if (name.matches("parabolaInv")) {
			arr = GenerateArray.parabolaInv(arrSize);
			this.label = "Parabola";
			this.name = "parabolaInv";
		} else if (name.matches("descending")) {
			arr = GenerateArray.desc(arrSize);
			this.label = "Descending";
			this.name = "descending";
		}
	}

	public void render() {
		if (highlight) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		rect(posX - offsetXY, posY + offsetXY, w, h, 8*px);
		b.renderSimple(arr, this);
		// Overlay
		noFill();
		strokeWeight(6*px);
		stroke(shade);
		rect(posX - offsetXY + 13*px, posY + offsetXY + 11*py, 74*px, 52*py, 10*px);
		// Border
		// noFill();
		// strokeWeight(2*px);
		// stroke(p.accent);
		// rect(posX - offsetXY + 16*px, posY + offsetXY + 14*py, 68*px, 46*py, 8*px); 
		//Label
		fill(p.font);
		textFont(f);
		textSize(fontSize);
		textAlign(CENTER);
		text(label, posX - offsetXY + 50*px, posY + offsetXY + 86*py);
	}

}
class ShapeMenu{

	ArrayList<ShapeBtn> btnThumbs;
	float posX, posY, w, h;
	boolean buttonClicked;
	ShapeBtn random;
	ShapeBtn sinWaveBtn;
	ShapeBtn quadrantBtn;
	ShapeBtn heartbeatBtn;
	ShapeBtn squiggle;
	ShapeBtn parabola;
	ShapeBtn parabolaInv;
	ShapeBtn descending;

	public ShapeMenu (float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		this.random = new ShapeBtn(posX + 7*px, posY + 7*py, 100*px, 100*py, "random");
		this.random.active = true;
		this.sinWaveBtn = new ShapeBtn(posX + 114*px, posY + 7*py, 100*px, 100*py, "sinWave");
		this.quadrantBtn = new ShapeBtn(posX + 221*px, posY + 7*py, 100*px, 100*py, "quadrant");
		this.heartbeatBtn = new ShapeBtn(posX + 328*px, posY + 7*py, 100*px, 100*py, "heartbeat");
		this.squiggle = new ShapeBtn(posX + 7*px, posY + 114*py, 100*px, 100*py, "squiggle");
		this.parabola = new ShapeBtn(posX + 114*px, posY + 114*py, 100*px, 100*py, "parabola");
		this.parabolaInv = new ShapeBtn(posX + 221*px, posY + 114*py, 100*px, 100*py, "parabolaInv");
		this.descending = new ShapeBtn(posX + 328*px, posY + 114*py, 100*px, 100*py, "descending");
		btnThumbs = new ArrayList<ShapeBtn>();
		btnThumbs.add(random);
		btnThumbs.add(sinWaveBtn);
		btnThumbs.add(quadrantBtn);
		btnThumbs.add(heartbeatBtn);
		btnThumbs.add(squiggle);
		btnThumbs.add(parabola);
		btnThumbs.add(parabolaInv);
		btnThumbs.add(descending);
		buttonClicked  = false;
	}

	// void updatePos(boolean closed, float sw) {
	// 	if(closed) {
	// 		// Subtract w
	// 		this.posX -= sw;
	// 	} else {
	// 		// Add w
	// 		this.posX += sw;
	// 	}
	// 	random.updatePos(closed, sw);
	// 	sinWaveBtn.updatePos(closed, sw);
	// 	quadrantBtn.updatePos(closed, sw);
	// 	heartbeatBtn.updatePos(closed, sw);
	// 	squiggle.updatePos(closed, sw);
	// 	parabola.updatePos(closed, sw);
	// 	parabolaInv.updatePos(closed, sw);
	// 	descending.updatePos(closed, sw);
	// }

	public void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h);
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			t.render();
		}
	}

	public void update() {
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			t.update();
		}

		this.posX = lerp(this.posX, menu.wTarget, menuLerp);

		random.posX = lerp(random.posX, menu.wTarget + 7*px, menuLerp);
		sinWaveBtn.posX = lerp(sinWaveBtn.posX, menu.wTarget + 114*px, menuLerp);
		quadrantBtn.posX = lerp(quadrantBtn.posX, menu.wTarget + 221*px, menuLerp);
		heartbeatBtn.posX = lerp(heartbeatBtn.posX, menu.wTarget + 328*px, menuLerp);

		squiggle.posX = lerp(squiggle.posX, menu.wTarget + 7*px, menuLerp);
		parabola.posX = lerp(parabola.posX, menu.wTarget + 114*px, menuLerp);
		parabolaInv.posX = lerp(parabolaInv.posX, menu.wTarget + 221*px, menuLerp);
		descending.posX = lerp(descending.posX, menu.wTarget + 328*px, menuLerp);

		random.b.posX = lerp(random.b.posX, menu.wTarget + 23*px, menuLerp);
		sinWaveBtn.b.posX = lerp(sinWaveBtn.b.posX, menu.wTarget + 130*px, menuLerp);
		quadrantBtn.b.posX = lerp(quadrantBtn.b.posX, menu.wTarget + 237*px, menuLerp);
		heartbeatBtn.b.posX = lerp(heartbeatBtn.b.posX, menu.wTarget + 344*px, menuLerp);

		squiggle.b.posX = lerp(squiggle.b.posX, menu.wTarget + 23*px, menuLerp);
		parabola.b.posX = lerp(parabola.b.posX, menu.wTarget + 130*px, menuLerp);
		parabolaInv.b.posX = lerp(parabolaInv.b.posX, menu.wTarget + 237*px, menuLerp);
		descending.b.posX = lerp(descending.b.posX, menu.wTarget + 344*px, menuLerp);

	}

	public void mouseUp() {
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			if (t.correctLocation() && t.depressed) {
				buttonClicked = true;
				break;
			} else {
				buttonClicked = false;
			}
		}
		if (buttonClicked) {
			for (int i = 0; i < btnThumbs.size(); i++) {
				ShapeBtn t = btnThumbs.get(i);
				t.active = false;
				t.mouseUp();
			}
			if (!play.active) {
				reset.reset();
			}
		}

	}

	public void mouseDown() {
		for (int i = 0; i < btnThumbs.size(); i++) {
			ShapeBtn t = btnThumbs.get(i);
			t.mouseDown();
		}
	}

}
class Slider extends Component{

	float posX, posY;
	float thumbX, thumbRadius;
	float w, h;
	float centreX, centreY;
	float strokeS, strokeM, strokeL;
	float minVal, maxVal, currentVal;
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
		strokeS = h/10;
		strokeM = h/5;
		strokeL = h/3.33f;
		currentVal = getValFloat();
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
		strokeS = h/10;
		strokeM = h/5;
		strokeL = h/3.33f;
		currentVal = getValFloat();
	}

	public void update() {
		this.posX = lerp(this.posX, menu.wTarget + 225*px, menuLerp);
		this.thumbX = map(currentVal, minVal, maxVal, posX, posX + w);
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

	// void updatePos(boolean closed, float sw) {
	// 	if(closed) {
	// 		// Subtract w
	// 		this.posX = this.posX - sw;
	// 		centreX = this.posX + (this.w/2) - sw;
	// 		this.thumbX = map(getValFloat(), minVal, maxVal, this.posX, this.posX + this.w) - sw;
	// 	} else {
	// 		// Add w
	// 		this.posX = this.posX + sw;
	// 		centreX = this.posX + (this.w/2) + sw;
	// 		this.thumbX = map(getValFloat(), minVal, maxVal, this.posX, this.posX + this.w) + sw;
	// 	}
	// }

	public void render() {
		//Draw track base
		strokeWeight(strokeM);
		stroke(p.accent);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(p.font);
		line(posX, centreY, thumbX, centreY);
		noStroke();
		//Draw highlight for hover and depressed
		if(depressed) {
			fill(p.font, 130);
			circle(thumbX, centreY, thumbRadius * 2.5f);
		} else if(distance(mouseX, mouseY, thumbX, centreY) < (h/2)) {
			fill(p.font, 40);
			circle(thumbX, centreY, thumbRadius * 2.5f);
		}
		//Draw Thumb
		fill(p.font);
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
			currentVal = getValFloat();
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
		this.randomBtn = new BubbleBtn(posX + 7*px, posY + 7*py, 100*px, 100*py);
		this.randomBtn.active = true;
		this.bubbleBtn = new BubbleBtn(posX + 114*px, posY + 7*py, 100*px, 100*py);
		this.selectionBtn = new SelectionBtn(posX + 221*px, posY + 7*py, 100*px, 100*py);
		this.mergeBtn = new MergeBtn(posX + 328*px, posY + 7*py, 100*px, 100*py);
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
		rect(posX, posY, w, h);
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.render();
		}
	}

	public void update() {
		for (int i = 0; i < algThumbs.size(); i++) {
			Thumbnail t = algThumbs.get(i);
			t.update();
		}
		this.posX = lerp(this.posX, menu.wTarget, menuLerp);
		
		randomBtn.posX = lerp(randomBtn.posX, menu.wTarget + 7*px, menuLerp);
		bubbleBtn.posX = lerp(bubbleBtn.posX, menu.wTarget + 114*px, menuLerp);
		selectionBtn.posX = lerp(selectionBtn.posX, menu.wTarget + 221*px, menuLerp);
		mergeBtn.posX = lerp(mergeBtn.posX, menu.wTarget + 328*px, menuLerp);

		randomBtn.b.posX = lerp(randomBtn.b.posX, menu.wTarget + 23*px, menuLerp);
		bubbleBtn.b.posX = lerp(bubbleBtn.b.posX, menu.wTarget + 130*px, menuLerp);
		selectionBtn.b.posX = lerp(selectionBtn.b.posX, menu.wTarget + 237*px, menuLerp);
		mergeBtn.b.posX = lerp(mergeBtn.b.posX, menu.wTarget + 344*px, menuLerp);
	}

	// void updatePos(boolean closed, float sw) {
	// 	if(closed) {
	// 		// Subtract w
	// 		this.posX -= sw;
	// 	} else {
	// 		// Add w
	// 		this.posX += sw;
	// 	}
	// 	mergeBtn.updatePos(closed, sw);
	// 	bubbleBtn.updatePos(closed, sw);
	// 	selectionBtn.updatePos(closed, sw);
	// 	randomBtn.updatePos(closed, sw);
	// }

	// void updatePos() {
	// 	this.posX = mouseX;
	// 	this.posY = mouseY;
	// 	this.w = 435*px;
	// 	this.h = 114*py;
	// 	mergeBtn.posX = mouseX + 7*px;
	// 	bubbleBtn.posX = mouseX + 114*px;
	// 	selectionBtn.posX = mouseX + 221*px;
	// 	randomBtn.posX = mouseX + 328*px;
	// 	mergeBtn.posY = mouseY + 7*py;
	// 	bubbleBtn.posY = mouseY + 7*py;
	// 	selectionBtn.posY = mouseY + 7*py;
	// 	randomBtn.posY = mouseY + 7*py;
	// 	mergeBtn.updatePos();
	// 	bubbleBtn.updatePos();
	// 	selectionBtn.updatePos();
	// 	randomBtn.updatePos();
	// }


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
	float offsetXY;
	boolean highlight;
	int shade;
	PFont f;

	public Thumbnail (float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		this.fontSize = 16*px;
		this.f = createFont("OpenSans-Regular.ttf", fontSize);
		this.arrSize = 68;
		shade = p.foreground;
		depressed = false;
		active = false;
		offsetXY = 0*px;
		highlight = false;
		offsetXY = 2*px;
		// arrSize = (int)(68*10);
		arr = GenerateArray.random(arrSize);
		crr = GenerateArray.blanks(arrSize);
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
		strokeWeight(6*px);
		stroke(shade);
		rect(posX - offsetXY + 13*px, posY + offsetXY + 11*py, 74*px, 52*py, 10*px);
		// Border
		// noFill();
		// strokeWeight(1*px);
		// stroke(p.accent);
		// rect(posX - offsetXY + 16*px, posY + offsetXY + 14*py, 68*px, 46*py, 8*px); 
		fill(p.font);
		textFont(f);
		textSize(fontSize);
		textAlign(CENTER);
		text(label, posX - offsetXY + 50*px, posY + offsetXY + 86*py);
	}

	// void updatePos() {
	// 	b.posX = this.posX + 16*px;
	// 	b.posY = this.posY + 14*py;
	// 	b.w = 68*px;
	// 	b.h = 46*py;
	// 	fontSize = 16*px;
	// }

	// void updatePos(boolean closed, float sw) {
	// 	if(closed) {
	// 		// Subtract w
	// 		this.posX -= sw;
	// 		b.posX -= sw;
	// 	} else {
	// 		// Add w
	// 		this.posX += sw;
	// 		b.posX += sw;
	// 	}
	// }

	public void update() {
		// b.posX = this.posX + 16*px;
		if (!active) {
			if (correctLocation()) {
				if (depressed) {
					shade = p.select;
					highlight = true;
					offsetXY = 1*px;
				} else {
					shade = p.hover;
					highlight = false;
					offsetXY = -1*px;
				}
			} else {
				shade = p.foreground;
				highlight = false;
				offsetXY = 0*px;
			}
		} else {
			shade = p.select;
			highlight = true;
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
			if(!active) {
				active = true;
			}
		} else {
			depressed = false;
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
	int current;

	public TickSlider(float posX, float posY, float w, float h, int tick, int numTicks) {
		super(posX, posY, w, h);
		this.thumbX = map(stepsPerSecond, minSteps, maxSteps, posX, posX + w);
		this.tick = tick;
		this.numTicks = numTicks;
		current = getVal();
	}

	public int getTickLocation() {
		tick = (int)round(map(mouseX, posX, posX + w, 0, numTicks));
		return (int)map(tick, 0, numTicks, posX, posX + w);
	}

	public void update() {
		this.posX = lerp(this.posX, menu.wTarget + 225*px, menuLerp);
		this.thumbX = map(tick, 0, numTicks, posX, posX + w);
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

	public void updatePos(boolean closed, float sw) {
		if(closed) {
			// Subtract w
			this.posX = this.posX - sw;
			centreX = this.posX + (this.w/2) - sw;
			this.thumbX -= sw;
		} else {
			// Add w
			this.posX = this.posX + sw;
			centreX = this.posX + (this.w/2) + sw;
			this.thumbX += sw;
		}
	}

	public void render() {
		float tickmark;

		//Draw track base
		strokeWeight(strokeM);
		stroke(p.accent);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(p.font);
		line(posX, centreY, thumbX, centreY);

		//Draw ticks
		strokeWeight(strokeS);
		for(int i = 1; i < numTicks; i++) {
			tickmark = map(i, 0, numTicks, posX, posX + w);
			if(tickmark <= thumbX) {
				stroke(p.accent);
			} else {
				stroke(p.font);
			}
			point(map(i, 0, numTicks, posX, posX + w), centreY);
		}

		noStroke();
		//Draw highlight depressed
		if(depressed) {
			fill(p.font, 130);
			circle(thumbX, centreY, thumbRadius * 2.5f);
		//Draw highlight for hover
		} else if(distance(mouseX, mouseY, thumbX, centreY) < (h/2)) {
			fill(p.font, 40);
			circle(thumbX, centreY, thumbRadius * 2.5f);
		}
		//Draw Thumb
		fill(p.font);
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
class ToggleSwitch extends Button {

	float strokeS, strokeM, strokeL, centreY, thumbX;
	
	public ToggleSwitch(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		centreY = posY + (h/2);
		strokeS = h/10;
		strokeM = h/5;
		strokeL = h/1.4286f;
		thumbX = posX;
	}

	public void render() {
		//Draw track base
		strokeWeight(strokeL);
		stroke(p.accent);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		strokeWeight(strokeL);
		stroke(p.font);
		line(posX, centreY, thumbX, centreY);
		noStroke();
		//Draw highlight for hover and depressed
		if(depressed) {
			fill(shade, 130);
			circle(thumbX, centreY, h * 2.5f);
		} else if(correctLocation()) {
			fill(p.font, 40);
			circle(thumbX, centreY, h * 2.5f);
		}
		//Draw Thumb
		if(active) {
			fill(p.font);	
		} else {
			fill(p.hover);
		}
		circle(thumbX, centreY, h);
	}

	public void update() {
		this.posX = lerp(this.posX, menu.wTarget + menu.w - (menu.spacer*2) - w, menuLerp);
		if(active) {
			thumbX = posX + w;
		} else {
			thumbX = posX;
		}
		if(correctLocation() && depressed) {
			shade = p.select;
		} else if (correctLocation()) {
			shade = p.hover;
		}
		else {
			shade = p.foreground;
		}
	}

	public float distance(float x1, float y1, float x2, float y2) {
		return (float)Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
	}

	public void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			if(active) {
				active = false;
				thumbX = posX;
			} else {
				active = true;
				thumbX = posX + w;
			}
		}
		shade = p.foreground;
		depressed = false;
		offsetXY = 0*px;
	}

	public boolean correctLocation() {
		if(mouseX > posX - (h/2) && mouseX < posX + w + (h/2)
			&& mouseY > posY && mouseY < posY + h) {
			return true;
		} else {
			return false;
		}
	}

}
class View {

	float posX, posY, w, h;

	// Array
	int arraySize;
	int arrayMax;
	int arrayMin;
	int[] array;
	int[] colours;
	Barchart b;

	//Speed
	int speed = 1;
	int stepsPerSecond = 1;
	int maxSteps = 3840;
	int minSteps = 1;

	//Algorithms
	BubbleSort bubble;
	SelectionSort selection;
	MergeSort mergeSort;

	Menu menu;

	public View(float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = width;
		this.h = height;

		//Array
		arrayMax = width;
		arrayMin = 10; //Min array size
		arraySize = 20;
		array = GenerateArray.random(arraySize); //Generate
		colours = GenerateArray.blanks(arraySize);

		//Algorithms
		bubble = new BubbleSort(array, colours);
		selection = new SelectionSort(array, colours);
		mergeSort = new MergeSort(array, colours);

		menu = new Menu();
		b = new Barchart(this.posX, this.posY, this.w, this.h, 10*px);
	}

	public void render() {

		
		b.render(array, colours);

		menu.render();
	}

	public void update() {
		iterateAlgorithm();
		menu.update();
	}

	public void mousePressed() {
		menu.mouseDown();
	}

	public void mouseReleased() {
		menu.mouseUp();
	}

	public void iterateAlgorithm() {
		// Algorithm iterator
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
