class MergeBtn extends Thumbnail {

	Button descSwitch;
	MergeSort m;

	public MergeBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		m = new MergeSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize), true);
		m.steps(590, arr, crr);
		println("mergeBtn line 10");
		arr = m.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Merge";
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