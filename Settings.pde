class Settings extends Button{

	public Settings(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			menu.toggleMenu = true;
			if (b.w + (b.border * 2) == width) {
				b.w -= menu.w;
			} else {
				b.w += menu.w;
			}
		}
		depressed = false;
		offsetXY = 0*px;
	}
}