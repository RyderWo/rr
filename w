import objectdraw.*;
import java.awt.*;

public class Frogger extends WindowController {
    private static final double HIGHWAY_LENGTH = 700;
    private static final double LANE_WIDTH = 100;
    private static final int NUM_LANES = 4;
    private static final double HIGHWAY_WIDTH = LANE_WIDTH * NUM_LANES;
    private static final double LINE_WIDTH = LANE_WIDTH / 10;
    private static final double HIGHWAY_LEFT = 0;
    private static final double HIGHWAY_RIGHT = HIGHWAY_LEFT + HIGHWAY_LENGTH;
    private static final double HIGHWAY_TOP = LANE_WIDTH;
    private static final double HIGHWAY_BOTTOM = HIGHWAY_TOP + HIGHWAY_WIDTH;
    private static final double LINE_SPACING = LINE_WIDTH / 2;
    private static final double DASH_LENGTH = LANE_WIDTH / 3;
    private static final double DASH_SPACING = DASH_LENGTH / 2;

    private static final double FROG_WIDTH = 83;
    
    private Frog frog1;
    private lane lane1;
    private lane lane2;
    private lane lane3;
    private lane lane4;
    
    public void begin() {
        new FilledRect(HIGHWAY_LEFT, HIGHWAY_TOP, HIGHWAY_LENGTH, HIGHWAY_WIDTH, canvas);

        int whichLine = 1;
        while (whichLine < NUM_LANES) {
            if (whichLine == NUM_LANES / 2) {
                drawNoPassingLine(HIGHWAY_TOP + (whichLine * LANE_WIDTH) - (LINE_SPACING / 2 + LINE_WIDTH));
            } else {
                drawPassingLine(HIGHWAY_TOP + (whichLine * LANE_WIDTH) - (LINE_WIDTH / 2));
            }
            whichLine = whichLine + 1;
        }
        
        Image i = getImage("froggy.gif");
        Image k = getImage("jeep_right.gif");
        Image f = getImage("oldcar_left.gif");
        Image g = getImage("taxi_left.gif");
        Image h = getImage("van_right.gif");
        
        int jeep = 50;
        int f1 = 42;
        int g1 = 66;
        int h1 = 60;

        Location start = new Location(HIGHWAY_LENGTH / 2 - FROG_WIDTH / 2, HIGHWAY_BOTTOM + HIGHWAY_WIDTH / 6 - FROG_WIDTH / 2);
        Location l1 = new Location(0, HIGHWAY_TOP + (LANE_WIDTH - jeep) / 2);
        Location l2 = new Location(HIGHWAY_LENGTH, HIGHWAY_TOP + (LANE_WIDTH - f1) / 2 + LANE_WIDTH * 1);
        Location l3 = new Location(HIGHWAY_LENGTH, HIGHWAY_TOP + (LANE_WIDTH - g1) / 2 + LANE_WIDTH * 2);
        Location l4 = new Location(0, HIGHWAY_TOP + (LANE_WIDTH - h1) / 2 + LANE_WIDTH * 3);
        
        double v1 = .033 + (Math.random() * .1);
        double v2 = -(.033 + (Math.random() * .1));
        double v3 = -(.033 + (Math.random() * .1));
        double v4 = .033 + (Math.random() * .1);
        
        frog1 = new Frog(
        	    i,
        	    start,
        	    LANE_WIDTH,
        	    canvas
        	);
        	lane1 = new lane( // Change 'lane' to 'Lane'
        	    v1,
        	    k,
        	    h,
        	    l1,
        	    HIGHWAY_LENGTH,
        	    frog1,
        	    canvas
        	);
        	lane2 = new lane( // Change 'lane' to 'Lane'
        	    v2,
        	    f,
        	    g,
        	    l2,
        	    HIGHWAY_LENGTH,
        	    frog1,
        	    canvas
        	);
        	lane3 = new lane( // Change 'lane' to 'Lane'
        	    v3,
        	    f,
        	    g,
        	    l3,
        	    HIGHWAY_LENGTH,
        	    frog1,
        	    canvas
        	);


    }

    private void drawNoPassingLine(double y) {
        FilledRect topLine = new FilledRect(HIGHWAY_LEFT, y, HIGHWAY_LENGTH, LINE_WIDTH, canvas);
        topLine.setColor(Color.yellow);
        FilledRect bottomLine = new FilledRect(HIGHWAY_LEFT, y + LINE_WIDTH + LINE_SPACING, HIGHWAY_LENGTH, LINE_WIDTH, canvas);
        bottomLine.setColor(Color.yellow);
    }

    public void drawPassingLine(double y) {
        double x = HIGHWAY_LEFT;
        FilledRect dash;
        while (x < HIGHWAY_RIGHT) {
            dash = new FilledRect(x, y, DASH_LENGTH, LINE_WIDTH, canvas);
            dash.setColor(Color.white);
            x = x + DASH_LENGTH + DASH_SPACING;
        }
    }

    public void onMousePress(Location point) {
        if (frog1.isAlive()) {
            frog1.hopToward(point);
        } else if (point.getY() > 400) {
            frog1.reincarnate();
        }
    }

    public static void main(String[] args) {
        new Frogger().startController(500, 500);
    }
}
