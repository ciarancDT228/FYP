class Sound {

	float attackTime;
	float sustainTime;
	float sustainLevel;
	float releaseTime;
	float minFreq;
	float maxFreq;

	public Sound(float att, float susT, float susL, float rel, float minFreq, float maxFreq) {
		this.attackTime = att;
		this.sustainTime = susT;
		this.sustainLevel = susL;
		this.releaseTime = rel;
		this.minFreq = minFreq;
		this.maxFreq = maxFreq;
	}

	void update() {
		soundAttSlider.update();
		soundSusTSlider.update();
		soundSusLSlider.update();
		soundRelSlider.update();
	}

	void play() {
		int min = array.length+1;
		int max = 0;
		int med = 0;

		setAtt(soundAttSlider.getValFloat());
		setSusL(soundSusTSlider.getValFloat());
		setSusT(soundSusLSlider.getValFloat());
		setRel(soundRelSlider.getValFloat());

		for(int i = 0; i < colours.length; i++) {
			if (colours[i] > 0) {
				if(array[i] > max) {
					max = array[i];
				}
				if (array[i] < min) {
					min = array[i];
				}
			}
		}
		med = (max - min) / 2;
		triOsc.freq(map(med, 0, array.length, minFreq, maxFreq));
		env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
		// triOsc.freq(map(min, 0, array.length, minFreq, maxFreq));
		// env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
	}

	void setAtt(float att) {
		this.attackTime = att;
	}

	void setSusT(float susT) {
		this.sustainTime = susT;
	}

	void setSusL(float susL) {
		this.sustainLevel = susL;
	}

	void setRel(float rel) {
		this.releaseTime = rel;
	}

}