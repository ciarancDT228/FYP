class BubbleBtn extends Thumbnail {

	BubbleSort b;

	public BubbleBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		b = new BubbleSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		b.steps(200000, arr, crr);
		arr = b.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Bubble";
	}

	void mouseUp() {
		if (correctLocation() && depressed) {
			//do some thing
			if(!active) {
				mergeSort.reset(array, colours);
				active = true;
			}
		} else {
			depressed = false;
			offsetXY = 0*px;
		}
	}

}