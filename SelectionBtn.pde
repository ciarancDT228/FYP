class SelectionBtn extends Thumbnail {

	SelectionSort s;

	public SelectionBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		s = new SelectionSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		s.steps(180000);
		arr = s.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Selection";
	}

	// void mouseUp() {
	// 	if (correctLocation() && depressed) {
	// 		super.mouseUp(this);
	// 	}
	// }

}