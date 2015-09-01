
/*1*/ s.boot;

(///2////
SynthDef( \midisine,{
	arg trig=0, atk=0.01, rel=0.1, crv= -3;
	var freq, synth, vol, pitch, amp, env;
	pitch = \pitch.kr(60, 0.017);
	amp = \amp.kr(0.85, 0.017);
	freq = pitch.midicps;
	env = EnvGen.ar( Env.asr(atk, 1, rel, crv), trig );
	synth = SinOsc.ar(freq);
	Out.ar(0, synth*env*amp);
}).add;

OSCdef( \trig, {|msg| ~mt.set(\trig, msg[1].asFloat)}, "/trig" );
OSCdef( \pitch, {|msg| ~mt.set(\pitch, msg[1].asFloat)}, "/pitch" );
OSCdef( \amp, {|msg| ~mt.set(\amp, msg[1].asFloat)}, "/amp" );

)

/*3*/ ~mt = Synth(\midisine);