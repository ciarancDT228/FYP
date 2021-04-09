class Palette {

	int[] darkMode;
	int[] lightMode;

	int background;
	int foreground;
	int hover;
	int select;
	int accent;
	int barF;
	int barB;

	int font;
	int barchartFont;
	int barchartBg;
	int barchartFg;
	int btnHover;
	int btnSelect;
	int btnDepress;
	int sliderTrackEnabled;
	int sliderTrackDisabled;
	int sliderHighlightEnabled;
	int sliderHighlightDisabled;
	int thumbnailBg;
	int thumbnailFg;

	boolean colourMode;
	// int sliderHover;

	public Palette() {
		// int[] lightMode = {#eeeeee,#dddddd,#cccccc,#bbbbbb,#aaaaaa,#2d3142}; // white
		// int[] lightMode = {#6D769C,#dddddd,#cccccc,#bbbbbb,#A3A3A3,#525252}; // white2
		int[] lightMode = {#ffffff,#e0e0e0,#091540,#091540,#ffffff,#aecbfa,
		#f1f3f4,#feefc3,#1a73e8,#8db9f4,#ffffff,#bdc1c6}; //white 4


		// int[] lightMode = {#ffffff,#ffffff,#f1f3f4,#feefc3,#f8f9fa,#aecbfa, #091540}; // white 3
		
		// int[] lightMode = {#2d3142,#aaaaaa,#bbbbbb,#cccccc,#dddddd,#eeeeee};
		this.lightMode = lightMode;
		int[] darkMode = {#282828, #535353, #454545, #383838, #646464, #dddddd}; // dark
		this.darkMode = darkMode;
		// int[] darkMode = {#cc444b,#da5552,#df7373,#e39695,#e4b1ab,#3b1f2b}; // red
		this.barF = #dddddd;
		this.barB = #858585;
		this.darkMode = darkMode;
		this.colourMode = false;
		// dark();
		// light();
		dark();
	}

	// void dark() {
	// 	this.background = darkMode[0];
	// 	this.foreground = darkMode[1];
	// 	this.hover = darkMode[2];
	// 	this.select = darkMode[3];
	// 	this.accent = darkMode[4];
	// 	this.font = darkMode[5];
	// 	this.barF = darkMode[5];
	// 	this.barB = darkMode[0];
	// }

	void dark() {
		this.foreground = darkMode[1];
		this.accent = darkMode[4];
		this.font = darkMode[5];
		this.barchartFont = darkMode[0];
		this.barchartFg = darkMode[5];
		this.barchartBg = darkMode[0];
		this.btnHover = darkMode[2];
		this.btnSelect = darkMode[3];
		this.sliderHighlightEnabled = darkMode[0];
		this.sliderTrackEnabled = darkMode[4];
		this.sliderHighlightDisabled = darkMode[1];
		this.sliderTrackDisabled = darkMode[3];
		this.thumbnailBg = #595959;
		this.thumbnailFg = darkMode[0];
	}

	// void light() {
	// 	this.background = lightMode[0];
	// 	this.foreground = lightMode[1];
	// 	this.hover = lightMode[2];
	// 	this.select = lightMode[3];
	// 	this.accent = lightMode[4];
	// 	this.font = lightMode[6];
	// 	this.barF = lightMode[0];
	// 	this.barB = lightMode[5];
	// }

	void light() {
		this.foreground = lightMode[0];
		this.accent = lightMode[1];
		this.font = lightMode[2];
		this.barchartFont = lightMode[3];
		this.barchartFg = lightMode[4];
		this.barchartBg = lightMode[5];
		this.btnHover = lightMode[6];
		this.btnSelect = lightMode[7];
		this.sliderHighlightEnabled = lightMode[8];
		this.sliderTrackEnabled = lightMode[9];
		this.sliderHighlightDisabled = lightMode[10];
		this.sliderTrackDisabled = lightMode[11];
		this.thumbnailBg = #f6f6f6;
		this.thumbnailFg = lightMode[5];
		// int sliderHover = lightMode[12];
	}


	void display(float x, float y, float w, float h) {
		float spacer = 0;
		for (int i = 0; i < lightMode.length; i++) {
			fill(lightMode[i]);
			rect(x, y + spacer, w, h / lightMode.length);
			spacer += h / lightMode.length;
		}
		// fill(100);
		// rect(100, 100, 100, 1000);
	}


}