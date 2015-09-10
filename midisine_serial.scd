
/*1*/ s.boot;

(///2////

SynthDef( \midisine,{
	arg trig=0, atk=0.01, rel=0.1, crv= -3;
	var freq, synth, vol, pitch, amp, env;
	pitch = \pitch.kr(60, 0.017);
	amp = \amp.kr(0.85, 0.040);
	amp = Median.kr(25, amp);
	freq = pitch.midicps;
	env = EnvGen.ar( Env.asr(atk, 1, rel, crv), trig );
	synth = SinOsc.ar(freq);
	Out.ar(0, synth*env*amp);
}).add;

OSCdef( \trig, {|msg| ~mt.set(\trig, msg[1].asFloat)}, "/trig" );
OSCdef( \pitch, {|msg| ~mt.set(\pitch, msg[1].asFloat)}, "/pitch" );
OSCdef( \amp, {|msg| ~mt.set(\amp, msg[1].asFloat)}, "/amp" );

~ino = ArduinoSMS("/dev/tty.usbserial-AE015LFK", 19200);
~ino.action = {
	arg msg;
	var msgs, amp;
	msgs = msg.asString.split($:);
	amp = msgs[1].asFloat.linlin(7, 21.0, 0.0, 1.0);
	amp.postln;
	~mt.set(\amp, amp);
}
)

/*3*/ ~mt = Synth(\midisine, [\trig, 1]);

~mt.free;
~ino.close