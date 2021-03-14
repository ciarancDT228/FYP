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

	void render() {

	}

	void update() {
		
	}
}