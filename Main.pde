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

void settings() {
	// size(2500, 600, OPENGL);
	size(1980, 600, P2D);
	// fullScreen(P2D, SPAN);
	// fullScreen(P2D, 2);
	// noSmooth();
}

void setup()
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

void draw() {
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

void update() {
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

void mousePressed() {
	for (int i = 0; i < buttons.size(); i++) {
		Button b = buttons.get(i);
		if(b instanceof Play) {
			((Play)b).mouseDown();
		}
	}
	slider.mouseDown();
}

void mouseReleased() {
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
	Barchart b2 = new Barchart();
	// b2.render(array);
}

