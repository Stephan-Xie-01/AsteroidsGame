//your variable declarations here
Stars[] stars;
SpaceShip myspaceShip;
ArrayList <Asteroids> astList = new ArrayList <Asteroids>();
ArrayList <Bullets> buList = new ArrayList <Bullets>();

public void setup() 
{
  size(800,800);
  myspaceShip = new SpaceShip();
  stars = new Stars[200];
  for(int i = 0; i < stars.length; i++)
  {
  	stars[i] = new Stars();
  }
  for(int i = 0; i < 30; i++)
  {
  	astList.add(new Asteroids(i));
  }  //your code here
}

public boolean hyperspaceActive = true;
public boolean gameOver = false;
public boolean gameWin = false;
public int gameScore = 0;


public void draw() 
{
  background(0);
  //ship
  myspaceShip.show();
  myspaceShip.move();
  particle();
  
  //stars
  for(int i = 0; i < stars.length; i++)
  {
  	stars[i].show();
  }

//bullets
  for(int i = 0; i < buList.size(); i++)
  {
  	
  	buList.get(i).show();
  	buList.get(i).move();

  }
    //asteroids
  for(int i = astList.size() -1; i >= 0 ; i--)
  {
  	astList.get(i).show();
  	astList.get(i).move();

  	if(dist(myspaceShip.getX(),myspaceShip.getY(),astList.get(i).getX(),astList.get(i).getY()) < 20)
  	{
  		gameOver = true;
  		gameScore++;
  	}

  	for(int k = buList.size()-1; k >= 0 ; k--)
  	{
  		if(dist(astList.get(i).getX(),astList.get(i).getY(),buList.get(k).getX(),buList.get(k).getY()) < 10)
  		{
  			gameScore++;
  			astList.remove(i);
  			buList.remove(k);
  			break;
  		}
  	}

  }

 
  if(gameOver == true)
  {
  	myspaceShip.setX(400);
  	myspaceShip.setY(400);
  	myspaceShip.setPointDirection(-90);
  	myspaceShip.setDirectionX(0);
  	myspaceShip.setDirectionY(0);

  	gameScore = 0;

  	if(astList.size() == 0)
  	{
  		gameWin = true;
  	}
  	if(gameWin == true)
  	{
  		fill(153, 0, 76);
  		textSize(20);
  		text("WIN",400,400);
  	}
  }
  //your code here
}

public int wid = 10;
public int opac = 200;
public void particle()
{

	opac -= 15;

	fill(255,255,255, opac);
	noStroke();	

  	if(hyperspaceActive == true)
  	{
  		wid += 10;
  	}
  	if(wid > 60)
  	{
  		hyperspaceActive = false;

  	}



  	ellipse(myspaceShip.getX(),myspaceShip.getY(), wid, wid);
 
}
  		
public void keyPressed()
{
  	//acceleration
  	if(key == 'w')
  	{
  		myspaceShip.accelerate(0.2);
  		gameOver = false;
  	}
  	if(key == 's')
  	{
  		myspaceShip.accelerate(-0.2);
  		gameOver = false;
  	}
  	//rotate
  	if(key == 'e')
  	{
  		myspaceShip.rotate(15);
  		gameOver = false;
  	}
  	if(key == 'q')
  	{
  		myspaceShip.rotate(-15);
  		gameOver = false;
  	}
  	if(key == ' ')
  	{
  		myspaceShip.setX((int)(Math.random()*800));
  		myspaceShip.setY((int)(Math.random()*800));
  		myspaceShip.setPointDirection((int)(Math.random()*360));
  		myspaceShip.setDirectionX(0);
  		myspaceShip.setDirectionY(0);

  		wid = 0;
  		opac = 200;
  		hyperspaceActive = true;
  		gameOver = false;
  	}

}

public void mousePressed()
{
  	buList.add(new Bullets());
  	
}


class Bullets extends Floater
{
	double dRadians;
	public Bullets()
	{
		myCenterX = myspaceShip.getX();
		myCenterY = myspaceShip.getY();
        
		myPointDirection = myspaceShip.getPointDirection();
		dRadians = myPointDirection*(Math.PI/180);
		myDirectionX = (5* Math.cos(dRadians) + myspaceShip.getDirectionX());
		myDirectionY = (5* Math.sin(dRadians) + myspaceShip.getDirectionY());	
	}
	public void move()
	{
		myCenterX += myDirectionX;
		myCenterY += myDirectionY;
	}
	public void show()
	{
		fill(255);
		noStroke();
		ellipse(((float)myCenterX), ((float)myCenterY), 10,10);
	}
	public void setX(int x){myCenterX = x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){myCenterY = y;}
    public int getY(){return (int)myCenterY;}
	public void setDirectionX(double x){myDirectionX = x;}  
    public double getDirectionX(){return myDirectionX;}   
  	public void setDirectionY(double y){myDirectionY = y;}
  	public double getDirectionY(){return myDirectionY;}  
  	public void setPointDirection(int degrees){myPointDirection = degrees;}   
  	public double getPointDirection(){return myPointDirection;}	
}
class Asteroids extends Floater
{
	private int rotSpeed,myNum;
	public Asteroids(int a)
	{

		rotSpeed = (int)((Math.random()*10) -5);

		myColor = color(153, 0, 76);

		corners = 8;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = -11;
		xCorners[1] = 0;
		xCorners[2] = 7;
		xCorners[3] = 13;
		xCorners[4] = 6;
		xCorners[5] = 0;
		xCorners[6] = -11;
		xCorners[7] = -7;

		yCorners[0] = -8;
		yCorners[1] = -12;
		yCorners[2] = -8;
		yCorners[3] = 0;
		yCorners[4] = 10;
		yCorners[5] = 8;
		yCorners[6] = 10;
		yCorners[7] = 0;

		myCenterX = (Math.random()*800);
		myCenterY = (Math.random()*800);
		myDirectionX = (Math.random()*5) -2.5;
		myDirectionY = (Math.random()*5) -2.5;

		myNum = a;
	}
	public void setX(int x){myCenterX = x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){myCenterY = y;}
    public int getY(){return (int)myCenterY;}
	public void setDirectionX(double x){myDirectionX = x;}  
    public double getDirectionX(){return myDirectionX;}   
  	public void setDirectionY(double y){myDirectionY = y;}
  	public double getDirectionY(){return myDirectionY;}  
  	public void setPointDirection(int degrees){myPointDirection = degrees;}   
  	public double getPointDirection(){return myPointDirection;}

	public void move()
	{
		super.move();
		rotate(rotSpeed);
		
	}

}


class SpaceShip extends Floater  
{   
    public SpaceShip()
    {
    	corners = 8;
    	xCorners = new int[corners];
    	yCorners = new int[corners];
    	
    	xCorners[0] = -10;
    	xCorners[1] = 6;
    	xCorners[2] = 15;
    	xCorners[3] = 13;
    	xCorners[4] = 15;
    	xCorners[5] = 6;
    	xCorners[6] = -10;
    	xCorners[7] = -5;
    	
    	yCorners[0] = -9;
    	yCorners[1] = -9;
    	yCorners[2] = -2;
    	yCorners[3] = 0;
    	yCorners[4] = 2;
    	yCorners[5] = 9;
    	yCorners[6] = 9;
    	yCorners[7] = 0;
    	
    	myColor = color(255);
    	myCenterX = 400;
    	myCenterY = 400;
    	myDirectionX = 0;
    	myDirectionY = 0;
    	myPointDirection = -90;
    }//your code here

    public void setX(int x){myCenterX = x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){myCenterY = y;}
    public int getY(){return (int)myCenterY;}
	public void setDirectionX(double x){myDirectionX = x;}  
    public double getDirectionX(){return myDirectionX;}   
  	public void setDirectionY(double y){myDirectionY = y;}
  	public double getDirectionY(){return myDirectionY;}  
  	public void setPointDirection(int degrees){myPointDirection = degrees;}   
  	public double getPointDirection(){return myPointDirection;}
  
}

class Stars
{
		
		
		
	private int myX, myY, myColor, w;
	public Stars()
	{
		myX = ((int)(Math.random()*800));
		myY = ((int)(Math.random()*800));
		w = ((int)(Math.random()*10));

	}

	public void show()
	{
		noStroke();
		fill(255, (int)(Math.random()*255), (int)(Math.random()*255));
		ellipse(myX, myY, w, w);
	}

}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x); 
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX > width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX < 0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY > height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
