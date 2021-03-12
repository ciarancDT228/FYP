
class Reset extends Button{

	public Reset(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			arraySize = sizeSlider.getVal();
			array = GenerateArray.random(arraySize);
			colours = GenerateArray.blanks(arraySize);
			bubble.reset(array, colours);
			selection.reset(array, colours);
			mergeSort.reset(array, colours);
			play.active = false;
			println(arraySize);
		}
		depressed = false;
		offset = false;
	}

}