class SelectionBtn extends Thumbnail {

	SelectionSort s;

	public SelectionBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		s = new SelectionSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		s.steps(2000, arr, crr);
		arr = s.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Selection";
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