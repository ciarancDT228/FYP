class Palette {

	int background;
	int foreground;
	int hover;
	int select;
	int accent;
	int font;

	int[] darkMode;


	public Palette() {
		// int[] b = {#03045e,#023e8a,#0077b6,#0096c7,#00b4d8,#48cae4,#90e0ef,#ade8f4,#caf0f8};
		// int[] g = {#ffffff,#f5f7fa,#e6e9ed,#ccd1d9,#aab2bd,#88909b,#656d78,#434a54,#000000};
		int[] darkMode = {#282828, #535353, #454545, #383838, #646464, #dddddd};
		// int[] darkMode = {#cc444b,#da5552,#df7373,#e39695,#e4b1ab,#3b1f2b}; // red
		// int[] darkMode = {#eeeeee,#dddddd,#cccccc,#bbbbbb,#aaaaaa,#2d3142}; // white
		this.darkMode = darkMode;
		this.background = darkMode[0];
		this.foreground = darkMode[1];
		this.hover = darkMode[2];
		this.select = darkMode[3];
		this.accent = darkMode[4];
		this.font = darkMode[5];
	}
}