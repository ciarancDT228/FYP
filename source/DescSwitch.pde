class DescSwitch extends ToggleSwitch {

	public DescSwitch(float posX, float posY, float w, float h) {
		super(posX, posY, w, h);
	}

	void mouseUp() {
		if(correctLocation() && depressed) {
			//do some thing
			if(active) {
				active = false;
				thumbX = posX;
				descThumb = false;
			} else {
				active = true;
				thumbX = posX + w;
				descThumb = true;
			}
			if(!play.active) {
				reset.reset();
			}
		}
		shade = p.foreground;
		depressed = false;
		offsetXY = 0*px;
	}

}