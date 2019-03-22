// This is a quick program to test C programs on my RV32EC CPU

int add();
void halt();

void main(){
	int x;
	x = add(10,20);
	halt();
}

int add(int a, int b){
	return a + b;
}

void halt(){
	while(1){
	}
}
