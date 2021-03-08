import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

ArrayList<Button> buttons = new ArrayList<Button>();


Barchart b;
ArrayGenerator gen;
BubbleSort bubble;
Algorithm algo;
Play play;
Slider slider;
SpeedControl speedCtrl;
int count = 0;
int arraySize = 600;
int stepsPerSecond = 1000;
int maxSteps = 5000;
int minSteps = 1;

public void settings() {
	// size(2500, 600, OPENGL);
	size(1980, 600, P2D);
	// fullScreen(P2D, SPAN);
	// fullScreen(P2D, 2);
	// noSmooth();
}

public void setup()
{
	surface.setResizable(true);
	background(0);
	stroke(0);
	// noStroke();
	fill(255);
	gen = new ArrayGenerator();
	b = new Barchart();
	int[] array = gen.random(arraySize);
	int[] colours = gen.blanks(arraySize);
	bubble = new BubbleSort(array, colours);
	play = new Play(10, 10, 100, 50);

	//Initiating Slider
	float thumbX = map(stepsPerSecond, minSteps, maxSteps, 200, 350);
	slider = new Slider(200, 30, 150, 20, thumbX);

	buttons.add(play);
	play.render();
	speedCtrl = new SpeedControl();
}

public void draw() {
	update();
	count++;

	background(0);
	if(count % speedCtrl.getModulus(stepsPerSecond) == 0) {
		if(!bubble.sorted && play.active) {
			bubble.steps(speedCtrl.getNumSteps(stepsPerSecond));
		}
	}
	int[] a = bubble.getArray();
	int[] c = bubble.getColours();
	b.render(a, c);
	play.render();
	slider.render();
}

public void update() {
	if(mousePressed) {
		for (int i = 0; i < buttons.size(); i++) {
			Button b = buttons.get(i);
			if(b instanceof Play) {
				((Play)b).update();
			}
		}
	}
	slider.update();
}

public void mousePressed() {
	for (int i = 0; i < buttons.size(); i++) {
		Button b = buttons.get(i);
		if(b instanceof Play) {
			((Play)b).mouseDown();
		}
	}
	slider.mouseDown();
}

public void mouseReleased() {
	for (int i = 0; i < buttons.size(); i++) {
		Button b = buttons.get(i);
		if(b instanceof Play) {
			((Play)b).mouseUp();
		}
	}
	slider.mouseUp();
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
	Barchart b2 = new Barchart();
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
	float border;
	float viewWidth, viewHeight;
	float w;
	float max;

	public Barchart() {
		border = 20;
		viewWidth = width - (border*2);
		viewHeight = height - (border*2);
	}

	// void update(float wid, float hei) {
	// 	border = mouseX;
	// 	viewWidth = wid - (border*2);
	// 	viewHeight = hei - (border*2);
	// 	w = viewWidth/array.length;
	// }

	public void render(int[] a, int[] c) {
		strokeWeight(1);
		stroke(0);
		array = a;
		colours = c;
		max = getMax();
		w = viewWidth/array.length;
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
			float x1 = map(i, 0, array.length, 0, viewWidth) + border;
			float y1 = map(array[i], 0, max, viewHeight+border, border);
			float h = map(array[i], 0, max, 0, viewHeight);
			rect(x1, y1, w, h);
		}
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
}



class BubbleSort extends Algorithm {

	boolean sorted;
	boolean swapping;
	int counter;
	int pos1;
	int pos0;
	int oldPos1;
	int oldPos0;
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
		if(pos1 < array.length) {
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
		if(array[pos1] < array[pos0]) {
			//Second time: swap and colour green
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
class Slider extends Component{

	float posX, posY;
	float thumbX, thumbRadius;
	float w, h;
	float centreX, centreY;
	boolean depressed, active;

	public Slider(float posX, float posY, float w, float h, float thumbX) {
		this.posX = posX;
		this.posY = posY;
		this.w = w;
		this.h = h;
		this.thumbX = thumbX;
		thumbRadius = h;
		depressed = false;
		active = false;
		centreX = posX + (w/2);
		centreY = posY + (h/2);
	}


	public void update() {
		if(depressed) {
			if(inRange()) {
				thumbX = mouseX;
			}
		}
	}

	public void render() {
		//Draw track base
		strokeWeight(4);
		stroke(150);
		line(posX, centreY, posX + w, centreY);
		//Draw track highlight
		stroke(200);
		line(posX, centreY, thumbX, centreY);
		//Draw Thumb
		stroke(0);
		strokeWeight(0);
		fill(200);
		circle(thumbX, centreY, thumbRadius);
	}

	public void mouseDown() {
		if(correctLocation()) {
			depressed = true;
		}
	}

	public void mouseUp() {
		if(depressed) {
			depressed = false;
		}
	}

	public boolean correctLocation() {
		if(distance(thumbX, centreY, mouseX, mouseY) <= thumbRadius) {
			return true;
		} else {
			return false;
		}
	}

	public float distance(float x1, float y1, float x2, float y2) {
		return (float)Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
	}

	public boolean inRange() {
		if(mouseX > posX && mouseX < posX + w) {
			return true;
		} else {
			return false;
		}
	}

	public int getSpeed() {
		return(SpeedControl.getNumSteps2(20));
	}

}
class SpeedControl {

	int modulus;
	int numSteps;

	// public SpeedControl() {
		
	// }

	// public SpeedControl(int x) {
	// 	modulus = getModulus(x);
	// 	numSteps = getNumSteps(x);
	// }

	public int getModulus(int x) {
		if(x < 60) {
			modulus = 60 / x;
		} else {
			modulus = 1;
		}
		return modulus;
	}

	public int getNumSteps(int x) {
		if(x < 60) {
			numSteps = 1;
		} else {
			numSteps = x;
		}
		return numSteps;
	}

	public static int getNumSteps2(int x) {
		if(x < 60) {
			numSteps = 1;
		} else {
			numSteps = x;
		}
		return numSteps;
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
