final float vertRad = 3;
final PVector base1 = new PVector(10, 11);
final PVector base2 = new PVector(10, 12);

float cross(PVector a, PVector b) {
    return a.x * b.y - a.y * b.x;   
}

class Polygon {
    PVector p[] = new PVector[0];
    void add(PVector a) { //Basically push_back
        PVector np[] = new PVector[p.length + 1];
        for (int i = 0; i < p.length; ++i)
            np[i] = p[i].copy();
        np[p.length] = a;
        p = np;
    }
    void pop() { //Basically pop_back
        if (p.length > 0) {
            PVector np[] = new PVector[p.length - 1];
            for (int i = 0; i < p.length - 1; ++i)
                np[i] = p[i].copy();
            p = np;
        }
    }
    void show(boolean flag) {
        stroke(0);
        strokeWeight(1);
        for (int i = 0; i < p.length; ++i) {
            int j = (i + 1) % p.length;
            line(p[i].x, p[i].y, p[j].x, p[j].y);
        }
        if (flag) {
            noStroke();
            fill(0);
            for (int i = 0; i < p.length; ++i) {
                ellipseMode(RADIUS);
                ellipse(p[i].x, p[i].y, vertRad, vertRad);
            }
        }
    }
    void show() { show(false); }
    boolean in(PVector a) { //Check whether point is inside a polygon
        PVector pcopy[] = new PVector[p.length];
        for (int i = 0; i < p.length; ++i) pcopy[i] = p[i].copy();
        for (PVector vec : pcopy) vec.sub(a);   
        int cnt1 = 0, cnt2 = 0;
        for (int i = 0; i < pcopy.length; ++i) {
            int j = (i + 1) % pcopy.length;
            float b = cross(pcopy[i], pcopy[j]);
            float c = cross(pcopy[i], base1);
            float d = cross(base1, pcopy[j]);
            if (b >= 0 && c >= 0 && d >= 0 || b <= 0 && c <= 0 && d <= 0) ++cnt1;
            b = cross(pcopy[i], pcopy[j]);
            c = cross(pcopy[i], base2);
            d = cross(base2, pcopy[j]);
            if (b >= 0 && c >= 0 && d >= 0 || b <= 0 && c <= 0 && d <= 0) ++cnt2;
        }
        return cnt1 % 2 == 1 || cnt2 % 2 == 1;
    }
    void clear() { p = new PVector[0]; }
}
