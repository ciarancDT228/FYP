class BubbleBtn extends Thumbnail {

	BubbleSort b;

	public BubbleBtn(float posX, float posY, float d) {
		super(posX, posY, d);
		b = new BubbleSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		b.steps(200000);
		arr = b.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Bubble";
	}

}