s.boot
s.meter
s.plotTree
s.makeWindow

~bus = Bus.audio(s);

(
SynthDef(\effect, {
	|in=0, out=0|
	var sig;
	sig = In.ar(in);
	sig = LPF.ar(sig, LFTri.kr(0.1).linexp(-1, 1, 200, 10000));
	Out.ar(out, sig);
}).add;

)
(
SynthDef(\synth1, {
	|freq=440, gate=1, out=0, vol=0.3|
	var sig, env;
	env = EnvGen.kr(Env.adsr(0,0,1,0.4), gate, doneAction:2);
	sig = Saw.ar(freq);
	sig = sig * env * vol;
	Out.ar(out, sig);

}).add;
)

(
e = Synth(\effect, [\in, ~bus, \out, 0]);

p = Pbind(\instrument, \synth1,
	\out, ~bus,
	\freq, Pseq([110, 110], inf),
	\dur, Pseq([0.2, 0.2],inf),
	\legato, Pseq([0.3, 0.1],inf)

).play
)

p.stop
