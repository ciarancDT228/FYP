class SelectionBtn extends Thumbnail {

	SelectionSort s;

	public SelectionBtn(float posX, float posY, float d) {
		super(posX, posY, d);
		s = new SelectionSort(GenerateArray.random(arrSize), GenerateArray.blanks(arrSize));
		s.steps(180000);
		arr = s.getArray();
		crr = GenerateArray.blanks(arrSize);
		this.label = "Selection";
	}

}