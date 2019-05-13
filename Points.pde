float startRad;
float finishRad;

class Start {
    PVector pos;
    Start(PVector p) {
        pos = p.copy();   
    }
    void show() {
        noStroke();
        fill(cgreen);
        ellipseMode(RADIUS);
        ellipse(pos.x, pos.y, startRad, startRad);
    }
}

class Finish {
    PVector pos;
    Finish(PVector p) {
        pos = p.copy();   
    }
    void show() {
        noStroke();
        fill(cred);
        ellipseMode(RADIUS);
        ellipse(pos.x, pos.y, startRad, startRad);
    }
}
