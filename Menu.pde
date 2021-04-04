class Menu {

	float posX, posY, w, h;
	int arrSizeDisplay;
	int speed;
	float wTarget;
	float spacer;
	float margin;
	float fontSize;
	float titleSize;
	PFont f;
	PFont t;

	AlgMenu algMenu;
	ShapeMenu shapeMenu;

	Slider sizeSlider;
	Slider speedSlider;
	Slider soundAttSlider;
	Slider soundSusTSlider;
	Slider soundSusLSlider;
	Slider soundRelSlider;

	Button mirrorSwitch;
	Button descSwitch;
	Button colourSwitch;

	boolean toggleMenu;
	boolean closed;
	boolean colourMode;

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
		this.wTarget = width;
		this.colourMode = false;
		
		descSwitch = new DescSwitch(
			this.posX + this.w - spacer - 17*px, 
			this.posY + (spacer * 2.5), 
			17*px, 
			20*py);

		algMenu = new AlgMenu(
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
			arrayMin, arrayMax, arraySize, true); // Size
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
			0.001, 1.0, 0.001, false); // Sound

		soundSusTSlider = new Slider(
			this.posX + 225*px, 
			soundAttSlider.posY + soundAttSlider.h + spacer, 
			180*px, 
			20*py, 
			0.001, 1.0, 0.004, false); // Sound

		soundSusLSlider = new Slider(
			this.posX + 225*px, 
			soundSusTSlider.posY + soundSusTSlider.h + spacer, 
			180*px, 
			20*py, 
			0.001, 1.0, 0.3, false); // Sound

		soundRelSlider = new Slider(
			this.posX + 225*px, 
			soundSusLSlider.posY + soundSusLSlider.h + spacer, 
			180*px, 
			20*py, 
			0.001, 1.0, 0.2, false); // Sound

		mirrorSwitch = new ToggleSwitch(
			this.posX + this.w - spacer - 17*px, 
			algMenu.posY + algMenu.h + (spacer * 2.5), 
			17*px, 
			20*py);

		colourSwitch = new ToggleSwitch(
			this.posX + this.w - spacer - 17*px, 
			soundRelSlider.posY + soundRelSlider.h + spacer,
			17*px, 
			20*py);
		colourSwitch.active = true;

	}

	void update() {
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
		descSwitch.update();
		colourSwitch.update();
		if (colourSwitch.active && !colourMode) {
			p.dark();
			colourMode = true;
		} else if (!colourSwitch.active && colourMode) {
			p.light();
			colourMode = false;
		}
	}

	void render() {
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
		descSwitch.render();
		colourSwitch.render();

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
		text("Mirror", this.posX + spacer + (w/1.5), algMenu.posY + algMenu.h + (spacer * 2) + (fontSize / 3));
		text("Desc", this.posX + spacer + (w/1.5), posY + (spacer * 2) + (fontSize / 3));
		// text("Speed", this.posX + 30*px, sizeSlider.posY + sizeSlider.h + (spacer * 2) + (fontSize / 2));

		textAlign(LEFT, CENTER);
		text("Array Size", this.posX + 30*px, shapeMenu.posY + shapeMenu.h + (spacer * 2) + (fontSize / 2));
		text("Speed", this.posX + 30*px, sizeSlider.posY + sizeSlider.h + (spacer * 2) + (fontSize / 2));

		// Sound Controls
		text("Attack", this.posX + 30*px, speedSlider.posY + speedSlider.h + (spacer * 3) + (titleSize / 2) + (fontSize / 2) + margin);
		text("Sustain Time", this.posX + 30*px, soundAttSlider.posY + soundAttSlider.h + spacer + (fontSize / 2));
		text("Sustain Level", this.posX + 30*px, soundSusTSlider.posY + soundSusTSlider.h + spacer + (fontSize / 2));
		text("Release", this.posX + 30*px, soundSusLSlider.posY + soundSusLSlider.h + spacer + (fontSize / 2));

	}

	void mouseUp() {
		algMenu.mouseUp();
		shapeMenu.mouseUp();
		sizeSlider.mouseUp();
		soundAttSlider.mouseUp();
		soundSusTSlider.mouseUp();
		soundSusLSlider.mouseUp();
		soundRelSlider.mouseUp();
		speedSlider.mouseUp();
		mirrorSwitch.mouseUp();
		descSwitch.mouseUp();
		colourSwitch.mouseUp();
	}

	void mouseDown() {
		algMenu.mouseDown();
		shapeMenu.mouseDown();
		sizeSlider.mouseDown();
		soundAttSlider.mouseDown();
		soundSusTSlider.mouseDown();
		soundSusLSlider.mouseDown();
		soundRelSlider.mouseDown();
		speedSlider.mouseDown();
		mirrorSwitch.mouseDown();
		descSwitch.mouseDown();
		colourSwitch.mouseDown();
	}

	void keyPressed() {
	  // If the return key is pressed, save the String and clear it
	  if (key == '\n' ) {
	    println("success");
	  }
	}

}