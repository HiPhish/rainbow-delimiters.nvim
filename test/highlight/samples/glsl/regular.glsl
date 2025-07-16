#version 450
layout(local_size_x = 256)in;

struct A{
    float a,b;
};

layout(set = 0,binding = 0)buffer B{
    A v[];
};

uint C(uint, uint);
uint C(uint a, uint b){
    {
        {
            return a+b;
        }
    }
}

uint V(){
    return v[1].a
}

void main(){
    uint t = gl_GlobalInvocationID.x;
    uint a = 1;uint b = 1;
    uint c = C(C(a, b), b);
    if (1){
        if (1){
            if (1){
                a = C(V(),c);
            }
        }
    }
    else if(1){
        b=1;
    }

    while (0) {
        while (0) {
            while (0) {
                ;
            }
        }
    }

    for (uint i = 0; i < 0; i++) {
        for (uint j = 0; j < 0; j++) {
            for (uint k = 0; k < 0; k++) {
                ;
            }
        }
    }

    v[t].a = a;
    v[t].b = b;
}
