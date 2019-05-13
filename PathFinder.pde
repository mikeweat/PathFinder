import java.util.*;

Polygon p = new Polygon();
Population pop;

Start start;
Finish finish;
Button editorSwitch;
Button startBtn, finishBtn, graphBtn;
boolean editor;
Action act;
color cred, cgreen;
int speed;

enum Action {
    START,
    FINISH, 
    GRAPH
}

void define() {
    start = new Start(new PVector(-width / 4, 0));
    finish = new Finish(new PVector(width / 4, 0));
    p.add(new PVector(-width * 0.3, height * 0.1));
    p.add(new PVector(width * 0.3, height * 0.1));
    p.add(new PVector(width * 0.3, -height * 0.1));
    p.add(new PVector(-width * 0.3, -height * 0.1));
    startRad = width * 0.01;
    finishRad = width * 0.01;
    editor = true;
    act = Action.GRAPH;
    cred = color(200, 6, 12);
    cgreen = color(100, 200, 20);
    speed = 1;
}

void setup() { //Starting the app
    fullScreen(JAVA2D); //Renderer   
    textFont(loadFont("NimbusSanL-Regu-24.vlw"));
    createButtons();
    define();
}

void draw() { //Called every frame
    background(255); //Fill background with some color
    pushMatrix();
    translate(width / 2, height / 2); //Set the center of screen as (0, 0)
    scale(1, -1); //Direct the y-axis up
    p.show(editor); //Draw the polygon
    start.show(); //Draw start point
    finish.show(); //Draw finish point
    if (editor) {
        
    } else {
        if (pop.undead() == 0) pop.newgen(); //Generate a new gen if everyone is dead
        for (Dot d : pop.d) {
            for (int i = 0; i < speed; ++i) d.move();
            d.show();
        }
    }
    popMatrix();
    editorSwitch.show();
    if (editor) {
        showEditorButtons();
    } else {
        textAlign(LEFT, CENTER);
        text("Generation " + pop.gen, 10, height * 2 / 30);
    }
}

void showEditorButtons() {
    startBtn.show();
    startBtn.showCircle(cgreen, (startBtn.x2 - startBtn.x1) / 3);
    finishBtn.show();
    finishBtn.showCircle(cred, (finishBtn.x2 - finishBtn.x1) / 3);
    graphBtn.show();
    graphBtn.showGraph((graphBtn.x2 - graphBtn.x1) / 4, (graphBtn.x2 - graphBtn.x1) / 12);
}

void mousePressed() {
    if (editor) {
        if (editorSwitch.check()) {
            editor = false;
            editorSwitch.text = "to Editor";
            speed = 1;
            pop = new Population();
        } else if (startBtn.check()) {
            act = Action.START;
        } else if (finishBtn.check()) {
            act = Action.FINISH;
        } else if (graphBtn.check()) {
            act = Action.GRAPH;
        } else {
            PVector pos = new PVector(mouseX - width / 2, -(mouseY - height / 2));
            switch (act) {
                case START:
                    start.pos = pos;
                    break;
                case FINISH:
                    finish.pos = pos;
                    break;
                case GRAPH:
                    p.add(pos);
                    break;
            }
        }
    } else {
        if (editorSwitch.check()) {
            editor = true;
            editorSwitch.text = "to Learning";
            act = Action.GRAPH;
        }
    }
}

void keyPressed() {
    if (editor) {
        if (act == Action.GRAPH) {
            if (key == 'x' || key == 'X') p.clear();
            if (key == 'z' || key == 'Z') p.pop();
        }
    } else {
        if (keyCode >= 48 && keyCode <= 57) 
            speed = int(pow(2, keyCode - 48));
    }
}
