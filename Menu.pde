class Menu {

	float posX, posY, w, h;
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
		this.mirrorSwitch = new ToggleSwitch(this.posX + w - (spacer*2) + 1000, this.posY + 500, 40, 20);
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
			169*py); // Shapes

		sizeSlider = new Slider(
			this.posX + 225*px, 
			shapeMenu.posY + shapeMenu.h + (spacer * 2), 
			180*px, 20*py, 
			arrayMin, arrayMax, arraySize); // Size
		
		speedSlider = new TickSlider(
			this.posX + 225*px, 
			sizeSlider.posY + sizeSlider.h + (spacer * 2), 
			180*px, 20*py, 3, 14); // Speed
		
		soundAttSlider = new Slider(
			this.posX + 225*px, 
			speedSlider.posY + speedSlider.h + (spacer * 3) + (titleSize / 2) + margin, 
			180*px, 
			20*py, 
			0.001, 1.0, 0.001); // Sound

		soundSusTSlider = new Slider(
			this.posX + 225*px, 
			soundAttSlider.posY + soundAttSlider.h + spacer, 
			180*px, 
			20*py, 
			0.001, 1.0, 0.004); // Sound

		soundSusLSlider = new Slider(
			this.posX + 225*px, 
			soundSusTSlider.posY + soundSusTSlider.h + spacer, 
			180*px, 
			20*py, 
			0.001, 1.0, 0.3); // Sound

		soundRelSlider = new Slider(
			this.posX + 225*px, 
			soundSusLSlider.posY + soundSusLSlider.h + spacer, 
			180*px, 
			20*py, 
			0.001, 1.0, 0.2); // Sound
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
	}

	// void updatePos2() {
	// 	if (closed) {
	// 		this.posX = width - this.w;
	// 		algMenu.updatePos(true, this.w);
	// 		shapeMenu.updatePos(true, this.w);
	// 		sizeSlider.updatePos(true, this.w);
	// 		speedSlider.updatePos(true, this.w);

	// 		soundAttSlider.updatePos(true, this.w);
	// 		soundSusTSlider.updatePos(true, this.w);
	// 		soundSusLSlider.updatePos(true, this.w);
	// 		soundRelSlider.updatePos(true, this.w);
	// 		closed = false;
	// 	} else {
	// 		this.posX = width;
	// 		algMenu.updatePos(false, this.w);
	// 		shapeMenu.updatePos(false, this.w);
	// 		sizeSlider.updatePos(false, this.w);
	// 		speedSlider.updatePos(false, this.w);

	// 		soundAttSlider.updatePos(false, this.w);
	// 		soundSusTSlider.updatePos(false, this.w);
	// 		soundSusLSlider.updatePos(false, this.w);
	// 		soundRelSlider.updatePos(false, this.w);
	// 		closed = true;
	// 	}
	// }

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
		text("Array Size", this.posX + 30*px, shapeMenu.posY + shapeMenu.h + (spacer * 2) + (fontSize / 2));
		text("Speed", this.posX + 30*px, sizeSlider.posY + sizeSlider.h + (spacer * 2) + (fontSize / 2));

		// Sound Controls
		text("Attack", this.posX + 30*px, speedSlider.posY + speedSlider.h + (spacer * 3) + (titleSize / 2) + (fontSize / 2) + margin);
		text("Sustain Time", this.posX + 30*px, soundAttSlider.posY + soundAttSlider.h + spacer + (fontSize / 2));
		text("Sustain Level", this.posX + 30*px, soundSusTSlider.posY + soundSusTSlider.h + spacer + (fontSize / 2));
		text("Merge", this.posX + 30*px, soundSusLSlider.posY + soundSusLSlider.h + spacer + (fontSize / 2));

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
	}

	void keyPressed() {
	  // If the return key is pressed, save the String and clear it
	  if (key == '\n' ) {
	    println("success");
	  }
	}

}