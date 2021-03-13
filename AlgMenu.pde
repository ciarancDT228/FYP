class AlgMenu {

	float posX, posY, w, h;
	Thumbnail mergeBtn;
	Thumbnail bubbleBtn;
	Thumbnail selectionBtn;
	Thumbnail randomBtn;

	public AlgMenu (float posX, float posY) {
		this.posX = posX;
		this.posY = posY;
		this.w = 435*px;
		this.h = 114*py;
		this.mergeBtn = new MergeBtn(posX + 7*px, posY + 7*py, 100*px);
		this.bubbleBtn = new BubbleBtn(posX + 114*px, posY + 7*py, 100*px);
		this.selectionBtn = new SelectionBtn(posX + 221*px, posY + 7*py, 100*px);
		this.randomBtn = new BubbleBtn(posX + 328*px, posY + 7*py, 100*px);
	}

	void render() {
		strokeWeight((int)1*px);
		stroke(0);
		fill(255);
		rect(posX, posY, w, h, 8*px);
		mergeBtn.render();
		bubbleBtn.render();
		selectionBtn.render();
		randomBtn.render();
	}

}