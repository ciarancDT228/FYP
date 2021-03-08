
class Reset extends Button{

	public Reset(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			arraySize = sizeSlider.getVal();
			array = gen.random(arraySize);
			colours = gen.blanks(arraySize);
			bubble.reset(array, colours);
			play.active = false;

		}
		depressed = false;
		offset = false;
	}

}