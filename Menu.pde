class Menu {

	float posX, posY, w, h;
	float fontSize;
	SubMenu algMenu;
	ShapeMenu shapeMenu;

	Slider sizeSlider;

	Slider soundAttSlider;
	Slider soundSusTSlider;
	Slider soundSusLSlider;
	Slider soundRelSlider;

	public Menu() {
		this.w = 435*px;
		this.posX = width - w; //View X + View w - this w
		this.posY = 0; // View Y 
		this.h = height; //View h - Taskbar h
		this.fontSize = 16*px;
		algMenu = new SubMenu(this.posX, this.posY + 100*py, w, 114*py);
		shapeMenu = new ShapeMenu(this.posX, this.posY + 221*py, w, 169*py);
		sizeSlider = new Slider(this.posX + 225*px, posY + 414*py, 180*px, 20*py, arrayMin, arrayMax, arraySize);

		soundAttSlider = new Slider(this.posX + 225*px, posY + 554*py, 180*px, 20*py, 0.001, 1.0, 0.001); // Sound
		soundSusTSlider = new Slider(this.posX + 225*px, posY + 584*py, 180*px, 20*py, 0.001, 1.0, 0.004); // Sound
		soundSusLSlider = new Slider(this.posX + 225*px, posY + 614*py, 180*px, 20*py, 0.001, 1.0, 0.3); // Sound
		soundRelSlider = new Slider(this.posX + 225*px, posY + 644*py, 180*px, 20*py, 0.001, 1.0, 0.2); // Sound
	}

	public Menu(int x) {
		this.w = 435*px;
		this.posX = width - w; //View X + View w - this w
		this.posY = 0; // View Y 
		this.h = height; //View h - Taskbar h
		this.fontSize = 16*px;
		algMenu = new SubMenu(this.posX, this.posY + 100*py, w, 114*py);
		shapeMenu = new ShapeMenu(this.posX, this.posY + 221*py, w, 169*py);
		sizeSlider = new Slider(this.posX + 225*px, posY + 414*py, 180*px, 20*py, arrayMin, arrayMax, arraySize);

		soundAttSlider = new Slider(this.posX + 225*px, posY + 554*py, 180*px, 20*py, 0.001, 1.0, 0.001); // Sound
		soundSusTSlider = new Slider(this.posX + 225*px, posY + 584*py, 180*px, 20*py, 0.001, 1.0, 0.004); // Sound
		soundSusLSlider = new Slider(this.posX + 225*px, posY + 614*py, 180*px, 20*py, 0.001, 1.0, 0.3); // Sound
		soundRelSlider = new Slider(this.posX + 225*px, posY + 644*py, 180*px, 20*py, 0.001, 1.0, 0.2); // Sound
	}

	void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h);
		algMenu.render();
		shapeMenu.render();
		sizeSlider.render();

		soundAttSlider.render();
		soundSusTSlider.render();
		soundSusLSlider.render();
		soundRelSlider.render();

		//Text
		fill(p.font); // Array Size
		textSize(round(fontSize));
		textAlign(LEFT, CENTER);
		text("Array Size", this.posX + 30*px, posY + 414*py);

		// Sound Controls
		text("Attack", this.posX + 30*px, posY + 560*py);
		text("Sustain Time", this.posX + 30*px, posY + 590*py);
		text("Sustain Level", this.posX + 30*px, posY + 620*py);
		text("Merge", this.posX + 30*px, posY + 650*py);

	}

	void update() {
		algMenu.update();
		shapeMenu.update();
		sizeSlider.update();
		soundAttSlider.update();
		soundSusTSlider.update();
		soundSusLSlider.update();
		soundRelSlider.update();
	}

	void mouseUp() {
		algMenu.mouseUp();
		shapeMenu.mouseUp();
		sizeSlider.mouseUp();
		soundAttSlider.mouseUp();
		soundSusTSlider.mouseUp();
		soundSusLSlider.mouseUp();
		soundRelSlider.mouseUp();
	}

	void mouseDown() {
		algMenu.mouseDown();
		shapeMenu.mouseDown();
		sizeSlider.mouseDown();
		soundAttSlider.mouseDown();
		soundSusTSlider.mouseDown();
		soundSusLSlider.mouseDown();
		soundRelSlider.mouseDown();
	}

}