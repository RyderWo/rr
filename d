import java.awt.Color;
import objectdraw.*;

public class Laundry extends WindowController {
    private FramedRect whites;
    private FramedRect darks;
    private FramedRect colors;
    private FramedRect laundry;
    private FilledRect clothesColor;
    private Text correctCounter;
    private Text incorrectCounter;
    private int correctAttempts;
    private int incorrectAttempts;
    private boolean placedCorrectly;

    public void begin() {
        whites = new FramedRect(125, 200, 50, 50, canvas);
        Text w = new Text("Whites", 130, 215, canvas);
        w.setFontSize(12);

        darks = new FramedRect(275, 200, 50, 50, canvas);
        Text d = new Text("Darks", 280, 215, canvas);
        d.setFontSize(12);

        colors = new FramedRect(425, 200, 50, 50, canvas);
        Text c = new Text("Colors", 432, 215, canvas);
        c.setFontSize(12);

        laundry = new FramedRect(275, 75, 50, 50, canvas);

        clothesColor = new FilledRect(275, 75, 50, 50, canvas);
        clothesColor.setColor(Color.WHITE);

        setRandomColor();

        correctCounter = new Text("Correct: " + correctAttempts, 125, 280, canvas);
        incorrectCounter = new Text("Incorrect: " + incorrectAttempts, 125, 300, canvas);
        correctCounter.setFontSize(12);
        incorrectCounter.setFontSize(12);
    }
    
    public static void main(String[] args) {
        Laundry d = new Laundry();
        d.startController(600, 400);
    }
    
    public void onMousePress(Location point) {
        // Assign point to l
        // loocation point = l;
    }
    
    public void onMouseDrag(Location l) {
        double dx = l.getX() - clothesColor.getX();
        double dy = l.getY() - clothesColor.getY();
        clothesColor.move(dx, dy);
        laundry.move(dx, dy);
        
        // Check if dragged outside canvas boundaries
        if (l.getX() < 0 || l.getX() > canvas.getWidth() || l.getY() < 0 || l.getY() > canvas.getHeight()) {
            incorrectAttempts++;
            updateCounters();
        }
    }

    public void onMouseRelease(Location point) {
        if (laundry.contains(point)) {
            if (laundry.overlaps(whites) && isLightColor(clothesColor.getColor())) {
                correctAttempts++;
                placedCorrectly = true;
            } else if (laundry.overlaps(darks) && isDarkColor(clothesColor.getColor())) {
                correctAttempts++;
                placedCorrectly = true;
            } else if (laundry.overlaps(colors) && !isLightColor(clothesColor.getColor()) && !isDarkColor(clothesColor.getColor())) {
                correctAttempts++;
                placedCorrectly = true;
            } else {
                placedCorrectly = false;
            }
        } else {
            placedCorrectly = false;
        }
        
        updateCounters();
        
        if (placedCorrectly) {
            clothesColor.moveTo(275, 75);
            laundry.moveTo(275, 75);
            setRandomColor();
        } else {
            clothesColor.moveTo(275, 75);
            laundry.moveTo(275, 75);
        }
    }

    private boolean isLightColor(Color color) {
        return color.getRed() > 200 && color.getGreen() > 200 && color.getBlue() > 200;
    }

    private boolean isDarkColor(Color color) {
        return color.getRed() < 100 && color.getGreen() < 100 && color.getBlue() < 100;
    }

    private void setRandomColor() {
        int red = (int) (Math.random() * 256);
        int green = (int) (Math.random() * 256);
        int blue = (int) (Math.random() * 256);
        
        if (Math.min(Math.min(red, green), blue) > 200) {
            clothesColor.setColor(Color.WHITE);
        } else if (Math.max(Math.max(red, green), blue) < 100) {
            clothesColor.setColor(Color.BLACK);
        } else {
            clothesColor.setColor(new Color(red, green, blue));
        }
    }

    private void updateCounters() {
        correctCounter.setText("Correct: " + correctAttempts);
        incorrectCounter.setText("Incorrect: " + incorrectAttempts);
    }
}
