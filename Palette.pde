class Palette {

	int[] darkMode;
	int[] lightMode;

	int background;
	int foreground;
	int hover;
	int select;
	int accent;
	int font;
	int barF;
	int barB;

	public Palette() {
		// int[] lightMode = {#eeeeee,#dddddd,#cccccc,#bbbbbb,#aaaaaa,#2d3142}; // white
		int[] lightMode = {#6D769C,#dddddd,#cccccc,#bbbbbb,#A3A3A3,#525252}; // white2
		
		// int[] lightMode = {#2d3142,#aaaaaa,#bbbbbb,#cccccc,#dddddd,#eeeeee};
		this.lightMode = lightMode;
		int[] darkMode = {#282828, #535353, #454545, #383838, #646464, #dddddd}; // dark
		this.darkMode = darkMode;
		// int[] darkMode = {#cc444b,#da5552,#df7373,#e39695,#e4b1ab,#3b1f2b}; // red
		this.barF = #dddddd;
		this.barB = #858585;
		this.darkMode = darkMode;

		dark();
		light();
	}

	void dark() {
		this.background = darkMode[0];
		this.foreground = darkMode[1];
		this.hover = darkMode[2];
		this.select = darkMode[3];
		this.accent = darkMode[4];
		this.font = darkMode[5];
		this.barF = darkMode[5];
		this.barB = darkMode[0];
	}

	void light() {
		this.background = lightMode[0];
		this.foreground = lightMode[1];
		this.hover = lightMode[2];
		this.select = lightMode[3];
		this.accent = lightMode[4];
		this.font = lightMode[5];
		this.barF = lightMode[2];
		this.barB = lightMode[0];
	}


}