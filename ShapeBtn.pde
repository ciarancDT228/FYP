class ShapeBtn extends Thumbnail {

	String name;

	public ShapeBtn(float posX, float posY, float w, float h, String name) {
		super(posX, posY, w, h);
		crr = GenerateArray.blanks(arrSize);
		if (name.matches("random")) {
			arr = GenerateArray.random(arrSize);
			this.label = "Random";
			this.name = "random";
		} else if (name.matches("sinWave")) {
			arr = GenerateArray.sinWave(arrSize, 1.5);
			this.label = "Sin Wave";
			this.name = "sinWave";
		} else if (name.matches("quadrant")) {
			arr = GenerateArray.quadrant(arrSize);
			this.label = "Exponent";
			this.name = "quadrant";
		} else if (name.matches("heartbeat")) {
			arr = GenerateArray.sinWave(arrSize, 7.5);
			this.label = "Heartbeat";
			this.name = "heartbeat";
		} else if (name.matches("squiggle")) {
			arr = GenerateArray.squiggle(arrSize);
			this.label = "Spectrum";
			this.name = "squiggle";
		} else if (name.matches("parabola")) {
			arr = GenerateArray.parabola(arrSize);
			this.label = "Parabola";
			this.name = "parabola";
		} else if (name.matches("parabolaInv")) {
			arr = GenerateArray.parabolaInv(arrSize);
			this.label = "Parabola";
			this.name = "parabolaInv";
		} else if (name.matches("descending")) {
			arr = GenerateArray.desc(arrSize);
			this.label = "Descending";
			this.name = "descending";
		}
	}

}