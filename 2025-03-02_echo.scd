s.boot;
s.plotTree;

(
SynthDef(\test, {
	arg freq=440, gate=1;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.ar(Env.adsr(attackTime:0.01, decayTime:0.5, sustainLevel:0), gate, doneAction:2);
	sig = sig * env * 0.3;
	sig = CombL.ar(sig, 0.2, 0.2, 3);
	Out.ar(0, sig);
}).add;

)

a = Synth.new(\test);
a.set(\gate, 0);

(
Pbind(\instrument, \test,
	\dur, 1,
	\freq, Pseq([440, 550, 660], inf)
).play;
)
