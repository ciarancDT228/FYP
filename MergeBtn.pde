class MergeBtn extends Thumbnail {

	MergeSort m;

	public MergeBtn(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		m = new MergeSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		m.steps(10300);
		arr = m.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Merge";
	}

	// void mouseUp() {
	// 	if (correctLocation() && depressed) {
	// 		println("MergeBtn Line 16");
	// 		//do some thing
	// 		if(!active) {
	// 			for (int i = 0; i < algorithmMenu.algThumbs.size(); i++) {
	// 				Thumbnail t = algorithmMenu.algThumbs.get(i);
	// 				if (!(t instanceof MergeBtn)) {
	// 					t.active = false;
	// 				}
	// 			}
	// 			active = true;
	// 		}
	// 	}
	// 	depressed = false;
	// 	offset = false;
	// }
	void mouseUp() {
		if (correctLocation() && depressed) {
			super.mouseUp(this);
		}
	}



}