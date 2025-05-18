s.boot
s.meter
s.plotTree
s.makeWindow

(
SynthDef(\synth1, {
	|freq=440, gate=1, out=0|
	var sig, env;
	env = EnvGen.kr(Env.adsr(1,0,1,1), gate, doneAction:2);
	sig = Saw.ar(freq) * 0.3 * env;
	sig = LPF.ar(sig, MouseY.kr(100, 5000));
	Out.ar(out, sig!2);
}).add
)

(
SynthDef(\effect, {
	|in, out|
	var sig;
	sig = In.ar(in);
	sig = FreeVerb.ar(sig, 1,1);
	Out.ar(out, sig);
}).add;
)



~bus = Bus.audio(s,2)

e = Synth(\effect, [\in, ~bus, \out, 0])

(
p = Pbind(
	\instrument, \synth1,
	\out, ~bus,
	\midinote, Pseq([[62, 65, 69],[63, 66, 70]], inf),
	\dur, 5,
	\legato, 1


).play;
)
p.stop;

32.cpsmidi