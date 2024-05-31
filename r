import objectdraw.*;
import java.awt.*;

public class vehicle extends ActiveObject {
    private VisibleImage vImage;
    private Location start;
    private double laneLength;
    private double v;
    private Frog frog;
    private DrawingCanvas canvas;

    public vehicle(Image k, Location point, double vel, double laneLength, Frog frog1, DrawingCanvas canvas) {
        vImage = new VisibleImage(k, point, canvas);
        start = point;
        this.laneLength = laneLength;
        v = vel;
        frog = frog1;
        this.canvas = canvas;
        start();
    }

    public void run() {
        long timeC = System.currentTimeMillis();
        while (vImage.getX() <= laneLength && vImage.getX() >= 0) {
            pause(30);
            long timeN = System.currentTimeMillis() - timeC;
            int timeD = (int) (timeN);
            vImage.move(v * timeD, 0);
            if (frog.overlaps(vImage)) {
                frog.kill(canvas);
            }
        }
        vImage.removeFromCanvas();
    }
}
