class Line{
  PVector oldLoc,soFar=new PVector();
  void move(int soFarStep,int indexStep){
    PVector loc=new PVector();
    color col;
    float t=1.0*(frameCount%numFrames-soFarStep*(lines.indexOf(this)+indexStep))/numFrames;
    soFar=PVector.fromAngle(2*(float)Math.PI*t);
    soFar.setMag(8);//map(getOpenNoiseValues(t,0,1,soFarStep,indexStep)[0],-1,1,0,t*numFrames));
    if(openSimplex){
      float[] coords=getOpenNoiseValues(soFar.x,soFar.y,2,soFarStep,indexStep);
      float[] colVals=getOpenNoiseValues(soFar.x,soFar.y,3,soFarStep,indexStep);
      coords[0]=map(coords[0],-1,1,0,width);
      coords[1]=map(coords[1],-1,1,0,height);
      for(int i=0;i<colVals.length;i++)
        colVals[i]=map(colVals[i],-1,1,0,255);
      loc.set(coords[0],coords[1]);
      col=color(colVals[0],colVals[1],colVals[2]);
    }else{
      float[] coords=getNoiseValues(soFar.x,2,soFarStep,indexStep);
      float[] colVals=getNoiseValues(soFar.x,3,soFarStep,indexStep);
      col=color(255*colVals[0],255*colVals[1],255*colVals[2]);
      loc.set(width*coords[0],height*coords[1]);
    }
    try{
      oldLoc.add(0,0);
    }catch(NullPointerException e){
      oldLoc=loc.copy();
    }
    stroke(col);
    line(oldLoc.x,oldLoc.y,loc.x,loc.y);
    oldLoc=loc.copy();
  }
}