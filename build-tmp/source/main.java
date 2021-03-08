import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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
float attackTime = 0.001f;
float sustainTime = 0.004f;
float sustainLevel = 0.3f;
float releaseTime = 0.2f;

public void settings() {
	// size(1000, 600, OPENGL);
	// size(1000, 600, P2D);
	// fullScreen(P2D, SPAN);
	fullScreen(P2D, 2);
	// fullScreen(1);
	noSmooth();
}

public void setup()
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
	speedSlider = new TickSlider(110, 30, 150, 20, 0, 12);
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

public void draw() {
	update();
	count++;

	background(0);
	if(count % CalcSpeed.getModulus(speedSlider.getVal()) == 0) {
		if(!bubble.sorted && play.active) {
			bubble.steps(CalcSpeed.getNumSteps(speedSlider.getVal()));
			int[] a = bubble.getArray();
			float fq = map(a[bubble.oldPos1], 1, arrayMax, 200, 600);
			triOsc.freq(fq);
			env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
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

public void update() {
	play.update();
	speedSlider.update();
	reset.update();
	sizeSlider.update();
}

public void mousePressed() {
	play.mouseDown();
	speedSlider.mouseDown();
	reset.mouseDown();
	sizeSlider.mouseDown();
}

public void mouseReleased() {
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
public void randomTester() {
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

public void bubble(int[] array) {
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


class Algorithm {

}

class ArrayGenerator {

	public int[] random2(int length) {
		int[] tempArray = asc(length);
		int[] randArray = new int[length];
		for(int i = 0; i < randArray.length; i++) {
			int rand = (int)(Math.random() * length);
			randArray[i] = tempArray[rand];
			for(int j = rand; j < length - 1; j++) {
				tempArray[j] = tempArray[j+1];
			}
			length--;
		}
		return randArray;
	}

	public int[] random(int length) {
		int[] randArray = asc(length);
		for(int i = 0; i < randArray.length; i++) {
			int rand = (int)(Math.random() * length);
			int temp = randArray[i];
			randArray[i] = randArray[rand];
			randArray[rand] = temp;
		}
		return randArray;
	}

	public int[] asc(int length) {
		int[] array = new int[length];
		for(int i = 0; i < array.length; i++) {
			array[i] = i + 1;
		}
		return array;
	}

	public int[] blanks(int length) {
		int[] array = new int[length];
		for(int i = 0; i < array.length; i++) {
			array[i] = 0;
		}
		return array;
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

	public Barchart(float posX, float posY, float w, float h) {
		border = 20;
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
		strokeWeight = (w-(a.length-1))/a.length;
		strokeWeight(strokeWeight);
		strokeCap(SQUARE);
		stroke(255);
		array = a;
		colours = c;
		max = getMax();
		for (int i = 0; i < a.length; i++) {
			if(c[i] == 0) {
				stroke(255);
			}
			else if (c[i] == 1) {
				stroke(255, 0, 0);
			}
			else {
				stroke(0, 255, 0);
			}
			float x1 = map(i, 0, a.length, 0, w) + border + strokeWeight/2;
			float y1 = map(a[i], 0, max, h+border, border);
			float barHeight = map(a[i], 0, max, 0, h);
			line(x1, y1, x1, y1 + barHeight);
		}
		strokeCap(ROUND);
	}

	public float getMax() {
		float max = 0;
		for (int i = 0; i < array.length; i++) {
			if(array[i] > max) {
				max = array[i];
			}
		}
		return max;
	}

	//------------------------------------------------------------------------------------------------
	public void render2(int[] a, int[] c) {
		strokeWeight(1);
		stroke(0);
		array = a;
		colours = c;
		max = getMax();
		barWidth = w/array.length;
		for (int i = 0; i < array.length; i++) {
			if(c[i] == 0) {
				fill(255);
			}
			else if (c[i] == 1) {
				fill(255, 0, 0);
			}
			else {
				fill(0, 255, 0);
			}
			float x1 = map(i, 0, array.length, 0, w) + border;
			float y1 = map(array[i], 0, max, h+border, border);
			float barHeight = map(array[i], 0, max, 0, h);
			rect(x1, y1, barWidth, barHeight);
		}
	}
}



class BubbleSort extends Algorithm {

	boolean sorted;
	boolean swapping;
	int counter;
	int pos1, pos0;
	int oldPos1, oldPos0;
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
		oldPos1 = 0;
		oldPos0 = 0;
	}

	public void steps(int x) {
		for(int i = 0; i < x; i++) {
			if(!sorted) {
				stepThrough();
			} else {
				break;
			}
		}
	}

	public void stepThrough() {
		colours[oldPos1] = 0;
		colours[oldPos0] = 0;
		//If not at the end of the loop
		if(pos1 < stop) {
			compare();
		}
		else if (!checkSorted()) {
			// colours[pos0] = 0;
			pos1 = 1;
			pos0 = 0;
			compare();
		}
		else {
			this.sorted = true;
		}
	}

	public void compare() {
		//If a swap is needed
		if(array[pos1] < array[pos0]) {
			//If second time: swap and colour green
			if(swapping) {
				swap();
				swapping = false;
			}
			else {
				//First time: don't increment, colour red
				if(pos1 < array.length) {
					colours[pos1] = 1;
				}
				// colours[pos1] = 1;
				colours[pos0] = 1;
				oldPos1 = pos1;
				oldPos0 = pos0;
				swapping = true;
			}
		}
		else {
			//don't swap, increment, colour red
			if(pos1 < array.length) {
				colours[pos1] = 1;
			}
			colours[pos0] = 1;
			oldPos1 = pos1;
			oldPos0 = pos0;
			pos1++;
			pos0++;
		}
	}

	public void swap() {
		int temp = array[pos0];
		array[pos0] = array[pos1];
		array[pos1] = temp;
		colours[pos1] = 2;
		colours[pos0] = 2;
		pos1++;
		pos0++;
	}

	public boolean checkSorted() {
		boolean sorted = true;
		for(int i = 1; i < array.length; i++) {
			if(array[i] < array[i - 1]) {
				sorted = false;
				break;
			}
		}
		return sorted;
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

	public Button(float posX, float posY, float w, float h) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		depressed = false;
		active = false;
		offset = false;
		offsetXY = 4;
	}

		public void render() {
		noStroke();
		fill(255);
		if(offset) {
			rect(posX - offsetXY, posY + offsetXY, w, h);
		} else {
			rect(posX, posY, w, h);
		}
	}

	public void update() {
		if(correctLocation() && depressed) {
			offset = true;
		} else {
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
		if(x < 60) {
			numSteps = 1;
		} else {
			numSteps = x;
		}
		return numSteps;
	}

	public static int getModulus(int x) {
		if(x < 60) {
			modulus = 60 / x;
		} else {
			modulus = 1;
		}
		return modulus;
	}

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
			array = gen.random(arraySize);
			colours = gen.blanks(arraySize);
			bubble.reset(array, colours);
			play.active = false;

		}
		depressed = false;
		offset = false;
	}

}
class SizeSlider extends Slider {

	public SizeSlider(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		this.thumbX = map(arraySize, arrayMin, arrayMax, posX, posX + w);
	}

	public int getVal() {
		return(int)(map(thumbX, posX, posX + w, arrayMin, arrayMax));
	}
}
class Slider extends Component{

	float posX, posY;
	float thumbX, thumbRadius;
	float w, h;
	float centreX, centreY;
	int strokeS, strokeM, strokeL;
	boolean depressed, active;

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
		return(int)(map(thumbX, posX, posX + w, minSteps, maxSteps));
	}

}
class TickSlider extends Slider {

	// float posX, posY;
	// float thumbX, thumbRadius;
	// float w, h;
	// float centreX, centreY;
	// int strokeS, strokeM, strokeL;
	// boolean depressed, active;
	// float thumbX;
	int tick;
	int numTicks;

	public TickSlider(float posX, float posY, float w, float h, int tick, int numTicks) {
		super(posX, posY, w, h);
		this.thumbX = map(stepsPerSecond, minSteps, maxSteps, posX, posX + w);
		this.tick = tick;
		this.numTicks = numTicks;
	}

	public int getTickLocation() {
		tick = (int)map(mouseX, posX, posX + w, 0, 12);
		return (int)map(tick, 0, 12, posX, posX + w);
	}

	public void update() {
		if(depressed) {
			if(inRangeX()) {
				thumbX = getTickLocation();
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
		return (int)Math.pow(2, tick);
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
