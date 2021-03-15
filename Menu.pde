class Menu {

	float posX, posY, w, h;
	SubMenu algMenu;
	ShapeMenu shapeMenu;

	public Menu() {
		this.w = 435*px;
		this.posX = width - w; //View X + View w - this w
		this.posY = 0; // View Y 
		this.h = height; //View h - Taskbar h
		algMenu = new SubMenu(this.posX, 100*py, w, 114*py);
		shapeMenu = new ShapeMenu(this.posX, 221*py, 435*px, 221*py);
	}

	void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h);
		algMenu.render();
		shapeMenu.render();
	}

	void update() {
		algMenu.update();
		shapeMenu.update();
	}

	void mouseUp() {
		algMenu.mouseUp();
		shapeMenu.mouseUp();
	}

	void mouseDown() {
		algMenu.mouseDown();
		shapeMenu.mouseDown();
	}

}