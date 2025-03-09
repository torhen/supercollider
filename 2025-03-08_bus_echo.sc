s.boot;
s.plotTree;
s.meter;

// Create an audio bus with one channel (mono)
~bus = Bus.audio(s, 1);

(
// A simple synth that plays a sine wave
SynthDef(\simple_synth, {
	|out = 0, freq = 440, gate=1|
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.01, 0.3, 1, 0.1), gate, doneAction:2);
	sig = SinOsc.ar(freq) * env * 0.1;
	Out.ar(out, sig);
}).add;
)

// test synth
a = Synth(\simple_synth);
a.set(\gate, 0);


(
// Design the echo effect
SynthDef(\echo_effect, {
    |in = 0, out = 0|
    var sig = In.ar(in, 1); // Read from the bus
    var echo = CombN.ar(sig, 0.3, 0.3, 10); // Echo effect
    Out.ar(0, echo);
}).add;
)

// First, start the effect synth so it's always processing the bus.
~echo = Synth(\echo_effect, [\in, ~bus, \out, 0]);


// test the synth with bus
a = Synth(\simple_synth, [\out, ~bus]);
a.set(\gate,0);

(
p = Pbind(
    \instrument, \simple_synth,
    \out, ~bus,
	\freq, Pxrand([330, 440, 550], inf),
	\dur, Pxrand([1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5], inf),
	\legato, 0.1
).play;
)

p.stop()

