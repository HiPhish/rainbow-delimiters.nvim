class A(T){
	T t;
}
int fn(T)(T t)
in (t>0)
out (r;r>0)
{
	auto tc=(t+2)*3;
	auto r = f!(int)(tc+1);
	auto r1 = r[t+1];
	auto a = [1,2,3];
	auto b = cast(double)0.0;
	string[] sa;
	if (false){
		return;
	}
	for(int i; i<10;i++){
		writeln(i);
	}
	//
	foreach (s; sa) {
		writeln(s);
	}
	return 1000;
}
