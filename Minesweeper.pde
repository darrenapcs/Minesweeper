import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs  = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int col = 0; col < NUM_COLS; col ++)
        for(int row = 0; row < NUM_ROWS; row ++)
          buttons[row][col] = new MSButton(row,col);
    for(int bomb = 0; bomb < 40; bomb++)
        setBombs();


}
public void setBombs()
{
   int row = (int)(Math.random()*20);
   int col = (int)(Math.random()*20);
  if(!bombs.contains(buttons[row][col]))
     bombs.add(buttons[row][col]); 
  else
    setBombs();
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{

    for(int r = 0; r < NUM_ROWS; r ++)
    {
        for(int c = 0; c < NUM_COLS; c ++)
        {
            if(!bombs.contains(buttons[r][c]) && buttons[r][c].isClicked() == false)
            {
              return false;
            }
        }
    }

    return true;
}
public void displayLosingMessage()
{
        for(int r = 0; r < NUM_ROWS; r ++)
    {
        for(int c = 0; c < NUM_COLS; c ++)
        {
            if(bombs.contains(buttons[r][c]) && buttons[r][c].isClicked() == true )
            {

             buttons[10][6].setLabel("Y");
             buttons[10][7].setLabel("O");
             buttons[10][8].setLabel("U");
             buttons[10][10].setLabel("L");
             buttons[10][11].setLabel("O");
             buttons[10][12].setLabel("S");
             buttons[10][13].setLabel("E");
             noLoop();
            }
        }
    }
}
public void displayWinningMessage()
{
    buttons[10][6].setLabel("Y");
    buttons[10][7].setLabel("O");
    buttons[10][8].setLabel("U");
    buttons[10][10].setLabel("W");
    buttons[10][11].setLabel("I");
    buttons[10][12].setLabel("N");
    buttons[10][13].setLabel("!");
    noLoop();
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true)
            marked = !marked;

        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c) > 0)
        {
            
            setLabel(str(countBombs(r,c)));
            
        }
        else
        {
           if(isValid(r-1,c) && !buttons[r-1][c].clicked)
            {
            buttons[r-1][c].mousePressed();
            }         
           if(isValid(r+1,c) && !buttons[r+1][c].clicked)
            {
            buttons[r+1][c].mousePressed();
            }
           if(isValid(r,c-1) && !buttons[r][c-1].clicked)
            {
            buttons[r][c-1].mousePressed();
            }
           if(isValid(r,c+1) && !buttons[r][c+1].clicked)
            {
            buttons[r][c+1].mousePressed();
            }
           if(isValid(r-1,c-1) && !buttons[r-1][c-1].clicked)
            {
            buttons[r-1][c-1].mousePressed();
            }
           if(isValid(r+1,c-1) && !buttons[r+1][c-1].clicked)
            {
            buttons[r+1][c-1].mousePressed();
            }
           if(isValid(r-1,c+1) && !buttons[r-1][c+1].clicked)
            {
            buttons[r-1][c+1].mousePressed();
            }
           if(isValid(r+1,c+1) && !buttons[r+1][c+1].clicked)
            {
            buttons[r+1][c+1].mousePressed();
            }
         }   
        


        //your code here
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);

    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
            return true;
        return false;
    }
    public int countBombs(int row, int col) 
    {
       int numBombs = 0;
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
        {
        numBombs +=1;
        }
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
        {
        numBombs +=1;
        }
       if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
        {
        numBombs +=1;
        } 
       if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
        {
        numBombs +=1;
        }
       if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
        {
        numBombs +=1;
        }
       if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
        {
        numBombs +=1;  
        }
       if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
        {
        numBombs +=1;
        }
       if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
        {
        numBombs +=1; 
        }             
     return numBombs;
     }
}



