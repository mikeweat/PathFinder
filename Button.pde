class Button {
    int x1, x2, y1, y2;
    String text;
    Button(String text, float x1, float x2, float y1, float y2) {
        this.text = text;
        this.x1 = int(x1);
        this.x2 = int(x2);
        this.y1 = int(y1);
        this.y2 = int(y2);
    }
    boolean check() {
        return mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2;
    }
    void show() {
        if (check()) {
            if (mousePressed) fill(125, 125, 125);
            else fill(150, 150, 150);
        } else fill(200, 200, 200);
        noStroke();
        rect(x1, y1, x2 - x1, y2 - y1, 3);
        fill(0);
        textAlign(CENTER, CENTER);
        text(text, (x1 + x2) / 2, (y1 + y2) / 2);
    }
    void showCircle(color c, float r) {
        fill(c);
        noStroke();
        ellipseMode(RADIUS);
        ellipse((x1 + x2) / 2, (y1 + y2) / 2, r, r);
    }
    void showGraph(float R, float r) {
        PVector p1 = new PVector((x1 + x2) / 2 - R, (y1 + y2) / 2 - R);
        PVector p2 = new PVector((x1 + x2) / 2 + R, (y1 + y2) / 2 + R);
        stroke(0);
        strokeWeight(r / 4);
        line(p1.x, p1.y, p2.x, p2.y);
        noStroke();
        fill(0);
        ellipseMode(RADIUS);
        ellipse(p1.x, p1.y, r, r);
        ellipse(p2.x, p2.y, r, r);
    }
}


void createButtons() {
    editorSwitch = new Button("to Learining", width / 2 - width / 5, width / 2 + width / 5, height / 20, height / 12);
    startBtn = new Button("", width * 0.93, width * 0.98, height / 20, height / 20 + width * 0.05);
    finishBtn = new Button("", width * 0.93, width * 0.98, height / 20 + width * 0.07, height / 20 + width * 0.12);
    graphBtn = new Button("", width * 0.93, width * 0.98, height / 20 + width * 0.14, height / 20 + width * 0.19);   
}
