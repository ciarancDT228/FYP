class Thumbnail {

	float posX, posY, w, h;
	// float px;
	int[] arr;
	int[] crr;
	Barchart thumbnail;
	int arrSize;
	String label;

	public Thumbnail (float posX, float posY, float d) {
		this.posX = posX;
		this.posY = posY;
		this.w = d;
		this.h = d;
		// px = d/100;
		arrSize = (int)(68*10);
		thumbnail = new Barchart(posX + 16*px, posY + 14*px, 68*px, 46*px);
	}

	void render() {
		if ((int)1*px < 1) {
			strokeWeight(1);
		} else {
			strokeWeight((int)1*px);
		}
		stroke(0);
		fill(255);
		rect(posX, posY, 100*px, 100*px, 8*px);
		thumbnail.render(arr, crr);
		noFill();
		strokeWeight((int)3*px);
		stroke(255);
		rect(posX + 15*px, posY + 13*px, 70*px, 48*px, 8*px);
		noFill();
		strokeWeight((int)2*px);
		stroke(0);
		rect(posX + 16*px, posY + 14*px, 68*px, 46*px, 8*px);
		fill(0);
		textSize(16*px);
		textAlign(CENTER);
		text(label, posX + 50*px, posY + 86*px);
	}
}