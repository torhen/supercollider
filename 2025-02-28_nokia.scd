s.boot;
s.plotTree;

(
SynthDef.new(\test, {
	arg gate=1, freq=440;
	var sig, env;
	sig = Saw.ar(freq);
	env = EnvGen.kr(Env.adsr(attackTime:0.01, sustainLevel:1, releaseTime:0.01), gate, doneAction:2);
	Out.ar(0, sig * env * 0.5);
}).add;
)

a = Synth.new(\test);
a.set(\gate, 0);

(
Pbind(\instrument,\test,
	\midinote, Pseq([76,74,66,68,73,71,62,64,71,69,61,64,69] + 12, 1),
	\dur, Pseq([0.25, 0.25, 0.5, 0.5,0.25, 0.25, 0.5, 0.5,0.25, 0.25, 0.5, 0.5,1] * 0.8, 1),
	\legato, 1
).play;
)