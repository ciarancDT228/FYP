
class Reset extends Button{

	public Reset(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			arraySize = menu.sizeSlider.getVal();

			for (int i = 0; i < menu.shapeMenu.btnThumbs.size(); i++) {
				ShapeBtn s = menu.shapeMenu.btnThumbs.get(i);
				if (s.active) {
					if (s.name.matches("random")) {
						array = GenerateArray.random(arraySize);
					} else if (s.name.matches("sinWave")) {
						array = GenerateArray.sinWave(arraySize, 1.5);
					} else if (s.name.matches("quadrant")) {
						array = GenerateArray.quadrant(arraySize);
					} else if (s.name.matches("heartbeat")) {
						array = GenerateArray.sinWave(arraySize, 7.5);
					} else if (s.name.matches("squiggle")) {
						array = GenerateArray.squiggle(arraySize);
					} else if (s.name.matches("parabola")) {
						array = GenerateArray.parabola(arraySize);
					} else if (s.name.matches("parabolaInv")) {
						array = GenerateArray.parabolaInv(arraySize);
					} else if (s.name.matches("descending")) {
						array = GenerateArray.desc(arraySize);
					}
				}
			}

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