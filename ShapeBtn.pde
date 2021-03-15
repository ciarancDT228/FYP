class ShapeBtn extends Thumbnail {

	String name;

	public ShapeBtn(float posX, float posY, float w, float h, String name) {
		super(posX, posY, w, h);
		crr = GenerateArray.blanks(arrSize);
		if (name.matches("random")) {
			arr = GenerateArray.random(arrSize);
			crr = GenerateArray.blanks(arrSize);
			this.label = "Random";
		} else if (name.matches("sinWave")) {
			arr = GenerateArray.sinWave(arrSize, 0.5);
			crr = GenerateArray.blanks(arrSize);
			this.label = "Sin Wave";
		} else if (name.matches("quadrant")) {
			arr = GenerateArray.random(arrSize);
			crr = GenerateArray.blanks(arrSize);
			this.label = "Exponent";
		} else if (name.matches("heartbeat")) {
			arr = GenerateArray.sinWave(arrSize, 1.5);
			crr = GenerateArray.blanks(arrSize);
			this.label = "Heartbeat";
		} else if (name.matches("squiggle")) {
			arr = GenerateArray.sinWave(arrSize, 2.5);
			crr = GenerateArray.blanks(arrSize);
			this.label = "Spectrum";
		} else if (name.matches("parabola")) {
			arr = GenerateArray.random(arrSize);
			crr = GenerateArray.blanks(arrSize);
			this.label = "Parabola";
		} else if (name.matches("parabolaInv")) {
			arr = GenerateArray.sinWave(arrSize, 3.5);
			crr = GenerateArray.blanks(arrSize);
			this.label = "Parabola";
		} else if (name.matches("descending")) {
			arr = GenerateArray.random(arrSize);
			crr = GenerateArray.blanks(arrSize);
			this.label = "descending";
		}
	}

	void render() {
		if (highlight) {
			strokeWeight(1*px);
			stroke(p.accent);
		} else {
			noStroke();
		}
		fill(shade);
		rect(posX - offsetXY, posY + offsetXY, 100*px, 74*py, 8*px);
		b.renderSimple(arr, this);
		// Overlay
		noFill();
		strokeWeight(4*px);
		stroke(shade);
		rect(posX - offsetXY + 15*px, posY + offsetXY + 13*py, 70*px, 48*py, 8*px);
		// Border
		noFill();
		strokeWeight(2*px);
		stroke(p.accent);
		rect(posX - offsetXY + 16*px, posY + offsetXY + 14*py, 68*px, 46*py, 8*px); 
	}

}