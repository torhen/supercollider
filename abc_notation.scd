(
~addSep = {
	arg s;
	var aInd, aRange, r, aNotes;
	aInd = s.findAllRegexp("[_\^]?[abcdefgABCDEFG][,']*\d*/?\d*");
	aInd = aInd.add(s.size);
	aRange = Array.series(aInd.size-1);
	r = "";
	aRange.do({arg i;r = r ++ s.copyRange(aInd[i],aInd[i+1]-1) ++ " "});
	r = r.copyRange(0, r.size-2);
};

~getPitch = {
	arg s;
	var sign, letter, reg, regsign, lower, dsign, dletter;

	// add dummy if no sign
	s = if( s.beginsWith("_") || s.beginsWith("^"),
		{s},
		{"0" ++ s}
	);

	sign = s.copyRange(0,0);
	letter = s.copyRange(1,1);

	lower = if(letter.toLower==letter,12,0);
	letter = letter.toUpper;


	reg = s.findRegexp(",").size * (-1);
	reg = if(reg==0, s.findRegexp("'").size, reg);
	reg = reg * 12;


	dsign= Dictionary.newFrom(List["0", 0, "_", -1, "^", 1]);

	dletter = Dictionary.new;
	dletter.add("C" -> 60);dletter.add("D" -> 62);dletter.add("E" -> 64);
	dletter.add("F" -> 65);dletter.add("G" -> 67);dletter.add("A" -> 69);
	dletter.add("B" -> 71);

	letter = dletter[letter] + dsign[sign] + lower + reg;
};

~getDur = {
	arg s;
	var r, sDur, fDur;
	r = s.findRegexp("[0-9]*/?[0-9]+");

	sDur = if(r.size == 0,{"1"},{r[0][1]});
	sDur = if(sDur.beginsWith("/"), "1" ++ sDur, sDur);
	fDur = sDur.interpret
};

~abc = {
	arg s="C/4 E/4 G/4 c/4", d=1, occ=1, amp=0.1;
	var a, midinote, dur;
	s = s.replace(" ");
	s = ~addSep.value(s);
	s.postln;
	a = s.split($ );
	midinote = a.collect(~getPitch);
	dur = a.collect(~getDur);
	midinote = Pseq(midinote, occ);
	dur = Pseq(dur * d, occ);
	Pbind(\amp, amp, \midinote, midinote, \dur, dur);
};

s.waitForBoot({~abc.value.play;"Hello!".postln});
)
