s.boot;
s.plotTree;
s.meter;


(
SynthDef(\echo, {
	|in=0, out=0|
	var sig;
	sig = In.ar(in, 1);
	sig = CombN.ar(sig, 0.3, 0.3, 10);
	Out.ar(out, sig);
}).add;
)

~echo = Synth.new(\echo, [\in, 2, \out, 0]);

