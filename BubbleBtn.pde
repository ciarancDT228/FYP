class BubbleBtn extends Thumbnail {

	BubbleSort b;

	public BubbleBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		b = new BubbleSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		b.steps(200000);
		arr = b.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Bubble";
	}

	void mouseUp() {
		if (correctLocation() && depressed) {
			super.mouseUp(this);
		}
	}

}