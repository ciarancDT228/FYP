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

	void render() {
		noStroke();
		fill(p.foreground);
		rect(posX, posY, w, h);
		algMenu.render();
	}

	void update() {
		algMenu.update();
	}

	void mouseUp() {
		algMenu.mouseUp();
	}

	void mouseDown() {
		algMenu.mouseDown();
	}

}