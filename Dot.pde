final int braincnt = 1000;
final float maxvel = 15;
final float dotRad = 3;

class Dot { //The living thing that moves around
    PVector pos, vel = new PVector(0, 0);
    Brain brain = new Brain(2000);
    boolean dead = false;
    int moves = 0;
    Dot() {}
    Dot(float x, float y) {
        pos = new PVector(x, y); 
    }
    Dot(PVector p) {
        pos = p.copy();
    }
    void move() {
        if (!dead) {
            ++moves;
            vel.add(brain.next()); //Accelerate depending on brain
            vel.limit(maxvel); //Limitate maximum velocity
            pos.add(vel); //Actually move
        }
        if (!p.in(pos)) dead = true;
        if (finished()) dead = true;
    }
    void show() { //Draw dot
        fill(0);
        noStroke();
        ellipseMode(RADIUS);
        ellipse(pos.x, pos.y, dotRad, dotRad);
    }
    boolean finished() {
        return pos.dist(finish.pos) <= finishRad;   
    }
    float fitness() {
        if (finished()) return 100000000.0 / pow(moves, 2) + 100.0 / pow(pos.dist(finish.pos), 2);
        else return 100.0 / pow(pos.dist(finish.pos), 2);   
    }
    void mutate(float x) {
        brain.mutate(x);   
    }
}

final float maxacc = 0.1;

class Brain { //Dot's brain - where to move
    PVector acc[];
    int ptr = 0;
    PVector rndvec() {
        PVector ans = PVector.random2D();
        ans.limit(maxacc);
        return ans;
    }
    Brain(int size) {
        acc = new PVector[size];
        for (int i = 0; i < size; ++i)
            acc[i] = rndvec();
    }
    PVector next() {
        PVector ans = acc[ptr].copy();
        ++ptr;
        if (ptr == acc.length) ptr = 0;
        return ans;
    }
    Brain copy() {
        Brain ans = new Brain(acc.length);
        for (int i = 0; i < acc.length; ++i)
            ans.acc[i] = acc[i].copy();
        return ans;
    }
    void mutate(float x) {
        for (int i = int(acc.length * x); i >= 0; --i) {
            int ind = int(random(min(acc.length - 1, pop.gen - 1), acc.length));
            acc[ind] = rndvec();
        }
    }
}
