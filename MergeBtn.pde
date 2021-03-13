class MergeBtn extends Thumbnail {

	MergeSort m;

	public MergeBtn(float posX, float posY, float d) {
		super(posX, posY, d);
		m = new MergeSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		m.steps(10300);
		arr = m.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Merge";
	}


}