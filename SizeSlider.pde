class SizeSlider extends Slider {

	public SizeSlider(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
		this.thumbX = map(arraySize, arrayMin, arrayMax, posX, posX + w);
	}

	int getVal() {
		return(int)(map(thumbX, posX, posX + w, arrayMin, arrayMax));
	}
}